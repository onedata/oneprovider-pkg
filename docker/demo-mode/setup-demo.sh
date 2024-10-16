#!/bin/bash

source /root/demo-mode/demo-common.sh
source /root/demo-mode/better-curl.sh

TOKEN_FILE="/root/registration-token.txt"
POSIX_STORAGE_MOUNT_POINT="/volumes/storage"

ONEPROVIDER_DOMAIN="oneprovider.internal"  # do not use .local as it messes with some DNS setups

ONEZONE_IP=$1
HOSTNAME=$(hostname)
PROVIDER_IP=$(hostname -I | tr -d ' ')

main() {
    echo -e "\e[1;33m"
    echo "-------------------------------------------------------------------------"
    echo "Starting Oneprovider in demo mode..."
    echo "The IP address is: $PROVIDER_IP"
    echo "When the service is ready, an adequate log will appear here."
    echo "You may also use the await script: \"docker exec \$CONTAINER_ID await-demo\"."
    echo "-------------------------------------------------------------------------"
    echo -e "\e[0m"

    sed "s/${HOSTNAME}\$/${HOSTNAME}-node.${ONEPROVIDER_DOMAIN} ${HOSTNAME}-node/g" /etc/hosts > /tmp/hosts.new
    cat /tmp/hosts.new > /etc/hosts
    rm /tmp/hosts.new
    echo "127.0.1.1 ${HOSTNAME}.${ONEPROVIDER_DOMAIN} ${HOSTNAME}" >> /etc/hosts
    echo "${ONEZONE_IP} ${ONEZONE_DOMAIN}" >> /etc/hosts

    # A simple heuristic to check if the DNS setup in the current docker runtime is
    # acceptable; there is a known issue: if DNS lookups about the machine's FQDN
    # take too long (or time out), couchbase will take ages to start.
    START_TIME_NANOS=$(date +%s%N)
    timeout 2 nslookup "$(hostname -f)" > /dev/null
    LOOKUP_TIME_MILLIS=$((($(date +%s%N) - START_TIME_NANOS) / 1000000))
    if [ "$LOOKUP_TIME_MILLIS" -gt 1000 ]; then
        echo "-------------------------------------------------------------------------"
        echo "The DNS config in your docker runtime may cause problems with the Couchbase DB startup"
        echo "since queries about the container's FQDN take too long."
        echo ""
        echo "Overriding the container's resolv.conf with 8.8.8.8 to avoid that."
        echo "-------------------------------------------------------------------------"
        echo ""
        echo "8.8.8.8" > /etc/resolv.conf
    fi

    # all certs in the demo env are self-signed, skip any verification
    echo '[{ctool, [{force_insecure_connections, true}]}].' > /etc/op_panel/config.d/disable-ssl-verification.config
    echo '[{ctool, [{force_insecure_connections, true}]}].' > /etc/op_worker/config.d/disable-ssl-verification.config

    chmod 777 "${POSIX_STORAGE_MOUNT_POINT}"

    # Oneprovider batch installation config
    export ONEPANEL_DEBUG_MODE="true" # prevents container exit on configuration error
    export ONEPANEL_BATCH_MODE="true"
    export ONEPANEL_LOG_LEVEL="info" # prints logs to stdout (possible values: none, debug, info, error), by default set to info
    export ONEPANEL_EMERGENCY_PASSPHRASE="password"
    export ONEPANEL_GENERATE_TEST_WEB_CERT="true"  # default: false
    export ONEPANEL_GENERATED_CERT_DOMAIN="${ONEPROVIDER_DOMAIN}"  # default: ""
    export ONEPANEL_TRUST_TEST_CA="true"  # default: false

    export ONEPROVIDER_CONFIG=$(cat <<EOF
        cluster:
          domainName: "${ONEPROVIDER_DOMAIN}"
          nodes:
            n1:
              hostname: "${HOSTNAME}"
          managers:
            mainNode: "n1"
            nodes:
              - "n1"
          workers:
            nodes:
              - "n1"
          databases:
            # set the lowest possible ram quota for couchbase for a lightweight deployment
            serverQuota: 256  # per-node Couchbase cache size in MB for all buckets
            bucketQuota: 256  # per-bucket Couchbase cache size in MB across the cluster
            nodes:
              - "n1"
          storages:
            posix:
              type: "posix"
              mountPoint: "${POSIX_STORAGE_MOUNT_POINT}"
        oneprovider:
          geoLatitude: 0.0
          geoLongitude: 0.0
          register: true
          name: "demo-provider"
          adminEmail: "admin@${ONEPROVIDER_DOMAIN}"
          tokenProvisionMethod: "fromFile"
          tokenFile: "${TOKEN_FILE}"
          # Use built-in Let's Encrypt client to obtain and renew certificates
          letsEncryptEnabled: false
          # Automatically register this Oneprovider in Onezone without subdomain delegation
          subdomainDelegation: false
          domain: "${PROVIDER_IP}"

        onezone:
          domainName: "${ONEZONE_IP}"
EOF
)
    # After the main process finishes here, the Oneprovider entrypoint is run.

    # Run all the other procedures in an async process (so the service can already start booting)
    {
        if ! await-demo-onezone; then
            exit_and_kill_docker
        fi

        ADMIN_ID=$(success_curl -u admin:password "https://${ONEZONE_DOMAIN}/api/v3/onezone/user" | jq -r .userId)

        # multiple providers can be run in demo mode, they will get unique numbers this way
        # (named tokens must have unique names, so this loop acts as a critical section)
        PROVIDER_NUMBER=1
        while [[ -z "${REG_TOKEN}" ]]; do
            CURL_RESULT=$(do_curl -u admin:password \
                "https://${ONEZONE_DOMAIN}/api/v3/onezone/user/tokens/named" \
                -X POST -H 'Content-type: application/json' -d '
                    {
                        "name": "Oneprovider registration token '"${PROVIDER_NUMBER}"'",
                        "type": {
                            "inviteToken": {
                                "inviteType": "registerOneprovider",
                                "adminUserId": "'"${ADMIN_ID}"'"
                            }
                        }
                    }')
            if [[ "$?" -eq 0 ]]; then
                REG_TOKEN=$(echo "${CURL_RESULT}" | jq -r .token)
            fi
            if [[ -z "$REG_TOKEN" ]]; then
                PROVIDER_NUMBER=$((PROVIDER_NUMBER + 1))
                sleep 0.2
            fi
        done

        echo "-------------------------------------------------------------------------"
        echo "Registration token: ${REG_TOKEN}"
        echo "-------------------------------------------------------------------------"
        echo "${REG_TOKEN}" >> "${TOKEN_FILE}"

        DEMO_SPACE_ID=$(ensure_demo_space)
        if [[ -z "$DEMO_SPACE_ID" ]]; then
            # retry once, for some reason it may fail (unidentified race condition?)
            sleep 1
            DEMO_SPACE_ID=$(ensure_demo_space)
            if [[ -z "$DEMO_SPACE_ID" ]]; then
                echo "ERROR: Cannot resolve the demo space"
                exit_and_kill_docker
            fi
        fi

        if ! await; then
            exit_and_kill_docker
        fi

        ACCESS_TOKEN=$(demo-access-token)

        OP_NAME=$(get_provider_data ${PROVIDER_NUMBER} | cut -d':' -f1)
        OP_LATITUDE=$(get_provider_data ${PROVIDER_NUMBER} | cut -d':' -f2)
        OP_LONGITUDE=$(get_provider_data ${PROVIDER_NUMBER} | cut -d':' -f3)
        success_curl "https://${PROVIDER_IP}/api/v3/onepanel/provider" \
            -H "x-auth-token: $ACCESS_TOKEN" -X PATCH -H "Content-Type: application/json" \
            -d '{
                "name": "'"${OP_NAME}"'",
                "geoLatitude": "'"${OP_LATITUDE}"'",
                "geoLongitude": "'"${OP_LONGITUDE}"'"
            }' > /dev/null

        SUPPORT_TOKEN=$(success_curl -u admin:password \
            "https://${ONEZONE_DOMAIN}/api/v3/onezone/user/tokens/temporary" \
            -X POST -H 'Content-type: application/json' -d '{
                "type": {
                    "inviteToken": {
                        "inviteType": "supportSpace",
                        "spaceId": "'"${DEMO_SPACE_ID}"'"
                    }
                },
                "caveats": [{"type": "time", "validUntil": '$(($(date +%s) + 3600))'}]
            }' | jq -r .token)

        STORAGE_ID=$(success_curl -H "x-auth-token: $ACCESS_TOKEN" "https://${PROVIDER_IP}/api/v3/onepanel/provider/storages" | jq -r '.ids[0]')

        success_curl "https://${PROVIDER_IP}/api/v3/onepanel/provider/spaces" \
            -H "x-auth-token: $ACCESS_TOKEN" -X POST -H "Content-Type: application/json" \
            -d '{"token":"'"${SUPPORT_TOKEN}"'", "size": 10737418240, "storageId": "'"${STORAGE_ID}"'"}' > /dev/null

        if ! await-demo; then
            exit_and_kill_docker
        fi

        echo -e "\e[1;32m"
        echo "-------------------------------------------------------------------------"
        echo "Demo Oneprovider service is ready! Visit the Onezone GUI in your browser:"
        echo "  URL:      https://${ONEZONE_IP}"
        echo "  username: admin"
        echo "  password: password"
        echo "  note:     you must add an exception for the untrusted certificate"
        echo ""
        echo "From there, you can access the demo space and manage the Oneprovider cluster."
        echo "To interact with the APIs or mount a Oneclient, use the provider IP: ${PROVIDER_IP}"
        echo "-------------------------------------------------------------------------"
        echo -e "\e[0m"
    } &

}

ensure_demo_space() {
    # by using the idGeneratorSeed, we make sure the space is created only once
    # (it will always get the same id, but after the first creation, the request
    # will return an "already exists" error)
    do_curl -k -u admin:password "https://${ONEZONE_DOMAIN}/api/v3/onezone/user/spaces" \
        -H "Content-type: application/json" -X POST \
        -d '{ "name" : "demo-space", "idGeneratorSeed" : "demo-space" }' > /dev/null

    SPACES=$(success_curl -u admin:password "https://${ONEZONE_DOMAIN}/api/v3/onezone/user/spaces" | jq -r '.spaces | join(" ")')
    for SPACE_ID in $SPACES; do
        NAME=$(success_curl -u admin:password "https://${ONEZONE_DOMAIN}/api/v3/onezone/user/spaces/$SPACE_ID" | jq -r '.name')
        if [[ "$NAME" == "demo-space" ]]; then
            echo "$SPACE_ID"
            break
        fi
    done
}

get_provider_data() {
    case "${1}" in
        1) echo "Krakow:50.049683:19.944544" ;;
        2) echo "Lisbon:38.736946:-9.142685" ;;
        3) echo "Paris:48.864716:2.349014" ;;
        4) echo "Bari:41.125278:16.866667" ;;
        *) echo "Demo ${1}:$((RANDOM % 135 - 55)):$((RANDOM % 320 - 150))" ;;
    esac
}

main "$@"

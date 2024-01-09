#!/bin/bash

IP=$(hostname -i)
echo -e "\e[1;33m"
echo "-------------------------------------------------------------------------"
echo "Starting Oneprovider in demo mode..."
echo "Visit https://${IP}/ in your browser (ignore the untrusted cert)," 
echo "but *when the service has booted up*! It may take a minute or two."
echo "You may also add such an entry to /etc/hosts: \"${IP} oneprovider.local\"" 
echo "and visit https://oneprovider.local, because for some browsers"
echo "the UI may not function correctly when using the IP address."
echo "-------------------------------------------------------------------------"
echo -e "\e[0m"

HN=`hostname`
export ONEPANEL_DEBUG_MODE="true" # prevents container exit on configuration error
export ONEPANEL_BATCH_MODE="true"
export ONEPANEL_LOG_LEVEL="info" # prints logs to stdout (possible values: none, debug, info, error), by default set to info
export ONEPANEL_EMERGENCY_PASSPHRASE="password"
export ONEPANEL_GENERATE_TEST_WEB_CERT="true"  # default: false
export ONEPANEL_GENERATED_CERT_DOMAIN="oneprovider.local"  # default: ""
export ONEPANEL_TRUST_TEST_CA="true"  # default: false

ADMIN_ID=$(curl -v -k -u "admin:password" https://onezone.local/api/v3/onezone/user | jq -r .userId)
REG_TOKEN=$(curl -k -v -u admin:password -X POST -d '{"type": {"inviteToken": {
      "inviteType": "registerOneprovider",
      "adminUserId": "'${ADMIN_ID}'"
    }
}, "caveats": [{"type": "time", "validUntil": '$(($(date +%s) + 3600))'}]}' -H 'Content-type: application/json' https://onezone.local/api/v3/onezone/user/tokens/temporary | jq -r .token)

export ONEPROVIDER_CONFIG=$(cat <<EOF
        cluster:
          domainName: "oneprovider.local"
          nodes:
            n1:
              hostname: "${HN}"
          managers:
            mainNode: "n1"
            nodes:
              - "n1"
          workers:
            nodes:
              - "n1"
          databases:
            # Per node Couchbase cache size in MB for all buckets
            serverQuota: 4096
            # Per bucket Couchbase cache size in MB across the cluster
            bucketQuota: 1024
            nodes:
              - "n1"
        oneprovider:
          geoLatitude: 50.0646501 # TODO: get coords automatically
          geoLongitude: 19.9449799
          # geoLatitude: {{latitude}}
          # geoLongitude: {{longitude}}
          register: true
          name: "oneprovider"
          adminEmail: "admin@oneprovider.local"
          token: "${REG_TOKEN}"
          # Use built-in Let's Encrypt client to obtain and renew certificates
          letsEncryptEnabled: false
          # Automatically register this Oneprovider in Onezone without subdomain delegation
          subdomainDelegation: false
          domain: "oneprovider.local"

          # Alternatively:
          ## Automatically register this Oneprovider in Onezone with subdomain delegation
          # subdomainDelegation: true
          # subdomain: {{ subdomain }} # Domain will be {{ subdomain }}.{{ domain }}

        onezone:
          domainName: "onezone.local"
EOF
)
sed "s/${HN}\$/${HN}-node.oneprovider.local ${HN}-node/g" /etc/hosts > /tmp/hosts.new
cat /tmp/hosts.new > /etc/hosts
rm /tmp/hosts.new
echo "127.0.1.1 ${HN}.oneprovider.local ${HN}" >> /etc/hosts
    

#!/bin/bash

IP=$(hostname -i)
export ONEZONE_IP=$1
read -r -d '' -a OP_RECORDS << EOF
krakow:50.049683:19.944544
lisbon:38.736946:-9.142685
paris:48.864716:2.349014
bari:41.125278:16.866667
EOF

HN=`hostname`
sed "s/${HN}\$/${HN}-node.oneprovider.local ${HN}-node/g" /etc/hosts > /tmp/hosts.new
cat /tmp/hosts.new > /etc/hosts
rm /tmp/hosts.new
echo "127.0.1.1 ${HN}.oneprovider.local ${HN}" >> /etc/hosts
echo ${ONEZONE_IP} onezone.local >> /etc/hosts    
chmod 777 /volumes/storages

echo -e "\e[1;33m"
echo "-------------------------------------------------------------------------"
echo "Starting Oneprovider in demo mode..."
echo "When the service is ready, an adequate log will appear here."
echo "-------------------------------------------------------------------------"
echo -e "\e[0m"

export ONEPANEL_DEBUG_MODE="true" # prevents container exit on configuration error
export ONEPANEL_BATCH_MODE="true"
export ONEPANEL_LOG_LEVEL="info" # prints logs to stdout (possible values: none, debug, info, error), by default set to info
export ONEPANEL_EMERGENCY_PASSPHRASE="password"
export ONEPANEL_GENERATE_TEST_WEB_CERT="true"  # default: false
export ONEPANEL_GENERATED_CERT_DOMAIN="oneprovider.local"  # default: ""
export ONEPANEL_TRUST_TEST_CA="true"  # default: false

if ! await-oz; then
    echo -e "\e[1;31m"
    echo "-------------------------------------------------------------------------"
    echo "Onezone is not started or bad IP is supplied. Giving up!"
    echo "-------------------------------------------------------------------------"
    echo -e "\e[0m"
    kill -9 "$(pgrep -f /root/oneprovider.py)"
    exit 1
fi

ADMIN_ID=$(curl -v -k -u "admin:password" https://onezone.local/api/v3/onezone/user | jq -r .userId)
REG_TOKEN=$(curl -k -v -u admin:password https://onezone.local/api/v3/onezone/user/tokens/temporary \
-X POST -H 'Content-type: application/json' -d '{"type": {"inviteToken": {
      "inviteType": "registerOneprovider",
      "adminUserId": "'${ADMIN_ID}'"
    }
}, "caveats": [{"type": "time", "validUntil": '$(($(date +%s) + 3600))'}]}' | jq -r .token)
AUTH_TOKEN=$(curl -k -v -u admin:password https://onezone.local/api/v3/onezone/user/tokens/temporary \
		  -X POST -H 'Content-type: application/json' -d '{"type": {"accessToken": {}}, 
   	          "caveats": [{"type": "time", "validUntil": '$(($(date +%s) + 3600))'}]}' | jq -r .token)

OP_NUM=$(curl -v -k -u "admin:password" https://onezone.local/api/v3/onezone/providers | jq '.providers | length')
OP_NAME=$(echo ${OP_RECORDS[$OP_NUM]} | cut -d':' -f1)
OP_LATITUDE=$(echo ${OP_RECORDS[$OP_NUM]} | cut -d':' -f2)
OP_LONGITUDE=$(echo ${OP_RECORDS[$OP_NUM]} | cut -d':' -f3)

SPACES_NUM=$(curl -k -u admin:password -X GET https://onezone.local/api/v3/onezone/spaces \
		 | jq '.spaces | length')
case ${SPACES_NUM} in
    0)
	# Create new space
	curl -k -u admin:password -H "Content-type: application/json" -X POST \
	     -d '{ "name" : "demo-space" }' https://onezone.local/api/v3/onezone/user/spaces
	;;
    1)
	# Space already created. Do nothing.
	;;
    *)
	# Unexpected state (error)
	echo "Unexpected number of spaces. No space support will be done."
	export SUPPORT=false	     	    
	;;			     
esac

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
            bucketQuota: 4096
            nodes:
              - "n1"
          storages:
            posix:
              type: "posix"
              mountPoint: "/volumes/storage"
        oneprovider:
          geoLatitude: ${OP_LATITUDE}
          geoLongitude: ${OP_LONGITUDE}
          register: true
          name: "${OP_NAME}"
          adminEmail: "admin@oneprovider.local"
          token: "${REG_TOKEN}"
          # tokenProvisionMethod: "fromFile"
          # tokenFile: /root/registration-token.txt
          # Use built-in Let's Encrypt client to obtain and renew certificates
          letsEncryptEnabled: false
          # Automatically register this Oneprovider in Onezone without subdomain delegation
          subdomainDelegation: false
          domain: "${IP}"

          # Alternatively:
          ## Automatically register this Oneprovider in Onezone with subdomain delegation
          # subdomainDelegation: true
          # subdomain: {{ subdomain }} # Domain will be {{ subdomain }}.{{ domain }}

        onezone:
          domainName: "onezone.local"
EOF
)

# Run an async process to await service readiness
{
    if ! await-op; then
        kill -9 "$(pgrep -f /root/oneprovider.py)"
        exit 1
    fi
    

    if ${SUPPORT}; then
	# Get space-demo id
	SPACE_ID=$(curl -k -u admin:password -X GET https://onezone.local/api/v3/onezone/user/spaces \
		       | jq -r '.spaces[0]')
	TIME_MS=$(curl -k -v  https://onezone.local/api/v3/onezone/provider/public/get_current_time | jq .timeMillis)
	let TIME_CAVEAT=${TIME_MS}/1000+3600
	SUPPORT_TOKEN=$(curl -k -v -u admin:password -X POST -d \
			     '{
 			     "type": {
			      	"inviteToken": {	  	  
			          "inviteType": "supportSpace",
				  "spaceId": "'${SPACE_ID}'"
			         }
			     },
			     "caveats": [
    			   	         {
				           "type": "time",
					   "validUntil": '${TIME_CAVEAT}'
				         }
				        ]
			     }'\
				 -H 'Content-type: application/json'\
				 https://onezone.local/api/v3/onezone/user/tokens/temporary | jq -r .token)
	STORAGE_ID=$(curl -k -H "X-AUTH-TOKEN: $AUTH_TOKEN" https://${IP}/api/v3/onepanel/provider/storages | jq -r .ids[0])
	curl -v -k -H "X-AUTH-TOKEN: $AUTH_TOKEN" -X POST -H "Content-Type: application/json" \
	     https://${IP}/api/v3/onepanel/provider/spaces\
	     -d '{"token":"'$SUPPORT_TOKEN'", "size": 10000000000, "storageId": "'$STORAGE_ID'"}'
    fi

    if [ $(curl -k -v https://${IP}/api/v3/onepanel/configuration |\
	       jq '. | select(.deployed and .isRegistered) | length')0 -gt 0 ]; then
	echo -e "\e[1;32m"
	echo "-------------------------------------------------------------------------"
	echo "Oneprovider service is ready!"
	echo "You can manage the Oneprovider cluster from the Onezone Web GUI"
	echo "-------------------------------------------------------------------------"
	echo -e "\e[0m"
    else
	echo -e "\e[1;31m"
	echo "-------------------------------------------------------------------------"
	echo "Oneprovider service has not been properly deployed!"
	echo "-------------------------------------------------------------------------"
	echo -e "\e[0m"
    fi
} &

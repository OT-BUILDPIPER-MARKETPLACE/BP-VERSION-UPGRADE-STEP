#!/bin/bash

source functions.sh
source log-functions.sh
source str-functions.sh
source file-functions.sh
source aws-functions.sh

if [ -f "key.pem" ]; then
   true
else
   echo -e "$PRIVATE_KEY_FILE" > key.pem
   sed -i 's/ \+/\'$'\n/g' key.pem && sed -i '1,4d' key.pem 
   sed -i '1 i -----BEGIN RSA PRIVATE KEY-----' key.pem && sed -i '27,30d' key.pem 
   echo "-----END RSA PRIVATE KEY-----" >> key.pem && chmod 400 key.pem
fi 

sleep $SLEEP_DURATION

SERVER="ssh $USERNAME@$IP_ADDRESS -i key.pem -p $SSH_PORT -o stricthostkeychecking=no"

OLD_VERSION=$( ${SERVER} "grep -o 'registry.buildpiper.in/*[^ ]*' ${FILE_PATH}" | awk -F: '{print $2}' | uniq)

logInfoMessage "I'll upgrade the buildpiper version"
logInfoMessage "Received below arguments"
logInfoMessage "Current version: $OLD_VERSION"
logInfoMessage "Latest version: $NEW_VERSION"

if [ "$OLD_VERSION" != "$NEW_VERSION" ]; then
   logInfoMessage "Upgrading version"
   $SERVER "sed -i 's/$OLD_VERSION/$NEW_VERSION/g' $FILE_PATH"
   $SERVER "cd deploy_buildpiper && docker-compose up -d"
   logInfoMessage "Congratulations Buildpiper version has been successfully upgraded!!!"
   generateOutput ${ACTIVITY_SUB_TASK_CODE} true "Congratulations Buildpiper version has been successfully upgraded!!!"
else
   logInfoMessage "Buildpiper version is up to date!!!"
   generateOutput ${ACTIVITY_SUB_TASK_CODE} false "Buildpiper version is up to date!!!"
fi

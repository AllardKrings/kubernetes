#!/bin/bash
ITOP_URL="http://itop.alldcs.nl"
ITOP_USER="tekton"
ITOP_PWD="Itop01@@@"
ORGANIZATION="0001"
TITLE="Containerchange"
DESCRIPTION="Container  created"
CALLER="0001"
COMMENT="new version of container olproperties has been pushed"
CHANGE="RoutineChange"
      # Let's create the ticket via the REST/JSON API
JSON_DATA='{"operation":"core/create", "class":"'"${CHANGE}"'", "fields": {"org_id":"'"${ORGANIZATION}"'", "title":"'"$TITLE"'", "description":"'"$DESCRIPTION"'"}, "caller": "'"$CALLER"'", "comment": "'"$COMMENT"'"}'
RESULT=`wget -q --post-data='auth_user='"${ITOP_USER}"'&auth_pwd='"${ITOP_PWD}"'&json_data='"${JSON_DATA}" --no-check-certificate -O -  "${ITOP_URL}/webservices/rest.php?version=1.0"`
echo "$RESULT" | jq '.key'
if echo "$RESULT" | grep "created" 
    then
         echo "Change created successfully"
    else
         echo "ERROR: failed to create change"
         echo $RESULT
fi

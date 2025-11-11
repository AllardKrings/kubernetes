#!/bin/bash
##################################################################################
#                                                                                #
# Example script for creating a UserRequest ticket via the REST/JSON webservices #
#                                                                                #
##################################################################################
 
# iTop location and credentials, change them to suit your iTop installation
ITOP_URL="https://itop.alldcs.nl"
ITOP_USER="allard"
ITOP_PWD="Itop01@@@"
ORGANIZATION="0001"
TITLE="UserRequest"
DESCRIPTION="Container created"
CALLER="0001"
COMMENT="commentaar"
CHANGE="RoutineChange"
# Let's create the ticket via the REST/JSON API
JSON_DATA='{"operation":"core/create", "class":"'"${CHANGE}"'", "fields": {"org_id":"'"${ORGANIZATION}"'", "title":"'"$TITLE"'", "description":"'"$DESCRIPTION"'"}, "caller": "'"$CALLER"'", "comment": "'"$COMMENT"'"}'
RESULT=`wget -q --post-data='auth_user='"${ITOP_USER}"'&auth_pwd='"${ITOP_PWD}"'&json_data='"${JSON_DATA}" --no-check-certificate -O -  "${ITOP_URL}/webservices/rest.php?version=1.0"`
#PATTERN='"key":"([0-9])+"'
#if [[ $RESULT =~ $PATTERN ]]; then
#         echo "Change created successfully"
#    else
#         echo "ERROR: failed to create change"
#         echo $RESULT
#fi

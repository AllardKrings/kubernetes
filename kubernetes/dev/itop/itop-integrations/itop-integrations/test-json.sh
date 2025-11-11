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
 
 
# Parameters checking, see below for default values
if [ "$1" == "" ]; then
        echo "Missing parameter 1: host"
        exit -1
else
        HOST="$1"
fi
 
if [ "$2" == "" ]; then
        echo "Missing parameter 2: Service"
        exit -1
else
        SERVICE="$2"
fi
 
if [ "$3" == "" ]; then
        echo "Missing parameter 3: Service Status"
        exit -1
else
        SERVICE_STATUS="$3"
fi
 
if [ "$4" == "" ]; then
        echo "Missing parameter 4: Service State Type"
        exit -1
else
        SERVICE_STATUS_TYPE="$4"
fi
 
# Default values, adapt them to your configuration
TICKET_CLASS="UserRequest"
ORGANIZATION="SELECT Organization JOIN FunctionalCI AS CI ON CI.org_id=Organization.id WHERE CI.name='"${HOST}"'"
TITLE="Service Down on $1"
DESCRIPTION="The service $SERVICE is in state $SERVICE_STATUS on $HOST"
 
# Let's create the ticket via the REST/JSON API
if [[ ( "$SERVICE_STATUS" != "OK" ) && ( "$SERVICE_STATUS" != "UP" ) && ( "$SERVICE_STATUS_TYPE" == "HARD" ) ]]; then
        CIS_LIST='[{"functionalci_id":"SELECT FunctionalCI WHERE  name=\"'"$1"'\"", "impact_code": "manual"}]'
        JSON_DATA='{"operation":"core/create", "class":"'"${TICKET_CLASS}"'", "fields": {"functionalcis_list":'"${CIS_LIST}"', "org_id":"'"${ORGANIZATION}"'", "title":"'"$TITLE"'", "description":"'"$DESCRIPTION"'"}, "comment": "Created by the Monitoring", "output_fields": "id"}'
 
        RESULT=`wget -q --post-data='auth_user='"${ITOP_USER}"'&auth_pwd='"${ITOP_PWD}"'&json_data='"${JSON_DATA}" --no-check-certificate -O -  "${ITOP_URL}/webservices/rest.php?version=1.0"`
 
        PATTERN='"key":"([0-9])+"'
        if [[ $RESULT =~ $PATTERN ]]; then
                echo "Ticket created successfully"
        else
                echo "ERROR: failed to create ticket"
                echo $RESULT
        fi
else
        echo "Service State Type != HARD, doing nothing"
fi

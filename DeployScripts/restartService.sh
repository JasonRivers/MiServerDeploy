#!/bin/bash

SERVICE_NAME="$1" ##Service name to restart
LOG_LOCATION=/tmp/MiDeploy.log ##Default log location

{

echo "Restarting Service ${SERVICE_NAME}: `date`"
/etc/init.d/${SERVICE_NAME} restart

echo "Finished: `date`"
}>> ${LOG_LOCATION}  2>&1

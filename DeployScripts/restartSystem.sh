#!/bin/bash

LOG_LOCATION=/tmp/MiDeploy.log ##Default log location

{

echo "Received request to restart system: `date`"

shutdown -r now


} >> ${LOG_LOCATION} 2>&1



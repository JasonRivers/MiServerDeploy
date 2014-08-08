#!/bin/bash

## This could fail if the git pull errors, Error checking needs to be added

GH_LOCATION=$1 ## Location of the Github cloned repository
LOG_LOCATION=/tmp/MiDeploy.log ##Default log location


cd ${GH_LOCATION}
{
echo "Received update request `date`"

git pull

echo "Completed at `date`"

}>> ${LOG_LOCATION} 2>&1 ##LOG to file

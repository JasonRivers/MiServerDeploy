#!/bin/bash

EMAILADDR=$1	##Users email
GH_BRANCH=$2	##GitHub Branch
URL="http://your.site.com"

echo "Your GitHub push to ${GH_BRANCH} has been deployed.

You can see the site at ${URL}" | mail -s "${URL} Updated from ${GH_BRANCH}" ${EMAILADDR}


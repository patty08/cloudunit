#!/usr/bin/env bash

CU_USER=$1
CU_PASSWORD=$2

# Stop the server to update the new user configuration
$CU_SCRIPTS/cu_stop.sh

PATTERN_USER="s/CU_USER/$CU_USER/g"
PATTERN_PASSWD="s/CU_PASSWORD/$CU_PASSWORD/g"

sed -i $PATTERN_USER $CU_SOFTWARE/conf/tomcat-users.xml
sed -i $PATTERN_PASSWD $CU_SOFTWARE/conf/tomcat-users.xml

# Start the server to use the new user configuration
$CU_SCRIPTS/cu_start.sh
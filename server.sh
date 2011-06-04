#! /bin/sh
# ==================================================================
#  ______                           __     _____
# /_  __/___  ____ ___  _________ _/ /_   /__  /
#  / / / __ \/ __ `__ \/ ___/ __ `/ __/     / /
# / / / /_/ / / / / / / /__/ /_/ / /_      / /
#/_/  \____/_/ /_/ /_/\___/\__,_/\__/     /_/

# Multi-instance Apache Tomcat installation with a focus
# on best-practices as defined by Apache, SpringSource, and MuleSoft
# and enterprise use with large-scale deployments.

# Credits:
#       Google -> Couldn't survive without it
#       Stackoverflow.com -> Community support
#       SpringSource -> Specifically best-practices and seminars (Expert Series)

# Based On:
#       http://www.springsource.com/files/uploads/tomcat/tomcatx-performance-tuning.pdf
#       http://www.springsource.com/files/u1/PerformanceTuningApacheTomcat-Part2.pdf
#       http://www.springsource.com/files/uploads/tomcat/tomcatx-large-scale-deployments.pdf

# Created By: Terrance A. Snyder
# URL: http://www.terranceasnyder.com, http://shutupandcode.net

# Best Practice Documentation:
# http://terranceasnyder.com/2011/05/tomcat-best-practices/

# Looking for the latest version?
# github @ https://github.com/terrancesnyder

# ==================================================================

# DESCRIPTION
# Handles the automatic startup/shutdown of any tomcat instance within the tomcat
# folder. an instance is based on convention that a folder that hosts the specified 
# instance is named the same as the port number wanted.

# ==================================================================

ACTION="$1"

if [ -z  "$1" ]; then
  echo "usage: server.sh [start|stop]"
  exit 0
fi

# directory
SCRIPT=$(readlink -f $0)
DIRECTORY=`dirname $SCRIPT`

# grab all directories that look like port numbers
ports=$(ls -p $DIRECTORY | awk -F'[_/]' '/^[0-9]/ {print $1}')

# issue action against those ports
for port in $ports
do
	$DIRECTORY/run.sh $port "$ACTION" > /dev/null 2>&1
done


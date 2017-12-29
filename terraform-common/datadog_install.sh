#!/bin/bash

DATADOG_API_KEY="$1"

if [[ "x$DATADOG_API_KEY" != "x" ]]; then

   #
   # install the agent
   #

   sudo apt-get update
   sudo apt-get install apt-transport-https

   sudo sh -c "echo 'deb https://apt.datadoghq.com/ stable main' > /etc/apt/sources.list.d/datadog.list"
   sudo apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 C7A7DA52

   sudo apt-get update
   sudo apt-get install datadog-agent

   #
   # configure the service
   #
   #   Config File                         | Description
   #   --------------------------------------------------------------
   #   /etc/dd-agent/datadog.conf.example  | configures the external DD service recieving agent data
   #   /etc/dd-agent/conf.d/*example       | configures the internal database receiving agent data
   #

   sudo sh -c "sed 's/api_key:.*/api_key: $DATADOG_API_KEY/' /etc/dd-agent/datadog.conf.example > /etc/dd-agent/datadog.conf"

   #
   # start the service
   #

   echo "export DD_PROCESS_AGENT_ENABLED=true" | tee -a /etc/profile.d/datadog_profile.sh
   sudo /etc/init.d/datadog-agent start
   ps -ef | grep datadog
fi

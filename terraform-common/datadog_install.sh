#!/bin/bash

DATADOG_API_KEY="$1"

if [[ "x$DATADOG_API_KEY" != "x" ]]; then
sudo apt-get update
sudo apt-get install apt-transport-https

sudo sh -c "echo 'deb https://apt.datadoghq.com/ stable main' > /etc/apt/sources.list.d/datadog.list"
sudo apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 C7A7DA52

sudo apt-get update
sudo apt-get install datadog-agent

sudo sh -c "sed 's/api_key:.*/api_key: $DATADOG_API_KEY/' /etc/dd-agent/datadog.conf.example > /etc/dd-agent/datadog.conf"

echo "export DD_PROCESS_AGENT_ENABLED=true" | tee -a /etc/profile.d/datadog_profile.sh
sudo /etc/init.d/datadog-agent start

ps -ef | grep datadog

fi

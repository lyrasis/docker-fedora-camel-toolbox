#!/bin/bash

/opt/karaf/bin/start
echo "Waiting for Karaf to start"
sleep 10
echo "Configuring Fedora Camel Toolbox"
/fedora_camel_toolbox.sh
/opt/karaf/bin/stop
echo "Waiting for Karaf to restart"
sleep 30
/opt/karaf/bin/karaf

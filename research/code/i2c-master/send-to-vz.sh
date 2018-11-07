#!/bin/bash

#
# by karlbeecken
#
# usage: ./send-to-vz.sh > /dev/null &
# debugging: just ./send-to-vz.sh and uncomment line 15
#

IFS=' '                   # sets the IFS to space
#temp="22.75834845"
#hum="56.46357645"
tempuuid="af1e5b80-c70b-11e8-93fa-ddbac8086c38"   # put here your vz-uuid for the temperature sensor
humuuid="ec0736b0-ce3a-11e8-983d-81145097ecf6"    # put here your vz-uuid for the humidity sensor
#echo "$datain"

while true        # loop every 10 seconds
do
  datain=$(python read-float.py)      # defines the  data input (= read script)
  echo "$datain"                      # debug output
  read temp hum <<< $datain           # seperates the data input into temp and hum values
  wget -O - -q "http://localhost/middleware.php/data/$tempuuid.json?operation=add&value=$temp" > /dev/null # sends the temp value to vz
  echo "$temp"                        # debug output
  wget -O - -q "http://localhost/middleware.php/data/$humuuid.json?operation=add&value=$hum" > /dev/null   # sends the hum value to vz
  echo "$hum"                         # debug output
  sleep 10
done

#!/bin/bash

LOC=$1

curl -s -I -H "Referer: https://www.alertwildfire.org/" https://s3-us-west-2.amazonaws.com/alertwildfire-data-public/Axis-$LOC/latest_full.jpg | grep "x-amz-meta-context" | sed 's/x-amz-meta-context: //' | jq '.extensions.camera | {x: .pan, y: .tilt}'

TIME="1662766688"
URL="https://s3-us-west-2.amazonaws.com/alertwildfire-data-public/Axis-Siri/latest_full.jpg?x-request-time=${TIME}"

# curl -o ./output.jpg -v -H "Referer: https://www.alertwildfire.org/" https://s3-us-west-2.amazonaws.com/alertwildfire-data-public/Axis-Siri/latest_full.jpg
curl -I -H "Referer: https://www.alertwildfire.org/" https://s3-us-west-2.amazonaws.com/alertwildfire-data-public/Axis-Siri/latest_full.jpg

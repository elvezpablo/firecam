#!/bin/bash

LATEST=$1
# get the month and make a dir if we don't have it 
MONTH=`echo  ${LATEST} | grep  -o '[0-2][0-9]2[2-3]$'`

mkdir -p $MONTH

mkdir -p $MONTH/$LATEST

scp pi@rocinante.local:~/shasta/$LATEST.zip .

unzip $LATEST.zip -d $MONTH/$LATEST

mkdir -p $MONTH/zips

mv $LATEST.zip $MONTH/zips
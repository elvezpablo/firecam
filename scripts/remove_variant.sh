#!/bin/bash

LATEST=$1
# get the month and make a dir if we don't have it 
MONTH=`echo  ${LATEST} | grep  -o '[0-2][0-9]2[2-3]$'`

echo removing variants $LATEST

cd $MONTH/$LATEST

# temp directory
mkdir -p variants

FIRST=`ls -1 *.jpg | head -1`
PREFIX=`echo ${FIRST} | cut -d "_" -f1`
FRAME='X:+59.95 Y:-8.64'
FRAME2='X:+59.95 Y:-8.65'

for f in ${PREFIX}_*.jpg
do
	convert $f -crop 230x20+420+1052 -borderColor black -border 10x50 cropped.jpg
	LOCATION=`tesseract cropped.jpg - -l eng --psm 7`

	if [ "$LOCATION" != "$FRAME" ] && [ "$LOCATION" != "$FRAME2" ] ; then
		mv $f variants
	fi
	
done
# check the cound of variants if it is over threshold then stop
COUNT=`ls *.jpg | wc -l | tr -dc '0-9'`
VARIANT_COUNT=`ls variants/*.jpg | wc -l | tr -dc '0-9'`
# allow up to 5% image variance
THRESHOLD=.05
echo "count: $COUNT "
echo $VARIANT_COUNT

RESULT=`echo "scale=2;($VARIANT_COUNT/$COUNT) > $THRESHOLD" | bc`

echo "result $RESULT"

if [ $RESULT -eq 1 ]
then
	echo "Error: $VARIANT_COUNT is over $THRESHOLD% variants."
	exit 1
fi

echo "Success: $VARIANT_COUNT variants"
# remove variants
rm -rf variants

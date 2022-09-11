#!/bin/bash

mkdir -p  blended
FIRST=`ls -1 *.jpg | head -1`
PREFIX=`echo ${FIRST} | cut -d "_" -f1`
INPUT_COUNT=`ls *.jpg | wc -l | tr -d ' '`
IMAGES_TOTAL=`ls *.jpg | wc -l | tr -d ' '`
FINAL_TOTAL=`echo $IMAGES_TOTAL*3-6 | bc`

cp $FIRST  blended/previous.jpg
cd blended
COUNTER=0

for f in ../${PREFIX}_*.jpg
do
	TIMESTAMP=`timestamp $f`
	for i in {0..2}
	do
		let "COUNTER+=1"
		composite -blend $((i*50)) $f previous.jpg -matte blend_$COUNTER.jpg
    	convert -brightness-contrast -4x8 blend_$COUNTER.jpg blend_$COUNTER.jpg
		convert -font Helvetica -fill "rgba(240,240,240,.9)"  -pointsize 30  -draw "text 10,40 '$TIMESTAMP'" blend_$COUNTER.jpg blend_$COUNTER.jpg
		echo $COUNTER of $FINAL_TOTAL
	done	
	cp $f previous.jpg
done

rm previous.jpg



# combine the images 
# ffmpeg -r "30" -i blend_%d.jpg -vcodec libx264 -crf 25  -pix_fmt yuv420p video_30.mp4
# crop the logo out
# ffmpeg -i video_30.mp4 -filter:v "crop=in_w-145:in_h-230:0:0" cropped.mp4
# combine, crop and use blended images
ffmpeg -r "30" -i blend_%d.jpg -vcodec libx264 -crf 25  -pix_fmt yuv420p -filter:v "crop=in_w-145:in_h-230:0:0" $PREFIX.mp4

# clean up
rm *.jpg

mv $PREFIX.mp4 ..

cd ..

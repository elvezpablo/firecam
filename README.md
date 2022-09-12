# Firecam Scripts

These scripts run on 2 machines the PI which is running a cron job and the `downloader.sh` script. The PI also renames the image with the current date and minute of the image snapshot. 

Note that we just figured out all you need is the Referrer header on that script to download the image. 

## The current process for the scripts

Then on the encoding computer the following scripts are run.

Thenly arg for the scripts is the date of the image which is also the prefix of all the downloaded files MMDDYY. 

1. `download.sh 091222` 
2. `remove_variant.sh 091222` 
3. `cd 091222` 
4. `cp blend.sh .` // copy the blend into the image date dir
5. `./blend.sh`

Blend does the bulk of the processing. 

### Sample image output

The `images` directory has the same raw image output. 

## Next iteration

## On the PI
1. Use the amz headers to determine the x,y position of the camera before downloading so we can skip the `remove_variant.sh` step.
   1. Also do a retry of the download 1 every 10 seconds for ~30 seconds to try to capture the frame
2. PI will upload image to processing server


## New Processing server 

1. Accepts image upload with timestamp (maybe header information as well?)
2. Waits for X number of images 
3. Adjusts and encodes a batch of images when enough are available. 
4. Adds the new video to a manifest
5. Uploads to server? 




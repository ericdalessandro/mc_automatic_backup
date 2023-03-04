#!/bin/bash

# This script automates the process of shutting down the server and backing up the files.
# Backups will be placed in a sub-directory named the current date inside of the $TARGET_FOLDER variable from config.txt. See README.MD for more info.
# Author: github.com/ericdalessandro

# Initiate Variables
source config.txt
CURRENT_DATE=$(date +%Y-%m-%d)

echo "Starting backup process. Press Ctrl+C to stop the script."

# Ensure log file exists:
touch $SCRIPTDIR/log.txt
echo "Starting log for $CURRENT_DATE..." >> $SCRIPTDIR/log.txt

# Announce server maintnance:
echo "[$(date +"%Y-%m-%d %H:%M:%S")] Announcing server maintenance..." >> $SCRIPTDIR/log.txt
for i in 5 4 3 2 1
do
    screen -S minecraft -p 0 -X stuff "say Server will restart in $i minute(s) for routine maintenance.^M"
    sleep 60
done

# Stop the server:
echo "[$(date +"%Y-%m-%d %H:%M:%S")] Stopping server..." >> $SCRIPTDIR/log.txt
screen -S minecraft -p 0 -X stuff "say Stopping server...^M"
sleep 10
cd $SCRIPTDIR
./stop_server.sh

# Wait on server to stop just in case:
sleep 15

# Create backup dir with todays date:
echo "[$(date +"%Y-%m-%d %H:%M:%S")] Backing up directory..." >> $SCRIPTDIR/log.txt
cd $TARGET_FOLDER
mkdir $CURRENT_DATE

# Copy server files to backup dir:
cp -R $SOURCE_FOLDER/* $TARGET_FOLDER/$CURRENT_DATE

# Check $DELETE_OLD:
if [ $DELETE_OLD -eq 1 ]
then

    # Clean up old folders:
    echo "[$(date +"%Y-%m-%d %H:%M:%S")] Cleaning up backups older than $DELETE_AFTER days..." >> $SCRIPTDIR/log.txt
    cd $TARGET_FOLDER
    TARGET_FOLDER_LS=($(ls -d */))
    DELETE_DATE=$(date +%Y%m%d -d "$DELETE_AFTER days ago")

    for FOLDER in $TARGET_FOLDER_LS
    do
        FOLDER_NO_SLASH=${FOLDER:0:$(expr length $FOLDER)-1}
        FOLDER_DATE=$(date -d $FOLDER_NO_SLASH +%Y%m%d)
        if [ "$FOLDER_DATE" -lt "$DELETE_DATE" ]
        then
            echo "[$(date +"%Y-%m-%d %H:%M:%S")] Deleting $FOLDER_NO_SLASH..." >> $SCRIPTDIR/log.txt
            rm -r $FOLDER_NO_SLASH
            echo "[$(date +"%Y-%m-%d %H:%M:%S")] $FOLDER_NO_SLASH deleted." >> $SCRIPTDIR/log.txt
        fi
    done
    echo "[$(date +"%Y-%m-%d %H:%M:%S")] Back up and cleanup complete. Starting server..." >> $SCRIPTDIR/log.txt
else
    echo "[$(date +"%Y-%m-%d %H:%M:%S")] Back up and complete. Cleanup disabled. Starting server..." >> $SCRIPTDIR/log.txt
fi

# Start minecraft server:
cd $SCRIPTDIR
./start_server.sh

#Log to log.txt:
echo "[$(date +"%Y-%m-%d %H:%M:%S")] Backup complete for $CURRENT_DATE." >> $SCRIPTDIR/log.txt

echo "Script complete. Please allow up to a minute for server to start."
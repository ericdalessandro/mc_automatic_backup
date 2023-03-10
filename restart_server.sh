#!/bin/bash
source config.txt
echo "Restarting Minecraft server..."
screen -S minecraft -p 0 -X stuff "say Server restarting in 15 seconds...^M"
sleep 15
screen -S minecraft -p 0 -X stuff "stop^M"
sleep 15
cd $SOURCE_FOLDER
screen -AmdS minecraft java -Xmx$MC_RAM_ALLOCATION -Xms$MC_RAM_ALLOCATION -jar server.jar nogui
echo "Server restarting."

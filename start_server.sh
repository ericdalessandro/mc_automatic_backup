echo "Starting Minecraft Server..."
source config.txt
cd $SOURCE_FOLDER
screen -AmdS minecraft java -Xmx$MC_RAM_ALLOCATION -Xms$MC_RAM_ALLOCATION -jar server.jar nogui
echo "Minecraft Server Started."

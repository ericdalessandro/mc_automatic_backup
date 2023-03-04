echo "Starting Minecraft Server..."
source config.txt
cd $SOURCE_FOLDER
screen -AmdS minecraft java -Xmx4096M -Xms4096M -jar server.jar nogui
echo "Minecraft Server Started."

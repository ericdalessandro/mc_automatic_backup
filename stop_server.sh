echo "Stopping Minecraft Server..."
# screen -r minecraft -X quit
screen -S minecraft -p 0 -X stuff "stop^M"
echo "Minecraft Server Stopped."

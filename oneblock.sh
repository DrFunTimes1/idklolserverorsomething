#!/bin/bash

echo "Starting playit tunnel..."
screen -dmS playit playit

sleep 5

echo "Starting Minecraft server..."
cd servers/oneblock
screen -dmS minecraft java -Xmx2G -Xms1G -jar server.jar nogui
screen -dmS idle ./idle

echo "Server and tunnel started!"

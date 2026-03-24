#!/bin/bash
screen -dmS playit playit
screen -dmS mc bash -c "cd /workspaces/idklolserverorsomething/servers/oneblock && java -Xmx8G -Xms4G -jar server.jar nogui"
screen -dmS idle bash -c "cd /workspaces/idklolserverorsomething/scripts/ && python3 monitor.py"
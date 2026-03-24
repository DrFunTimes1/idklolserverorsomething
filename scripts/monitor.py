#!/usr/bin/env python3
# ~/scripts/monitor.py
# Monitors OneBlock server, Discord bot notifications, idle shutdown
# Compatible with Python 3.12 + discord.py v2+ + mcstatus v6+

import asyncio
from mcstatus import JavaServer
import discord
import subprocess
import os

TOKEN = os.getenv("BOT_TOKEN")
CHANNEL_ID = 1446008173743046700  # Discord channel ID

SERVER_IP = "localhost"
DELAY_BEFORE_CHECK = 90*60  # 1.5 hours
IDLE_SHUTDOWN = 30*60       # 30 minutes

intents = discord.Intents.default()
client = discord.Client(intents=intents)

async def check_server():
    await client.wait_until_ready()
    server = JavaServer.lookup(SERVER_IP)
    await asyncio.sleep(DELAY_BEFORE_CHECK)  # wait before checking
    try:
        status = await server.status()
        if status.players.online == 0:
            channel = client.get_channel(CHANNEL_ID)
            await channel.send("@everyone Server empty! Shutting down in 30 minutes if no one joins.")
            idle_time = 0
            while idle_time < IDLE_SHUTDOWN:
                status = await server.status()
                if status.players.online > 0:
                    break  # someone joined
                await asyncio.sleep(60)
                idle_time += 60
            else:
                # 30 min passed → kill server
                subprocess.run(['./killall.sh'])
                await channel.send("Server shut down: no one joined.")
    except Exception as e:
        print("Error checking server:", e)

async def main():
    # start the check_server task
    task = asyncio.create_task(check_server())
    # start the Discord client
    await client.start(TOKEN)
    # wait for the monitoring task to finish (optional)
    await task

if __name__ == "__main__":
    asyncio.run(main())
#!/bin/bash

LOG="logs/latest.log"
IDLE_LIMIT=1800
last_leave_time=0
players=0

echo "Idle watcher started..."

tail -Fn0 "$LOG" | while read line
do
    if echo "$line" | grep -q "joined the game"; then
        players=$((players+1))
        echo "Player joined. Players online: $players"
        last_leave_time=0
    fi

    if echo "$line" | grep -q "left the game"; then
        players=$((players-1))
        echo "Player left. Players online: $players"

        if [ "$players" -le 0 ]; then
            last_leave_time=$(date +%s)
            echo "Server empty. Starting 30 minute timer..."
        fi
    fi

    if [ "$players" -eq 0 ] && [ "$last_leave_time" -ne 0 ]; then
        now=$(date +%s)
        diff=$((now-last_leave_time))

        if [ "$diff" -ge "$IDLE_LIMIT" ]; then
            echo "Server idle for 30 minutes. Stopping..."
            screen -S minecraft -X stuff "stop\n"
            exit
        fi
    fi
done
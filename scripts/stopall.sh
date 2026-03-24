screen -S mc -X stuff $'\003'
sleep 5

screen -S playit -X stuff $'\003'
sleep 5

screen -S idle -X stuff $'\003'
sleep 5

screen -S mc -X quit
screen -S playit -X quit
screen -S idle -X quit

git add . ; git commit -m "something changed in the world" ; git push origin main --force
sleep 20

gh codespace stop -c silver-space-barnacle-jjwp75v9xx77h5j9jsilver-space-barnacle-jjwp75v9xx77h5j9j
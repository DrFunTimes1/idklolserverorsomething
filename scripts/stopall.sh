screen -S mc -X stuff $'\003'
sleep 5

screen -S playit -X stuff $'\003'
sleep 5

screen -S idle -X stuff $'\003'
sleep 5

screen -S mc -X quit
screen -S playit -X quit
screen -S idle -X quit
sleep 10

gh codespace stop -c silver-space-barnacle-jjwp75v9xx77h5j9jsilver-space-barnacle-jjwp75v9xx77h5j9j
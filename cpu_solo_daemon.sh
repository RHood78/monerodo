#!/bin/bash
#MONERODO nvidia local pool settings

#Menu
this_service="cpu local daemon miner"
while true
do
	clear
	echo "================="
	echo "Manage $this_service settings"
	echo "================="
	echo "At this time, the solo daemon miner is not setup"
	echo "The easiest way to solo mine with CPU is to load a wallet"
	echo "and then type start_mining. It will make the monero daemon start"
	echo "mining to the address of that wallet."
	echo "================="
	echo "[1] Turn $this_service on now and on boot"
	echo "[2] Turn $this_service off"
	echo "[3] Turn $this_service off now and stop from running on boot"
	echo "[r] Return to previous menu"
	echo -e "\n"
	echo -e "Enter your selection \c"
	read answer
        export mos_service="mos_daemonminer"
	export running=$(service $mos_service status)
	case "$answer" in
		#1) ./service_on.sh;;
		#2) ./service_off.sh;;
		#3) ./service_off.sh
		#sudo rm /etc/init/$mos_service.conf;;
		r) exit ;;
	esac
	clear
done

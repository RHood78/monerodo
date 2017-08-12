#!/bin/bash
# Monero Update script

now=$(date +"%m_%d_%Y")

cd /home/$USER/monero_files/
sudo mkdir monero_$now
cd monero_$now

sudo rm linux64*
sudo wget https://downloads.getmonero.org/linux64
sudo tar -xjvf linux64

# Copy binaries to /bin
#Restart service to use new binaries
export running=$(service mos_bitmonero status)
export mos_service="mos_bitmonero"

/home/$USER/monerodo/service_off.sh

cd monero*

sudo cp monerod /bin
sudo cp monero-wallet-cli /bin
sudo cp monero-wallet-rpc /bin

sudo sed -i -e "s/333.333.333.333/$current_ip/g" /home/$USER/monerodo/conf_files/mos_bitmonero.conf

sudo cp /home/$USER/monerodo/conf_files/mos_bitmonero.conf /home/$USER/.monerodo
sudo cp /home/$USER/monerodo/conf_files/mos_bitmonero.conf /etc/init/

echo "You'll have to turn monero core on again in the settings menu. Press enter to continue"

read goback
cd /home/$USER/monerodo/

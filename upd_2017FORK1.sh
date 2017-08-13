#1/bin/bash/

./important.sh
echo "This can take a while. You will also have to reconfigure your pool server wallet and mininodo wallet when done (it will load them automatically)."
echo "Ready !?!?!?!?! Type yes or no"
read update
case "$update" in
no) echo "OK, but you need to upgrade! Press enter to continue"
read goback
exit;;

yes)

sudo apt-get -y update
sudo apt-get -y upgrade
sudo apt-get -y autoremove
sudo apt-get -y remove nodejs

sudo wget -qO- https://raw.githubusercontent.com/creationix/nvm/v0.33.2/install.sh | bash

export NVM_DIR="/home/$USER/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

n=$(which node);n=${n%/bin/node}; chmod -R 755 $n/bin/*; sudo cp -r $n/{bin,lib,share} /usr/local

nvm install v0.10.40
nvm use v0.10
nvm alias default v0.10.40

cd /monerodo/

sudo git clone https://github.com/Gingeropolous/cryptonote-xmr-pool.git ging_pool

cd ging_pool

sudo git checkout clean

sudo rm-r node_modules

sudo nvm alias default v0.10.40

sudo cp /monerodo/ging_pool/config_monerodo.json /monerodo/ging_pool/config.json

cd /monerodo/ging_pool
sudo cp /monerodo/ging_pool/config.json $FILEDIR/config.json

echo "##### STARTING POOL COMPILE ######"
sudo npm update

## Update IP address from repo dummy IP

sudo sed -i -e "s/333.333.333.333/$current_ip/g" $FILEDIR/config.json
sudo cp $FILEDIR/config.json /monerodo/ging_pool/ 

### Update monero bins

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

sudo cp monerod /bin/
sudo cp monero-wallet-cli /bin/
sudo cp monero-wallet-rpc /bin/

echo "You'll have to turn monero core on again in the settings menu. Press enter to continue"
read goback
cd /home/$USER/monerodo/

sudo cp /home/$USER/monerodo/conf_files/mos_poolnode.conf /home/$USER/.monerodo/
sudo cp /home/$USER/monerodo/conf_files/mos_poolnode.conf /etc/init/

cd /home/$USER/monerodo/

### Update pool wallet
clear
./important.sh
echo "Time to reconfigure the pool wallet!!"
echo ""
./setup_pool_wallet.sh

./important.sh
echo "Time to reconfigure the MiniNodo wallet!"
echo ""
./setup_mininodo_wallet.sh

echo "yes" > $FILEDIR/2017FORK1.txt

sudo cp /home/$USER/monerodo/conf_files/change_ip.sh /monerodo/
sudo chmod +x /monerodo/change_ip.sh

echo "Your Monerodo has been updated for the upcoming fork. Thanks for using the Monerodo. Please consider donating for continued development."
echo "The donation address is: 44UW4sPKb4XbWHm8PXr6K8GQi7jUs9i7t2mTsjDn2zK7jYZwNERfoHaC1Yy4PYs1eTCZ9766hkB6RLUf1y95EvCQNpCZnuu"
echo "Please press return to continue"
read goback
;;

*) echo "OK, but you need to upgrade! Press enter to continue"
read goback
exit;;

esac

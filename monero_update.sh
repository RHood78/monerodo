#!/bin/bash
# Monero Update script

#cd /home/bob/monerodo/
#git pull
#chmod +x *.sh
./dep_list.sh

#All the below commented code will eventually be used to adjust for different hardware settings. For now, 1 thread is most stable.
#proc=1 #modify to use script below if unit has more memory
#Determine number of available hardware threads
#Commented out because of memory requirements for multiple threads
#proc=$(nproc)
#if [ $proc != 1 ]
#        then
#                proc=$[$proc/2]
#        else
#                $proc=1
#        fi
#MEM=`free -m | grep Mem | awk '{print $2}'`
#GBMEM=$[$MEM/1000]
#echo $GBMEM

#Pull repository for updates and compile

DIRECTORY="/home/bob/monerodo"
if [ -d "$DIRECTORY" ]; then
  cd /home/bob/monerodo
  sudo git stash
  sudo git pull
  sudo make
else
  cd /home/bob/
  sudo git clone https://github.com/monero-project/monero.git
  cd /home/bob/monerodo
  sudo git stash
  sudo git pull
  sudo make
fi

# Copy binaries to /bin
#Restart service to use new binaries
sudo service mos_bitmonero stop
sudo cp /home/bob/bitmonero/build/release/bin/monerod /bin
sudo cp /home/bob/bitmonero/build/release/bin/monero-wallet-cli /bin
sudo service mos_bitmonero start

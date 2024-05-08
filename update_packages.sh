#!/bin/bash

echo
echo "Install packages only if they are not installed already. - Navid200"
echo

# Reduce the number of snapshots kept from the default 3 to 2 to reduce disk space usage.
sudo snap set system refresh.retain=2

# Let's upgrade packages if available and install the missing needed packages.
sudo apt-get update

#Ubuntu upgrade available
NextUbuntu="$(apt-get -s upgrade | grep 'Inst base' | awk '{print $4}' | sed 's/(//')"
if [ "$NextUbuntu" = "11ubuntu5.8" ] # Only upgrade if we have tested the next release
then
  sudo apt-get -y upgrade
fi

# vis
whichpack=$(which vis)
if [ "$whichpack" = "" ]
then
  sudo apt-get -y install vis
fi

# nano
whichpack=$(which nano)
if [ "$whichpack" = "" ]
then
  sudo apt-get -y install nano
fi

# screen
whichpack=$(which screen)
if [ "$whichpack" = "" ]
then
  sudo apt-get -y install screen
fi

# jq
whichpack=$(which jq)
if [ "$whichpack" = "" ]
then
  sudo apt-get -y install jq
fi

# qrencode
whichpack=$(which qrencode)
if [ "$whichpack" = "" ]
then
  sudo apt-get -y install qrencode
fi

# mongo
whichpack="$(mongod --version | sed -n 1p)"
if [ ! "${whichpack%%.*}" = "db version v3" ]
then
  sudo apt-get -y install mongodb-server
fi

# node
whichpack=$(node -v)
if [ ! "${whichpack%%.*}" = "v14" ]
then
  curl -fsSL https://deb.nodesource.com/setup_14.x | sudo -E bash - &&\
  sudo apt-get install -y nodejs
fi 

# file
whichpack=$(which file)
if [ "$whichpack" = "" ]
then
  sudo apt-get -y install file
fi  

# The last item on the above list of packages must be verified in Status.sh to have been installed.  

# Add log
/xDrip/scripts/AddLog.sh "The packages have been installed" /xDrip/Logs
  

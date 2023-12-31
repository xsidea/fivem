#!/bin/bash

# Colors functions
defaultMsg() {
  echo -e "\\e[0m${*}\\e[0m"
}
greenMsg() {
  echo -e "\\e[0;32m${*}\\e[0m"
}
redMsg() {
  echo -e "\\e[0;31m${*}\\e[0m"
}
yellowMsg() {
  echo -e "\\e[0;33m${*}\\e[0m"
}
cyanMsg() {
  echo -e "\\e[0;36m${*}\\e[0m"
}

redMsg("Please execute")

exit 1


if [ "$(whoami)" != "root" ]; then
	echo "Please execute the installation command with root privileges！"
	exit 1
fi

is64bit=$(getconf LONG_BIT)
if [ "${is64bit}" != '64' ];then
	Red_Error "Sorry, the current version does not support 32bit systems!";
fi

## install location
installlocation=$(whiptail --title "Question" --inputbox "Choose a location for everything to install." 10 60 /Fivem 3>&1 1>&2 2>&3)
status=$?
if [ $status = 0 ]; then
    if [ -d $installlocation ]; then
    	echo "That directory exist already. Please choose a non existent."
    	exit 1;
    fi
else
    echo "Aborting."
    exit 1
fi

## install process
mkdir -p $installlocation/server
cd $installlocation/server
# version 6683
wget https://runtime.fivem.net/artifacts/fivem/build_proot_linux/master/6683-9729577be50de537692c3a19e86365a5e0f99a54/fx.tar.xz
tar xf fx.tar.xz
rm fx.tar.xz

git clone https://github.com/citizenfx/cfx-server-data.git $installlocation/server-data
mv $installlocation/server-data/resources $installlocation/server
rm -rf $installlocation/server-data

chmod -R 777 $installlocation
	
clear

echo "Installation process is over."
#!/bin/bash

# get raspiblitz config
echo "get raspiblitz config"
source /home/admin/raspiblitz.info
source /mnt/hdd/raspiblitz.conf
BTCRPCexplorer=on
RTL=on
ElectRS=on
echo "run dialog ..."

./XXaptInstall.sh qrencode

# BASIC MENU INFO
HEIGHT=11
WIDTH=64
CHOICE_HEIGHT=6
BACKTITLE="RaspiBlitz"
TITLE=""
MENU="Choose one of the following options:"
OPTIONS=()
plus=""

# Basic Options
OPTIONS+=(NYX "Monitor TOR")
if [ "${RTL}" = "on" ]; then
  OPTIONS+=(RTL "RTL web interface address")  
fi
if [ "${BTCRPCexplorer}" = "on" ]; then
  OPTIONS+=(EXPLORER "BTC-RPC-Explorer address")  
fi
if [ "${ElectRS}" = "on" ]; then
  OPTIONS+=(ELECTRS "Electrum Rust Server address")  
fi


dialogcancel=$?
echo "done dialog"
clear

# check if user canceled dialog
echo "dialogcancel(${dialogcancel})"
if [ ${dialogcancel} -eq 1 ]; then
  echo "user canceled"
  exit 1
fi

CHOICE=$(dialog --clear \
                --backtitle "$BACKTITLE" \
                --title "$TITLE" \
                --menu "$MENU" \
                $HEIGHT $WIDTH $CHOICE_HEIGHT \
                "${OPTIONS[@]}" \
                2>&1 >/dev/tty)

#clear
case $CHOICE in
        CLOSE)
            exit 1;
            ;;
        NYX)
            sudo nyx
            ./00mainMenu.sh
            ;;
        RTL)
            service=RTL
            hostname=$(sudo cat  /mnt/hdd/tor/$service/hostname)
            echo "The Hidden Service address for $service is:"
            echo "$hostname"
            echo ""
            echo "scan the QR to use it in the Tor Browser on mobile:"
            qrencode -t ANSI256 $hostname
            echo "Press ENTER to return to the menu"
            read key
            ./00mainMenu.sh
            ;;        
        EXPLORER)
            service=btc-rpc-explorer
            hostname=$(sudo cat  /mnt/hdd/tor/$service/hostname)
            echo "The Hidden Service address for $service is:"
            echo "$hostname"
            echo ""
            echo "scan the QR to use it in the Tor Browser on mobile:"
            qrencode -t ANSI256 $hostname
            echo "Press ENTER to return to the menu"
            read key
            ./00mainMenu.sh
            ;;
        ELECTRS)
            service=electrs
            hostname=$(sudo cat  /mnt/hdd/tor/$service/hostname)
            echo "The Hidden Service address for $service is:"
            echo "$hostname"
            echo ""
            echo "scan the QR to use it in the Tor Browser on mobile:"
            qrencode -t ANSI256 $hostname
            echo "Press ENTER to return to the menu"
            read key
            ./00mainMenu.sh
            ;;   
esac            



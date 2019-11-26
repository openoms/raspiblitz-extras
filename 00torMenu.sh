#!/bin/bash

# get raspiblitz config
echo "get raspiblitz config"
source /home/admin/raspiblitz.info
source /mnt/hdd/raspiblitz.conf

# correct Hidden Services for RTL and BTC-RPC-Explorer
sudo sed -i "s/^HiddenServicePort 3000 127.0.0.1:3000/HiddenServicePort 80 127.0.0.1:3000/g" /etc/tor/torrc
sudo sed -i "s/^HiddenServicePort 3002 127.0.0.1:3002/HiddenServicePort 80 127.0.0.1:3002/g" /etc/tor/torrc

# add value for ElectRS to raspi config if needed
if [ ${#ElectRS} -eq 0 ]; then
  echo "ElectRS=off" >> /mnt/hdd/raspiblitz.conf
fi
isInstalled=$(sudo ls /etc/systemd/system/electrs.service 2>/dev/null | grep -c 'electrs.service')
if [ ${isInstalled} -eq 1 ]; then
 # setting value in raspiblitz config
  sudo sed -i "s/^ElectRS=.*/ElectRS=on/g" /mnt/hdd/raspiblitz.conf
fi

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
if [ "${rtlWebinterface}" = "on" ]; then
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
            isRTLTor=$(sudo cat /etc/tor/torrc 2>/dev/null | grep -c 'RTL')
            if [ ${isRTLTor} -eq 0 ]; then
              echo "
# Hidden Service for RTL
HiddenServiceDir /mnt/hdd/tor/RTL
HiddenServiceVersion 3
HiddenServicePort 80 127.0.0.1:3000
" | sudo tee -a /etc/tor/torrc
              sudo systemctl restart tor
              sleep 2
            else
              echo "The Hidden Service is already installed"
            fi            
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
            isBtcRpcExplorerTor=$(sudo cat /etc/tor/torrc 2>/dev/null | grep -c 'btc-rpc-explorer')
            if [ ${isBtcRpcExplorerTor} -eq 0 ]; then
              echo "
# Hidden Service for BTC-RPC-explorer
HiddenServiceDir /mnt/hdd/tor/btc-rpc-explorer
HiddenServiceVersion 3
HiddenServicePort 80 127.0.0.1:3002
" | sudo tee -a /etc/tor/torrc
              sudo systemctl restart tor
              sleep 2
            else
              echo "The Hidden Service is already installed"
            fi        
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
            isElectrsTor=$(sudo cat /etc/tor/torrc 2>/dev/null | grep -c 'electrs')
            if [ ${isElectrsTor} -eq 0 ]; then
              echo "
# Hidden Service for Electrum Server
HiddenServiceDir /mnt/hdd/tor/electrs
HiddenServiceVersion 3
HiddenServicePort 50002 127.0.0.1:50002
" | sudo tee -a /etc/tor/torrc
              sudo systemctl restart tor
              sleep 2
            else
              echo "The Hidden Service is already installed"
            fi
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
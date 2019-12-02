#!/bin/bash

# get raspiblitz config
echo "get raspiblitz config"
source /home/admin/raspiblitz.info
source /mnt/hdd/raspiblitz.conf

# correct Hidden Services for RTL and BTC-RPC-Explorer
if [ $(sudo cat /etc/tor/torrc | grep "HiddenServicePort 3000" -c) -eq 1 ]; then
  torNeedsRestart=1
  sudo sed -i "s/^HiddenServicePort 3000 127.0.0.1:3000/HiddenServicePort 80 127.0.0.1:3000/g" /etc/tor/torrc
elif [ $(sudo cat /etc/tor/torrc | grep "HiddenServicePort 3002" -c) -eq 1 ]; then
  torNeedsRestart=1
  sudo sed -i "s/^HiddenServicePort 3002 127.0.0.1:3002/HiddenServicePort 80 127.0.0.1:3002/g" /etc/tor/torrc
else
  torNeedsRestart=0
fi

if [ $torNeedsRestart -eq 1 ]; then
  sudo systemctl restart tor
  echo "Restarting Tor after fixing Hidden Service ports"
  sleep 5
fi

# add value for ElectRS to raspi config if needed
if [ ${#ElectRS} -eq 0 ]; then
  echo "ElectRS=off" >> /mnt/hdd/raspiblitz.conf
fi
isInstalled=$(sudo ls /etc/systemd/system/electrs.service 2>/dev/null | grep -c 'electrs.service')
if [ ${isInstalled} -eq 1 ]; then
 # setting value in raspiblitz config
  sudo sed -i "s/^ElectRS=.*/ElectRS=on/g" /mnt/hdd/raspiblitz.conf
fi
source /mnt/hdd/raspiblitz.conf

echo "Run dialog ..."
echo "Installing the QR code generator (qrencode)"
./XXaptInstall.sh qrencode
./XXaptInstall.sh fbi

# BASIC MENU INFO
HEIGHT=14
WIDTH=64
CHOICE_HEIGHT=7
BACKTITLE="RaspiBlitz"
TITLE=""
MENU="Choose one of the following options:"
OPTIONS=()
plus=""

# Basic Options
OPTIONS+=(NYX "Monitor TOR" \
ZEUS "Connect Zeus over Tor (Android)" \
ZAP "Connect Zap over Tor (iOS TestFlight)" \
NODED "Connect Fully Noded (iOS TestFlight)" )
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
            sudo -u bitcoin nyx
            ./00mainMenu.sh
            ;;
        ZEUS)
            ./97addMobileWalletTor.sh zeus
            ./00mainMenu.sh
            ;;
        ZAP)
            ./97addMobileWalletTor.sh zap
            ./00mainMenu.sh
            ;;
        NODED)
            clear
            /home/admin/config.scripts/network.wallet.sh on
            /home/admin/config.scripts/network.txindex.sh on
            isNodedTor=$(sudo cat /etc/tor/torrc 2>/dev/null | grep -c 'bitcoinrpc')
            if [ ${isNodedTor} -eq 0 ]; then
              clear
              echo "
# Hidden Service for bitcoinrpc / Fully Noded
HiddenServiceDir /mnt/hdd/tor/bitcoinrpc
HiddenServiceVersion 3
HiddenServicePort 8332 127.0.0.1:8332
" | sudo tee -a /etc/tor/torrc
              echo "Restarting Tor to activate the Hidden Service..."
              sudo systemctl restart tor
              sleep 10
            else
              echo "The Hidden Service is already installed"
            fi
            echo ""
            echo "        ***WARNING***"
            echo "The script will show your PASSWORD_B (RPC password from bitcoin.conf)"
            echo "on your computer screen as text and a QR Code" 
            echo "Be vary of the windows and bystanders!"
            echo ""
            echo "Press ENTER to proceed or CTRL+C to cancel"
            read key

            RPC_USER=$(sudo cat /mnt/hdd/bitcoin/bitcoin.conf | grep rpcuser | cut -c 9-)
            PASSWORD_B=$(sudo cat /mnt/hdd/bitcoin/bitcoin.conf | grep rpcpassword | cut -c 13-)
            hiddenService=$(sudo cat /mnt/hdd/tor/bitcoinrpc/hostname)

            # btcstandup://<rpcuser>:<rpcpassword>@<hidden service hostname>:<hidden service port>/?label=<optional node label> 
            quickConnect="btcstandup://$RPC_USER:$PASSWORD_B@$hiddenService:8332/?label=$hostname"
            echo "The QuickConnect URL for Fully noded is:"
            echo "$quickConnect"
            echo ""
            echo "scan the QR Code with Fully Noded to connect to your node:"
            qrencode -t ANSI256 $quickConnect
            echo "Press ENTER to return to the menu"
            read key
            ./00mainMenu.sh
            ;;                 
        RTL)
            clear
            isRTLTor=$(sudo cat /etc/tor/torrc 2>/dev/null | grep -c 'RTL')
            if [ ${isRTLTor} -eq 0 ]; then
              echo "
# Hidden Service for RTL
HiddenServiceDir /mnt/hdd/tor/RTL
HiddenServiceVersion 3
HiddenServicePort 80 127.0.0.1:3000
" | sudo tee -a /etc/tor/torrc
              echo "Restarting Tor to activate the Hidden Service..."
              sudo systemctl restart tor
              sleep 10
            else
              echo "The Hidden Service is already installed"
            fi            
            ./XXdisplayHiddenServiceQR.sh RTL
            ./00mainMenu.sh
            ;;        
        EXPLORER)
            clear
            isBtcRpcExplorerTor=$(sudo cat /etc/tor/torrc 2>/dev/null | grep -c 'btc-rpc-explorer')
            if [ ${isBtcRpcExplorerTor} -eq 0 ]; then
              echo "
# Hidden Service for BTC-RPC-explorer
HiddenServiceDir /mnt/hdd/tor/btc-rpc-explorer
HiddenServiceVersion 3
HiddenServicePort 80 127.0.0.1:3002
" | sudo tee -a /etc/tor/torrc
              echo "Restarting Tor to activate the Hidden Service..."
              sudo systemctl restart tor
              sleep 10
            else
              echo "The Hidden Service is already installed"
            fi        
            ./XXdisplayHiddenServiceQR.sh btc-rpc-explorer
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
              echo "Restarting Tor to activate the Hidden Service..."
              sudo systemctl restart tor
              sleep 10
            else
              echo "The Hidden Service is already installed"
            fi
            ./XXdisplayHiddenServiceQR.sh electrs
            ./00mainMenu.sh
            ;;   
esac            
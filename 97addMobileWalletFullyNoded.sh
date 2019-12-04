#!/bin/bash
clear

./config.scripts/network.wallet.sh on
./config.scripts/network.txindex.sh on
./config.scripts/internet.hiddenservice.sh bitcoinrpc 8332 8332

echo ""
echo "Find the links to download Fully Noded here:"
echo "https://github.com/Fonta1n3/FullyNoded#join-the-testflight"

echo ""
echo "        ***WARNING***"
echo ""
echo "The QR code to allow connecting to your node remotely"
echo "will show on your computer screen."
echo "Be aware of the windows, cameras, mirrors and bystanders!"
echo ""
echo "Press ENTER to continue, CTRL+C to cancel."
echo ""
read key

# extract RPC credentials from bitcoin.conf - store only in var
RPC_USER=$(sudo cat /mnt/hdd/bitcoin/bitcoin.conf | grep rpcuser | cut -c 9-)
PASSWORD_B=$(sudo cat /mnt/hdd/bitcoin/bitcoin.conf | grep rpcpassword | cut -c 13-)
hiddenService=$(sudo cat /mnt/hdd/tor/bitcoinrpc/hostname)

# btcstandup://<rpcuser>:<rpcpassword>@<hidden service hostname>:<hidden service port>/?label=<optional node label> 
quickConnect="btcstandup://$RPC_USER:$PASSWORD_B@$hiddenService:8332/?label=$hostname"
echo ""
echo "scan the QR Code with Fully Noded to connect to your node:"
qrencode -t ANSI256 $quickConnect
echo "Press ENTER to return to the menu"
read key
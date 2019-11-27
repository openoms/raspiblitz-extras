# display QR code for chosen Hidden Service
# take the HiddenServiceDir /etc/tor/torrc as the $1 parameter
service=$1
hiddenService=$(sudo cat  /mnt/hdd/tor/$service/hostname)
echo "The Hidden Service address for $service is:"
echo "$hiddenService"
echo ""
echo "scan the QR to use it in the Tor Browser on mobile:"
qrencode -t ANSI256 $hiddenService
echo "Press ENTER to return to the menu"
read key
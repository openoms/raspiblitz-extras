# RaspiBlitz Extras

WIP - help with testing is much appreciated.  

* login to your RaspiBlitz with the user `admin`:  
    `ssh admin@RASPIBLITZ_IP`

## Download the extra scripts

* Run these in the RaspiBlitz terminal to (re)download the scripts from this repo: 

    ```bash
    cd
    rm -rf raspiblitz-extras/
    git clone https://github.com/openoms/raspiblitz-extras.git
    cd raspiblitz-extras/
    sudo chmod -R +x *
    cp -rf * /home/admin/
    cd
    ```
*  install / reinstall the updated services.
---

### [lndmanage](https://github.com/bitromortac/lndmanage)
* Install:  
`$ ./config.scripts/bonus.lndmanage.sh`

* Usage (interactive mode):  
`$ source venv/bin/activate`  
`(venv) $ lndmanage `

### [Install the Fan-Shim software](/config.scripts/blitz.fanshim.sh)
* Install:  
`$ ./config.scripts/blitz.fanshim.sh`

* It is set to automatically stop under 55 and start above 70 degrees.  
More info here: https://learn.pimoroni.com/tutorial/sandyj/getting-started-with-fan-shim

### [LND Update](/config.scripts/lnd.update.sh)
#### v0.8.2-beta
* If you have downloaded this repo run:  
   `$ ./config.scripts/lnd.update.sh`
* To download and run with a single line:
`$ wget https://raw.githubusercontent.com/openoms/raspiblitz-extras/master/config.scripts/lnd.update.sh && bash lnd.update.sh`


### [Bitcoin Core Update](/config.scripts/bitcoin.update.sh)
#### v0.19.0.1
* If you have downloaded this repo run::  
   `$ ./config.scripts/bitcoin.update.sh`
* To download and run with a single line:  
`$ wget https://raw.githubusercontent.com/openoms/raspiblitz-extras/master/config.scripts/bitcoin.update.sh && bash bitcoin.update.sh`
* Not compatible with LND under v0.8.1, update LND first with the script above.

----

## Test the functions coming to the next release

Will need to sync the latest scripts from the v1.4 branch: https://github.com/rootzoll/raspiblitz/tree/v1.4

With the following commands:
```
cd /home/admin/raspiblitz
git remote set-url origin https://github.com/rootzoll/raspiblitz.git
/home/admin/XXsyncScripts.sh v1.4 -clean
cd
```
----

### BTCPay Server v1.0.3.144
https://github.com/rootzoll/raspiblitz/issues/214

* Use the `SERVICE` menu to install / uninstall.

* Read more and find basic help here:   
https://github.com/openoms/bitcoin-tutorials/blob/master/BTCPayServer/README.md


### BTC-RPC-Explorer
https://github.com/rootzoll/raspiblitz/issues/760
* Use the `SERVICE` menu to install / uninstall.


### RTL update to v0.5.4
* Use the `SERVICE` menu to uninstall the old version (if used) and install the updated version.
* Open in the browser to connect:  
`http://RASPIBLITZ_IP:3000`

### Electrum Rust Server v0.8.0 
https://github.com/rootzoll/raspiblitz/issues/123

* Use the `SERVICE` menu to install / uninstall.

* More info: https://github.com/openoms/bitcoin-tutorials/blob/master/electrs/README.md    


### Loop service  
https://github.com/rootzoll/raspiblitz/issues/454
* Use the `SERVICE` menu to install / uninstall.

* Usage:  
`$ loop out --channel CHANNEL_ID --amt MAX_2M_SATS_VALUE`  
Run `$ loop monitor` to monitor progress.

### Connect Fully Noded

* Sync the scripts from my forked repo as described on the top 
* Login with SSH and use the Tor menu to generate a QR for Fully Noded.
* Will activate the bitcoind wallet and txindex too in the process.
* More info and discussion: https://github.com/rootzoll/raspiblitz/issues/858

### Connect Zeus over Tor (Android)

* Sync the scripts from my forked repo as described on the top 
* Login with SSH and use the Tor menu to generate a QR code
* more info: https://github.com/openoms/bitcoin-tutorials/blob/master/Zeus_to_RaspiBlitz_through_Tor.md

### Connect Zap over Tor (iOS TestFlight)

* Sync the scripts from my forked repo as described on the top 
* Login with SSH and use the Tor menu to generate a QR code
* more info: https://github.com/openoms/bitcoin-tutorials/blob/master/Zap_to_RaspiBlitz_through_Tor.md


---

## Build the SDcard from the test branch:

* Download and flash the Raspbian Buster image (https://github.com/rootzoll/raspiblitz#build-the-sd-card-image)
* Put the empty file called `ssh` to root of the boot partition of the SDcard
* Use this command to build: 
`wget https://raw.githubusercontent.com/rootzoll/raspiblitz/v1.4/build_sdcard.sh && sudo bash build_sdcard.sh v1.4`

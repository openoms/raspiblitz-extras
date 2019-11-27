# RaspiBlitz Extras

WIP - help with testing is much appreciated.  

* login to your RaspiBlitz with the user `admin`:  
    `ssh admin@RASPIBLITZ_IP`

## Download the scripts

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

### [BTCPay Server v1.0.3.144](config.scripts/bonus.btcpayserver.sh)
https://github.com/rootzoll/raspiblitz/issues/214

* Use the `SERVICE` menu to install / uninstall.

* Read more and find basic help here:   
https://github.com/openoms/bitcoin-tutorials/blob/master/BTCPayServer/README.md


### [BTC-RPC-Explorer](/config.scripts/bonus.btc-rpc-explorer.sh)
https://github.com/rootzoll/raspiblitz/issues/760
* Use the `SERVICE` menu to install / uninstall.

* Once the txindex is created open in a browser to connect:  
`http://RASPIBLITZ_IP:3002`

* For the RPC Browser and Terminal:
    * username can be anything (not checked)
    * password is the `Password_B` of the RaspiBlitz

### [RTL update to v0.5.4](/config.scripts/bonus.rtl.sh)
* Use the `SERVICE` menu to uninstall the old version (if used) and install the updated version.
* Open in the browser to connect:  
`http://RASPIBLITZ_IP:3000`

### [Electrum Rust Server v0.8.0](/config.scripts/bonus.electrs.sh) 
https://github.com/rootzoll/raspiblitz/issues/123
* Install:  
`$ ./config.scripts/bonus.electrs.sh on`

* More info: https://github.com/openoms/bitcoin-tutorials/blob/master/electrs/README.md    

### [lndmanage](https://github.com/bitromortac/lndmanage)
* Install:  
`$ ./config.scripts/bonus.lndmanage.sh`

* Usage (interactive mode):  
`$ source venv/bin/activate`  
`(venv) $ lndmanage `

### [Loop service](/config.scripts/bonus.loop.sh)  
https://github.com/rootzoll/raspiblitz/issues/454
* Install:  
`$ ./config.scripts/bonus.loop.sh`

* Usage:  
`$ loopd` or `$ loopd &` to keep working in the same window  
`$ loop out --channel CHANNEL_ID --amt MAX_2M_SATS_VALUE`  
Run `$ loop monitor` to monitor progress.

### [Install the Fan-Shim software](/config.scripts/blitz.fanshim.sh)
* Install:  
`$ ./config.scripts/blitz.fanshim.sh`

* It is set to automatically stop under 55 and start above 70 degrees.  
More info here: https://learn.pimoroni.com/tutorial/sandyj/getting-started-with-fan-shim

### [LND update to v0.8.1-beta](/config.scripts/lnd.update.sh)

* If you have downloaded this repo run:  
   `$ ./config.scripts/lnd.update.sh`

* To download and run with a single line:  
`$ wget https://raw.githubusercontent.com/openoms/raspiblitz-extras/master/config.scripts/lnd.update.sh && bash lnd.update.sh`

* note that the status screen will continue to display `LND v0.8.0-beta`

### [Bitcoin Core update to v0.19.0.1](/config.scripts/bitcoin.update.sh)
* If you have downloaded this repo run::  
   `$ ./config.scripts/bitcoin.update.sh`
* To download and run with a single line:  
`$ wget https://raw.githubusercontent.com/openoms/raspiblitz-extras/master/config.scripts/bitcoin.update.sh && bash bitcoin.update.sh`

* Not compatible with LND under v0.8.1, update LND first with the script above.
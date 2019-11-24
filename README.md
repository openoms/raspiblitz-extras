# RaspiBlitz Extras

WIP - help with testing is much appreciated.  

* login to your RaspiBlitz with the user `admin`:  
    `ssh admin@RASPIBLITZ_IP`

## Prepare the extras

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

### BTCPay Server
https://github.com/rootzoll/raspiblitz/issues/214

* Use the `SERVICE` menu to install / uninstall.

* Read more and find basic help here:   
https://github.com/openoms/bitcoin-tutorials/blob/master/BTCPayServer/README.md


### [BTC-RPC-Explorer](https://github.com/janoside/btc-rpc-explorer)
https://github.com/rootzoll/raspiblitz/issues/760
* Use the `SERVICE` menu to install / uninstall.

* Once the txindex is created open in a browser to connect:  
`http://RASPIBLITZ_IP:3002`

* For the RPC Browser and Terminal:
    * username can be anything (not checked)
    * password is the `Password_B` of the RaspiBlitz

### [RTL update to v0.5.4](https://github.com/Ride-The-Lightning/RTL/releases)
* Use the `SERVICE` menu to uninstall the old version (if used) and install the updated version.
* Open in the browser to connect:  
`http://RASPIBLITZ_IP:3000`

### [Electrum Rust Server](https://github.com/romanz/electrs)
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

### [Loop service](https://github.com/lightninglabs/loop)  
https://github.com/rootzoll/raspiblitz/issues/454
* Install:  
`$ ./config.scripts/bonus.loop.sh`

* Usage:  
`$ loopd` or `$ loopd &` to keep working in the same window  
`$ loop out --channel CHANNEL_ID --amt MAX_2M_SATS_VALUE`  
Run `$ loop monitor` to monitor progress.

### Install the Fan-Shim software
* Install:  
`$ ./config.scripts/blitz.fanshim.sh`

* It is set to automatically stop between 55 and 70 degrees.
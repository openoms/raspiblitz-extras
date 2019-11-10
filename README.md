# RaspiBlitz Extras

WIP - help with testing is much appreciated.  
If a RaspiBlitz setup breaks restoring to a clean SDcard image is the easiest solution.

## Prepare
```bash
git clone https://github.com/openoms/raspiblitz-extras.git
cd raspiblitz-extras/
# use `git pull` if updating
sudo chmod -R +x *
cp -r * /home/admin/
cd
```
---
### [BTC-RPC-Explorer](https://github.com/janoside/btc-rpc-explorer)
https://github.com/rootzoll/raspiblitz/issues/760
* Install:  
`$ ./config.scripts/bonus.btc-rpc-explorer.sh on`

* Open in browser to connect:  
`http://RASSPIBLITZ_IP:3002`

### [lndmanage](https://github.com/bitromortac/lndmanage)
* Install:  
`$ ./config.scripts/bonus.lndmanage.sh`

* Usage (interactive mode):  
`$ source venv/bin/activate`  
`(venv) $ lndmanage `

### [RTL update to v0.5.4](https://github.com/Ride-The-Lightning/RTL/releases)
* Remove previous version:  
`$ ./config.scripts/update.rtl.sh off`

* Install the latest:  
`$ ./config.scripts/update.rtl.sh on`

* Open in browser to connect:  
`http://RASPIBLITZ_IP:3000`

### [Loop service](https://github.com/lightninglabs/loop)  
https://github.com/rootzoll/raspiblitz/issues/454
* Install:  
`$ ./config.scripts/bonus.loop.sh`

* Usage:  
`$ loopd` or `$ loopd &` to keep working in the same window  
`$ loop out --channel CHANNEL_ID --amt MAX_2M_SATS_VALUE`  
Run `$ loop monitor` to monitor progress.
# RaspiBlitz #reckless update

## Test the functions coming to the next release

Will need to sync the latest scripts from the v1.5 branch: https://github.com/rootzoll/raspiblitz/tree/v1.5

With the following commands:
```
cd /home/admin/raspiblitz
# set rootzoll's repo (default)
git remote set-url origin https://github.com/rootzoll/raspiblitz.git
# update
git pull
/home/admin/XXsyncScripts.sh v1.5 -clean
cd
```
----

### Bitcoin Core Update
#### v0.19.1
* Not compatible with LND under v0.8.1, use with RaspiBlitz v1.4 or update LND first.
* To download and run with a single line:  
`$ wget https://raw.githubusercontent.com/openoms/raspiblitz-extras/master/config.scripts/bitcoin.update.sh && bash bitcoin.update.sh`

#### [v0.19.0.1](/config.scripts/bitcoin.update.sh)
* If you have downloaded this repo run::  
   `$ ./config.scripts/bitcoin.update.sh`
* To download and run with a single line:  
`$ wget https://raw.githubusercontent.com/openoms/raspiblitz-extras/master/config.scripts/bitcoin.update.sh && bash bitcoin.update.sh`
* Not compatible with LND under v0.8.1, update LND first with the script above.

----

## Build the SDcard from the test branch:

* Download and flash the Raspbian Buster image (https://github.com/rootzoll/raspiblitz#build-the-sd-card-image)
* Put the empty file called `ssh` to root of the boot partition of the SDcard
* Use this command to build: 
`wget https://raw.githubusercontent.com/rootzoll/raspiblitz/v1.5/build_sdcard.sh && sudo bash build_sdcard.sh v1.5`

---

## Will not be included in the release:

### [Install the Fan-Shim software](/config.scripts/blitz.fanshim.sh)
* Install:  
`$ wget https://raw.githubusercontent.com/openoms/raspiblitz-extras/master/config.scripts/blitz.fanshim.sh && bash blitz.fanshim.sh`

* It is set to automatically stop under 55 and start above 70 degrees.  
More info here: https://learn.pimoroni.com/tutorial/sandyj/getting-started-with-fan-shim

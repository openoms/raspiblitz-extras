# RaspiBlitz Extras

## Prepare
```bash
git clone https://github.com/openoms/raspiblitz-extras.git
cd raspiblitz-extras/
sudo chmod -R +x *
cd config.scripts/
```
---
### Loop service

* Install:  
`./loop_service.sh `

* Usage:

`loopd` or `loopd &` to keep working in the same window

`loop out --channel CHANNEL_ID --amt MAX_2M_SATS_VALUE`  

Run `loop monitor` to monitor progress.

To open a channel to the loop server (min 0.08 BTC):  
```bash
lncli connect 021c97a90a411ff2b10dc2a8e32de2f29d2fa49d41bfbb52bd416e460db0747d0d@18.224.56.146:9735`

lncli openchannel 021c97a90a411ff2b10dc2a8e32de2f29d2fa49d41bfbb52bd416e460db0747d0d MIN_8M_SATS_VALUE
```
---
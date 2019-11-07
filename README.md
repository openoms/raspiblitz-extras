# raspiblitz-extras
```
git clone https://github.com/openoms/raspiblitz-extras.git

cd raspiblitz-extras/

sudo chmod -R +x *

cd config.scripts/

./loop_service.sh 

loopd

loop out --channel CHANNEL_ID --amt SATS

Run `loop monitor` to monitor progress.

To open a channel to the loop server:
`lncli connect 021c97a90a411ff2b10dc2a8e32de2f29d2fa49d41bfbb52bd416e460db0747d0d@18.224.56.146:9735`

```

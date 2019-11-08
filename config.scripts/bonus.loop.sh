#!/bin/bash

./go.install.sh

source /home/admin/raspiblitz.info
sudo cp -rf /mnt/hdd/lnd/data/chain/${network}/${chain}net /home/admin/.lnd/data/chain/${network}/
sudo chown admin:admin /home/admin/.lnd/data/chain/${network}/${chain}net/*.macaroon

cd /home/admin
git clone https://github.com/lightninglabs/loop.git /home/admin/loop
cd /home/admin/loop
go install ./...

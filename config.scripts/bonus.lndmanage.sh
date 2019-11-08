#!/bin/bash

# activate virtual environment
sudo apt install -y python3-venv
python3 -m venv venv
source venv/bin/activate
# get dependencies
sudo apt install -y python3-dev libatlas-base-dev
pip3 install wheel
python3 -m pip install lndmanage
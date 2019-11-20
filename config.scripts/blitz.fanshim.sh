cd
git clone https://github.com/openoms/fanshim-python
cd fanshim-python
sudo ./install.sh

cd examples
sudo ./install-service.sh --on-threshold 55 --off-threshold 70 --delay 2
cd
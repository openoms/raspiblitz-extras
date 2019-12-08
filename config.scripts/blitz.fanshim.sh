cd
git clone https://github.com/openoms/fanshim-python
cd fanshim-python
sudo ./install.sh

cd examples
sudo ./install-service.sh --on-threshold 70 --off-threshold 55 --delay 2
cd

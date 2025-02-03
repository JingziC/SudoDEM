#!/bin/bash

# system level dependencies
sudo apt-get update
sudo apt-get install -y build-essential cmake zlib1g-dev freeglut3-dev libbz2-dev libglib2.0 python3-dev python3-pip python3-tk

# Qt5 based library
#sudo apt-get install -y qt5-default libqt5svg5-dev libqt5webkit5-dev libqt5designer5
sudo apt-get install -y qtbase5-dev qt5-qmake libqt5svg5-dev libqt5webkit5-dev libqt5designer5
# python pip dependencies
python3 -m pip install numpy matplotlib xlib ipython

#bzip2
wget https://sourceware.org/pub/bzip2/bzip2-1.0.8.tar.gz
tar xzf bzip2-1.0.8.tar.gz
cd bzip2-1.0.8
make
sudo make install
cd ..

OS="ubuntu-20.04"

cd ..
mkdir -p 3rdlib/3rdlibs/py

# download pre-compiled tools
wget https://github.com/SudoDEM/3rdlibs/releases/latest/download/tools-${OS}.tar.xz
tar xf tools-${OS}.tar.xz

WORKSPACE=$PWD

wget https://github.com/SudoDEM/SudoDEM/releases/download/v1.3.8-rc2/SudoDEM3D-${OS}.tar.xz
tar xf SudoDEM3D-${OS}.tar.xz
# change all "unicode(" in sudodeminstall/SudoDEM3D/lib/sudodem/py/sudodem/qt/Inspector.py to "str("
sudo grep -rl "unicode(" sudodeminstall/SudoDEM3D/lib/sudodem/py/sudodem/qt/Inspector.py | xargs sed -i 's/unicode(/str(/g'

wget https://github.com/SudoDEM/SudoDEM/releases/download/v1.3.8-rc2/SudoDEM2D-${OS}.tar.xz
tar xf SudoDEM2D-${OS}.tar.xz
# change all "unicode(" in sudodeminstall/SudoDEM2D/lib/sudodem/py/sudodem/qt/Inspector.py to "str("
sudo grep -rl "unicode(" sudodeminstall/SudoDEM2D/lib/sudodem/py/sudodem/qt/Inspector.py | xargs sed -i 's/unicode(/str(/g'

echo 'PATH=${PATH}:'$WORKSPACE/sudodeminstall/SudoDEM2D/bin':'$WORKSPACE/sudodeminstall/SudoDEM3D/bin >> ~/.bashrc

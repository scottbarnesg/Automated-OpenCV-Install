#!/bin/bash

echo "Starting Install of OpenCV"
echo "This will required root permissions..."

echo "Installing dependencies"
sudo apt-get install build-essential git cmake pkg-config
sudo apt-get install libjpeg8-dev libtiff4-dev libjasper-dev libpng12-dev
sudo apt-get install libavcodec-dev libavformat-dev libswscale-dev libv4l-dev
sudo apt-get install libgtk2.0-dev
sudo apt-get install libatlas-base-dev gfortran
sudo apt-get install git
echo "Done installing dependencies"

echo "Which version of OpenCV would you like to install?"
read version

echo "Installing OpenCV version $version"
cd ~
git clone https://github.com/opencv/opencv.git
cd opencv
git checkout "$version"

echo "Installing python header files"
sudo apt-get install python2.7-dev

echo "Installing Pip"
wget https://bootstrap.pypa.io/get-pip.py
sudo python get-pip.py

echo "Installing virtualenv"
sudo pip install virtualenv virtualenvwrapper

echo "Clearing Pip cache"
sudo rm -rf ~/.cache/pip

echo "Updating .profile with virtual environment"
echo ~/.profile >> "# virtualenv and virtualenvwrapper"
echo ~/.profile >> "export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python2.7"
echo ~/.profile >> "export WORKON_HOME=$HOME/.virtualenvs"
echo ~/.profile >> "source /usr/local/bin/virtualenvwrapper.sh"
source ~/.profile

echo "What would you like to name your virtual environment?"
read env_name

echo "Creating virtual environment $env_name"
mkvirtualenv $env_name
echo "Done creating virtual environment"
echo "You can activate this environment by entering workon '$env_name' after the install"

echo "Installing dependencies in virtual environment"
workon $env_name
pip install numpy

echo "Building OpenCV"
cd ~/opencv
mkdir build
cd build
cmake -D CMAKE_BUILD_TYPE=RELEASE \
	-D CMAKE_INSTALL_PREFIX=/usr/local \
	-D INSTALL_C_EXAMPLES=OFF \
	-D INSTALL_PYTHON_EXAMPLES=ON \
	-D BUILD_EXAMPLES=ON ..

echo "Making OpenCV"
echo "This may take a while..."
make -j4
echo "Done making OpenCV"

echo "Installing OpenCV"
sudo make install
sudo ldconfig

echo "Creating symbolic link to OpenCV"
cd ~/.virtualenvs/cv3/lib/python2.7/site-packages/
ln -s /usr/local/lib/python2.7/site-packages/cv2.so cv2.so

echo "Verifying OpenCV Installed Correctly"
python import cv2

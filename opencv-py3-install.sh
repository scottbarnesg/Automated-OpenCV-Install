# Get newest packages
echo "Getting apt updates... "
sudo apt-get -y update && sudo apt-get -y upgrade
# Install dependencies
echo "Installing dependencies..."
sudo apt-get -y install cmake build-essential pkg-config git \
libjpeg-dev libtiff-dev libjasper-dev libpng-dev libwebp-dev libopenexr-dev \
libavcodec-dev libavformat-dev libswscale-dev libv4l-dev libxvidcore-dev libx264-dev libdc1394-22-dev libgstreamer-plugins-base1.0-dev libgstreamer1.0-dev \
libgtk-3-dev libqtgui4 libqtwebkit4 libqt4-test python3-pyqt5 \
libatlas-base-dev liblapacke-dev gfortran \
libhdf5-dev libhdf5-103 \
python3-dev python3-pip python3-numpy
# Clone opencv
echo "Cloning OpenCV..."
git clone https://github.com/opencv/opencv.git
# Create build dir
mkdir opencv/build
cd opencv/build
# Make
echo "Building OpenCV..."
cmake -D CMAKE_BUILD_TYPE=RELEASE \
	-D CMAKE_INSTALL_PREFIX=/usr/local \
	-D INSTALL_C_EXAMPLES=OFF \
	-D INSTALL_PYTHON_EXAMPLES=OFF \
	-D BUILD_EXAMPLES=OFF ..
echo "Making OpenCV..."
make -j3  # One less than cores, so make sure we dont compile the pi to death
echo "Installing OpenCV..."
sudo make install
sudo ldconfig
echo "Done."


#!/bin/bash

echo "==> Installing toolchain for building..."
#sudo apt-get -f -y install autoconf


echo
echo "==> Installing dependencies..."
# @see http://sourceforge.net/p/ganglia/code/HEAD/tree/trunk/monitor-core/INSTALL
sudo apt-get -f -y install   \
       pkg-config libapr1 libapr1-dev \
       libconfuse0 libconfuse-dev     \
       libexpat1 libexpat1-dev        \
       libpcre3-dev                   \
       zlib1g-dev


echo
echo "===> Downloading Ganglia source..."
curl -L -o ganglia.tar.gz http://sourceforge.net/projects/ganglia/files/ganglia%20monitoring%20core/3.6.1/ganglia-3.6.1.tar.gz/download
tar zxvf ganglia.tar.gz
cd ganglia-3.6.1


echo
echo "==> Configuring Ganglia..."
#aclocal
#autoheader
#automake --add-missing
#autoconf
./configure --with-static-modules --disable-python --disable-sflow
#./configure --enable-static-build --with-static-modules --disable-python --disable-sflow
#./configure --enable-static-build --disable-python --disable-sflow


echo
echo "==> Building..."
make
#sudo make install


echo
echo "==> Done!"

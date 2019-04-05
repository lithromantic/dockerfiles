#!/bin/bash

GANGLIA_VERSION=3.6.1
GANGLIA_ROOT=ganglia-$GANGLIA_VERSION

GMOND_ROOT=$GANGLIA_ROOT/gmond
GMOND_ELF=$GMOND_ROOT/.libs/gmond

GMETRIC_ROOT=$GANGLIA_ROOT/gmetric
GMETRIC_ELF=$GMETRIC_ROOT/.libs/gmetric


echo "=====> Building Ganglia..."
./make-ganglia.sh


echo
echo "=====> Packing gmond and gmetric executables and dependencies..."
./extract-elf-so_static_linux-amd64  \
    --add /lib/x86_64-linux-gnu/libexpat.so.1            \
    --add $GANGLIA_ROOT/lib/.libs/libganglia-3.6.1.so.0  \
    $GMOND_ELF  $GMETRIC_ELF



echo
echo "=====> Packing modules..."
./add-modules.pl  $GANGLIA_ROOT
gzip -9 rootfs.tar


echo
echo "=====> Done!"

# docker run -it -p 8649:8649

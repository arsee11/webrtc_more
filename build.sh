#!/bin/bash

HOME_DIR=$(pwd)
cd webrtc/experiments/
python field_trials.py header > registered_field_trials.h 
cd ${HOME_DIR}

mkdir -p lib
cd third_party/libsrtp
./configure
make -j4
cp libsrtp2.a ${HOME_DIR}/lib
cd ${HOME_DIR}

cd third_party/libyuv
mkdir -p build 
cd build
cmake ../
make -j4
cp libyuv.a ${HOME_DIR}/lib
cd ${HOME_DIR}

echo "prefix=${HOME_DIR}
exec_prefix=\${prefix}
includedir=\${prefix}

Name: webrtc_more 
Description: webrtc deps library 
Version: 1.0.0
Cflags: -I\${includedir}" > webrtc_more.pc

echo "Copy webrtc_more.pc to /us/local/lib/pkgconfig/"
sudo cp webrtc_more.pc /usr/local/lib/pkgconfig/

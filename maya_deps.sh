#!/bin/bash

# Dependent OpenGL libraries
yum -y install mesa-libGLw mesa-libGLU libglvnd*64

# Dependent X Windows libraries
yum -y install libXp libXpm libXmu libXt libXi libXext libX11 libXinerama libXau libxcb libXcomposite

# Dependent System libraries
yum -y install gamin audiofile audiofile-devel e2fsprogs-libs glibc zlib libSM libICE openssl098e tcsh pulseaudio-libs libxslt alsa-lib

# Fonts
yum -y install xorg-x11-fonts-ISO8859-1-100dpi xorg-x11-fonts-ISO8859-1-75dpi liberation-mono-fonts liberation-fonts-common liberation-sans-fonts liberation-serif-fonts

# Extras for Setup and Launch
yum -y install libpng12 libtiff

cd /usr/lib64
ln -s libtiff.so.5 libtiff.so.3

# From Mottoso/Mayabase-Centos
yum update -y && yum install -y nano csh elfutils gcc gstreamer-plugins-base.x86_64 git mesa-utils mesa-libGL-devel tcsh xorg-x11-server-Xorg xorg-x11-server-Xvfb wget
yum groupinstall -y "X Window System" &&
yum clean all

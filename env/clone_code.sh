#!/bin/sh

script_path=$(dirname "$0")

echo "Setup your precious code directory"

mkdir -p ~/code/auvsi

# clone auvsi stuff:
cd ~/code/auvsi
git clone https://github.com/BYU-AUVSI/imaging.git
git clone https://github.com/BYU-AUVSI/interop_pkg.git
git clone https://github.com/BYU-AUVSI/a6000_ros.git
git clone https://github.com/BYU-AUVSI/uav_msgs.git
git clone https://github.com/BYU-AUVSI/scripts.git

# get everything else i want
cd ~/code
# ROSFlight stuff
git clone https://github.com/rosflight/airbourne_f4.git
git clone https://github.com/rosflight/firmware.git firmware_rosflight
git clone https://github.com/rosflight/rosflight.git
git clone https://github.com/rosflight/BreezySTM32.git breezy_rosflight
# my stuff
git clone https://github.com/len0rd/YamaCrawler.git yama
git clone https://github.com/len0rd/personal-website.git
git clone https://github.com/len0rd/Repley.git repley
git clone https://github.com/len0rd/leoconfig.git leoconfig

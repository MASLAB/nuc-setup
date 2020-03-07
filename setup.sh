#!/bin/bash

# Install Git and Python
sudo apt install -y git
sudo apt install -y python python-setuptools

# Install SSH
sudo apt install -y openssh-server

# Set up ROS and dependencies
sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
sudo apt-key adv --keyserver 'hkp://keyserver.ubuntu.com:80' --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654
sudo apt update
sudo apt install -y ros-melodic-desktop
sudo rosdep init
rosdep update
echo "source /opt/ros/melodic/setup.bash" >> ~/.bashrc
source ~/.bashrc
sudo apt install -y python-rosinstall python-rosinstall-generator python-wstool bui

# Set up Teensy USB rules
wget https://www.pjrc.com/teensy/49-teensy.rules
sudo cp 49-teensy.rules /etc/udev/rules.d/

# Set up TAMProxy Host library
git clone https://github.com/MASLAB/TAMProxy-pyHost
cd TAMProxy-pyHost
python setup.py install --user
cd ..

# Set up Poll Me Maybe
sudo mv pollmemaybe.sh /usr/local/bin/pollmemaybe.sh
sudo apt install -y curl
crontab -l 2> /dev/null | { cat; echo "* * * * * sh /usr/local/bin/pollmemaybe.sh > /dev/null"; } | crontab -

# Set up Git
git config --global user.name "Team $1"
git config --global user.email maslab-2020-team-$1@mit.edu
ssh-keygen -t rsa -b 4096 -C "maslab-2020-team-$1@mit.edu"
cat ~/.ssh/id_rsa.pub

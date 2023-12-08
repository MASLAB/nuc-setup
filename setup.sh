#!/bin/bash

# Install Git
sudo apt install -y git

# Install SSH
sudo apt install -y openssh-server

# Set up ROS 2 and dependencies
sudo apt install software-properties-common
sudo add-apt-repository universe
sudo apt update && sudo apt install curl -y
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(. /etc/os-release && echo $UBUNTU_CODENAME) main" | sudo tee /etc/apt/sources.list.d/ros2.list > /dev/null
sudo apt update
sudo apt upgrade
sudo apt install ros-humble-desktop
echo "source /opt/ros/humble/setup.bash" >> ~/.bashrc
souce ~/.bashrc

# Set up Teensy USB rules
wget https://www.pjrc.com/teensy/00-teensy.rules
sudo cp 00-teensy.rules /etc/udev/rules.d/

# Set up TAMProxy Host library
git clone https://github.com/MASLAB/TAMProxy-pyHost
cd TAMProxy-pyHost
python3 setup.py install --user
cd ..

# Install pygame for kitbot demo
sudo apt-get install -y python3-pip
pip install pygame

# Set up Poll Me Maybe
sudo mv pollmemaybe.sh /usr/local/bin/pollmemaybe.sh
sudo apt install -y curl
crontab -l 2> /dev/null | { cat; echo "* * * * * sh /usr/local/bin/pollmemaybe.sh > /dev/null"; } | crontab -

# Set up Git
git config --global user.name "Team $1"
git config --global user.email maslab-2022-team-$1@mit.edu
ssh-keygen -t rsa -b 4096 -C "maslab-2022-team-$1@mit.edu"
cat ~/.ssh/id_rsa.pub

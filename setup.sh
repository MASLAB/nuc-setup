#!/bin/bash

# Install Git
sudo apt install -y git

# Install SSH
sudo apt install -y openssh-server

# Set up ROS and dependencies
sudo apt update && sudo apt install curl gnupg2 lsb-release
sudo curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key  -o /usr/share/keyrings/ros-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(source /etc/os-release && echo $UBUNTU_CODENAME) main" | sudo tee /etc/apt/sources.list.d/ros2.list > /dev/null

sudo apt update
sudo apt install -y ros-foxy-desktop python3-rosdep
sudo rosdep init
rosdep update
echo "source /opt/ros/foxy/setup.bash" >> ~/.bashrc
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
git config --global user.email maslab-2022-team-$1@mit.edu
ssh-keygen -t rsa -b 4096 -C "maslab-2022-team-$1@mit.edu"
cat ~/.ssh/id_rsa.pub

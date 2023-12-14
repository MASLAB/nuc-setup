#!/bin/bash

# Install Git
sudo apt install -y git

# Install SSH
sudo apt install -y openssh-server

# Set up ROS 2 and dependencies
sudo apt-key adv --fetch-keys https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc
sudo apt-add-repository http://packages.ros.org/ros2/ubuntu
sudo apt update
sudo apt install -y ros-humble-desktop python3-rosdep python3-argcomplete python3-colcon-common-extensions
sudo rosdep init
rosdep update
echo "source /opt/ros/humble/setup.bash" >> ~/.bashrc
echo "export ROS_MASTER_URI=http://\$(hostname -I | cut -d' ' -f1):11311" >> ~/.bashrc
source ~/.bashrc

# Set up Teensy USB rules
sudo cp 00-teensy.rules /etc/udev/rules.d/
sudo udevadm control --reload

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

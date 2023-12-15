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
echo "export ROS_MASTER_URI=http://$(hostname -I | cut -d' ' -f1):11311" >> ~/.bashrc
source ~/.bashrc

# Set up Teensy and Arduino USB rules
sudo cp 00-teensy.rules /etc/udev/rules.d/
sudo cp 99-arduino.rules /etc/udev/rules.d/
sudo udevadm control --reload

# Set up TAMProxy Host library
git clone https://github.com/MASLAB/TAMProxy-pyHost
cd TAMProxy-pyHost
python3 setup.py install --user
cd ..

# Set up Arduino 2
sudo add-apt-repository universe
sudo apt install libfuse2
wget -O arduino2.AppImage https://downloads.arduino.cc/arduino-ide/arduino-ide_latest_Linux_64bit.AppImage 
chmod u+x arduino2.AppImage
sudo mv arduino2.AppImage /usr/local/bin/arduino2.AppImage
/usr/local/bin/arduino2.AppImage --appimage-extract
cp arduino-ide.desktop ~/.local/share/applications/
sudo cp -r ./squashfs-root/usr/share/icons/hicolor/512x512/apps/* /usr/share/icons/hicolor/512x512/apps/
rm -rf squashfs-root

# Install pygame for kitbot demo
sudo apt-get install -y python3-pip
pip install pygame

# Set up Poll Me Maybe
sudo mv pollmemaybe.sh /usr/local/bin/pollmemaybe.sh
sudo apt install -y curl
crontab -l 2> /dev/null | { cat; echo "* * * * * sh /usr/local/bin/pollmemaybe.sh > /dev/null"; } | crontab -

# Set up Git
git config --global user.name "Team $1"
git config --global user.email maslab-$2-team-$1@mit.edu
ssh-keygen -t rsa -b 4096 -C "maslab-$2-team-$1@mit.edu"
cat ~/.ssh/id_rsa.pub
read -p "Add SSH to team repository deploy key then press any key to continue... " -n1 -s
git clone git@github.mit.edu:maslab-$2/team-$1.git
git clone https://github.com/MASLAB/kitware.git

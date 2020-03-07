# MASLAB NUC Setup

This repository contains the scripts used for setting up the NUC development
environment for MASLAB.

Currently, the script handles the following:
- Installing Git, Python, and an SSH server
- Installing the full ROS Melodic desktop w/ rospy
- Setting up Teensy USB rules
- Setting up TAMProxy host library
- Setting up Poll Me Maybe
- Git configuration + generating SSH key

## Setup Steps

Prerequisites:
- A NUC per team with SSD and RAM installed
- Git repo set up for each team (normally on MIT Github)
- USB flash drive with Ubuntu 18.04 install image

For each NUC:
1. Install full Ubuntu 18.04
2. Connect to Wifi network(s)
3. Download this repo (either through `git clone` or zip distribution)
4. Run setup script, passing in team number as first argument: `./setup.sh <team-number>`
5. Copy SSH public key (output of script) and add it as a deploy key to the team
   repo
6. Clone team's repository to home directory: `cd ~ && git clone <url>`

And you're done! Feel free to delete this repo from the NUC.

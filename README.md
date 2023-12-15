# MASLAB NUC Setup

This repository contains the scripts used for setting up the NUC development
environment for MASLAB.

Currently, the script handles the following:
- Installing Git, Python, and an SSH server
- Installing the full ROS Foxy desktop w/ rospy
- Setting up Teensy USB rules
- Setting up TAMProxy host library
- Setting up Poll Me Maybe
- Git configuration + generating SSH key

## Setup Steps

Prerequisites:
- A NUC per team with SSD and RAM installed
- Git repo set up for each team (normally on MIT Github)
- USB flash drive with Ubuntu 22.04 install image

For each NUC:
1. Install full Ubuntu 22.04
   - Minimal installation
   - Set username and hostname to `teamX`
3. Connect to Wifi network(s)
4. Download this repo (either through `git clone` or zip distribution)
5. Run setup script, passing in team number as first argument and MASLAB year as second argument:  
   `./setup.sh <team-number> <maslab-year>`
7. Copy SSH public key (output of script) and add it as a deploy key to the team repo
   
And you're done! Feel free to delete this repo from the NUC.

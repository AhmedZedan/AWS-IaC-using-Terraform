#!/bin/bash

# install apache2
sudo apt update
sudo apt install apache2 -y

# make sure apache2 is started
sudo systemctl start apache2
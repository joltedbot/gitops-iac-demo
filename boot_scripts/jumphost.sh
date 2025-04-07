#!/bin/bash

sudo apt-get --yes update
sudo apt-get --yes install fish
sudo echo "10.0.2.12 cloudflare" >> /etc/hosts
sudo echo "10.0.2.10 webserver" >> /etc/hosts
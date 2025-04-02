#!/bin/bash

sudo apt-get --yes update
sudo apt-get --yes install fish
curl -L "https://packages.gitlab.com/install/repositories/runner/gitlab-runner/script.deb.sh" | sudo bash
sudo apt-get --yes install gitlab-runner
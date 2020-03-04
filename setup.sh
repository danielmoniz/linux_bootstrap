#!/bin/bash

# Installations -----------
sudo apt-get update

# git
sudo apt install git
git config --global user.email "daniel.moniz@gmail.com"
git config --global user.name "Daniel Moniz"

sudo apt install openssh-client openssh-server
sudo apt install xclip

# Start services -----------
service ssh start
service --status-all | grep ssh # check that ssh service is started

# Add structure and aliases ----------
cd ~/
mkdir dev
cd dev/
touch ~/.bashrc # Ensure .bashrc file exists
echo "\n\n# Custom --------------" >> ~/.bashrc
echo 'alias pbcopy="xclip -i -sel c -f |xclip -i -sel p"' >> ~/.bashrc
echo 'alias gs="git status"' >> ~/.bashrc
source ~/.bashrc 

# SSH setup --------------
ssh-keygen -t rsa -b 4096 -C "daniel.moniz@gmail.com"
ssh-add ~/.ssh/id_rsa
cat ~/.ssh/id_rsa.pub | pbcopy
# Need to pause with message to add SSH key to GitHub - press Enter to continue
ssh -T git@github.com # Check that github connection works


# Clone repositories -------------
# git clone https://github.com/danielmoniz/linux_bootstrap # Should already have this!
# git clone git@github.com:danielmoniz/rl_replay_data.git

# Python setup -----
# pyenv
curl https://pyenv.run | bash
echo 'export PATH="/home/daniel/.pyenv/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(pyenv init -)"' >> ~/.bashrc
echo 'eval "$(pyenv virtualenv-init -)"' >> ~/.bashrc
sudo apt-get install -y make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev xz-utils tk-dev libffi-dev liblzma-dev python-openssl git
source ~/.bashrc
pyenv update

pip install virtualenv

# docker
sudo apt-get remove docker docker-engine docker.io containerd runc # uninstall old versions
sudo apt-get install apt-transport-https ca-certificates curl gnupg-agent software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88 # verify fingerprint
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(. /etc/os-release; echo "$UBUNTU_CODENAME") stable"
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose
sudo groupadd docker # create docker user group
sudo usermod -aG docker $USER # add current user to docker group
sudo docker run hello-world # check that docker is now working
# NOTE: Need to log out and log back in again to use Docker without sudo


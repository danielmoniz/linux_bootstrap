#!/bin/bash

# Installations -----------
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

# pyenv
curl https://pyenv.run | bash
echo 'export PATH="/home/daniel/.pyenv/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(pyenv init -)"' >> ~/.bashrc
echo 'eval "$(pyenv virtualenv-init -)"' >> ~/.bashrc
source ~/.bashrc
pyenv update

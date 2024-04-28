#!/bin/bash


user="$USER"

# Installa sudo se non è già installato
apt update
apt upgrade -y
apt install -y sudo

# Aggiunge l'utente al gruppo sudo
sudo usermod -aG sudo "$user"

# Modifica il file sudoers per concedere i privilegi di sudo all'utente
echo "$user ALL=(ALL:ALL) ALL" >> /etc/sudoers





sudo apt-get install apt-transport-https ca-certificates curl gnupg2 software-properties-common sudo -y

sudo curl -fsSL https://download.docker.com/linux/$(. /etc/os-release; echo "$ID")/gpg | sudo apt-key add -

sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/$(. /etc/os-release; echo "$ID") $(lsb_release -cs) stable"

sudo apt update

sudo apt install docker-ce -y

sudo apt install docker-compose -y

curl -o- https://raw.githubusercontent.com/immich-app/immich/main/install.sh | sudo bash

#!/bin/bash


# Funzione per l'installazione su Rocky o CentOs Linux
# Script creato da Luca Droi :) 
    read -p "Premi enter per aggiungere i repository Docker e installare l'ultima versione di Immich!"
    sudo dnf upgrade -y
    # Installation epel source (also called repository)
    sudo dnf -y install epel-release
    # Generate cache
    sudo dnf makecache
    # Install htop
    sudo dnf install htop bmon nload   bash-completion  -y
    sudo dnf install -y avahi
    sudo dnf install -y dnf-plugins-core
    sudo dnf install bash-completion -y
    
      sudo dnf config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
    sudo dnf install -y docker-ce docker-ce-cli containerd.io
    sudo dnf install docker-compose-plugin
    sudo systemctl start docker
    sudo systemctl enable docker
    sudo dnf install -y docker-compose


# Installa Immich
sudo curl -o- https://raw.githubusercontent.com/immich-app/immich/main/install.sh | sudo bash

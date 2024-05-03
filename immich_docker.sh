#!/bin/bash

# Funzione per l'installazione su Debian
install_debian() {
    read -p "Premi enter per aggiungere i repository Docker e installare l'ultima versione di Immich!"
    sudo apt update && sudo apt upgrade -y
    sudo apt install -y avahi-daemon
    sudo apt install -y apt-transport-https ca-certificates curl gnupg2 software-properties-common
    curl -fsSL https://download.docker.com/linux/$(. /etc/os-release; echo "$ID")/gpg | sudo apt-key add -
    sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/$(. /etc/os-release; echo "$ID") $(lsb_release -cs) stable"
    sudo apt update
    sudo apt install -y docker-ce docker-compose
}

# Funzione per l'installazione su Fedora
install_fedora() {
    read -p "Premi enter per aggiungere i repository Docker e installare l'ultima versione di Immich!"
    sudo dnf upgrade -y
    sudo dnf install -y avahi
    sudo dnf install -y dnf-plugins-core
    sudo dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo
    sudo dnf install -y docker-ce docker-ce-cli containerd.io
    sudo systemctl start docker
    sudo systemctl enable docker
    sudo dnf install -y docker-compose
}

# Controlla la distribuzione

if [ -f /etc/os-release ]; then
    . /etc/os-release
    if [ "$ID" = "debian" ] || [ "$ID_LIKE" = "debian" ] || [ "$ID" = "linuxmint" ] || [ "$ID" = "ubuntu" ]; then
        # Esegui l'installazione per le distribuzioni basate su .deb
        sudo apt install -y curl
        install_debian
    elif [ "$ID" = "fedora" ] || [ "$ID_LIKE" = "fedora" ] || [ "$ID" = "rocky" ] || [ "$ID" = "oracle" ]; then
        # Esegui l'installazione per le distribuzioni basate su RPM
        if ! command -v docker &> /dev/null; then
            echo "Docker non è stato installato, installando curl..."
            sudo dnf install -y curl
        fi
        install_fedora
    else
        echo "La distribuzione non è supportata o riconosciuta."
        exit 1
    fi
else
    echo "Impossibile determinare la distribuzione."
    exit 1
fi

# Installa Immich
sudo curl -o- https://raw.githubusercontent.com/immich-app/immich/main/install.sh | sudo bash

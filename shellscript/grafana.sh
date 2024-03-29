#!/bin/bash

# Checking if the system is CentOS or Ubuntu
if [ -f /etc/redhat-release ]; then
    # CentOS
    echo "Installing Grafana on CentOS..."

    # Install required packages for yum
    sudo yum install -y wget

    # Creating a directory for the yum repo.
    sudo mkdir -p /etc/yum.repos.d/

    # Download and add Grafana YUM repository
    sudo wget https://packages.grafana.com/gpg.key -O /etc/pki/rpm-gpg/RPM-GPG-KEY-Grafana
    sudo rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-Grafana
    echo "[grafana]
    name=grafana
    baseurl=https://packages.grafana.com/oss/rpm
    enabled=1
    gpgcheck=1
    gpgkey=https://packages.grafana.com/gpg.key" | sudo tee /etc/yum.repos.d/grafana.repo

    # Install Grafana
    sudo yum install -y grafana
elif [ -f /etc/lsb-release ]; then
    # Ubuntu
    echo "Installing Grafana on Ubuntu..."

    # Install required packages
    sudo apt-get update
    sudo apt-get install -y apt-transport-https software-properties-common wget

    # Create directory for apt keyrings
    sudo mkdir -p /etc/apt/keyrings/

    # Download and add Grafana GPG key
    wget -q -O - https://apt.grafana.com/gpg.key | gpg --dearmor | sudo tee /etc/apt/keyrings/grafana.gpg > /dev/null

    # Add Grafana repository to sources list
    echo "deb [signed-by=/etc/apt/keyrings/grafana.gpg] https://packages.grafana.com stable main" | sudo tee -a /etc/apt/sources.list.d/grafana.list
    echo "deb [signed-by=/etc/apt/keyrings/grafana.gpg] https://packages.grafana.com beta main" | sudo tee -a /etc/apt/sources.list.d/grafana.list

    # Update package lists
    sudo apt-get update

    # Install Grafana
    sudo apt-get install -y grafana
else
    echo "Unsupported operating system"
    exit 1
fi

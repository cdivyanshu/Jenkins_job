#!/bin/bash

# Download Grafana CLI binary
wget https://dl.grafana.com/oss/release/grafana-cli-<version>-linux-amd64.tar.gz

# Extract the downloaded archive
tar -xzvf grafana-cli-<version>-linux-amd64.tar.gz

# Move the Grafana CLI binary to a directory in your PATH
sudo mv grafana-cli-<version>-linux-amd64/grafana-cli /usr/local/bin/

# Clean up: Remove the downloaded archive and extracted directory
rm grafana-cli-<version>-linux-amd64.tar.gz
rm -rf grafana-cli-<version>-linux-amd64


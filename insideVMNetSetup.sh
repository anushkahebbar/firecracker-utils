#!/bin/bash

# Set up interface at 172.16.0.2 inside the microVM
ip link set eth0 up
ip addr add 172.16.0.2/24 dev eth0

# All network requests routed through the gateway 
# Next hop router's IP address
ip route add default via 172.20.0.1 dev eth0


# Create necessary directories for systemctl and apt
mkdir -p /var/tmp && chmod /var/tmp
mkdir -p /var/lib/dpkg/{alternatives,info,parts,triggers,updates}
cd /var/lib/dpkg && touch status arch available cmethopt statoverride status-old diversions
cd


# Set up DNS 
echo "nameserver 8.8.8.8" > /etc/resolv.conf
systemctl restart systemd-resolved.service
systemctl status systemd-resolved.service

# Install the sysbench application
apt-get update
apt-get install curl
apt-get install iputils-ping
curl -s https://packagecloud.io/install/repositories/akopytov/sysbench/script.deb.sh | bash
apt -y install sysbench
sysbench

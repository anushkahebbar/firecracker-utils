#!/bin/bash
# Bash script to set up bridge & tap interfaces and the iptables in the host machine

# Remove any existing bridge and tap interfaces
sudo ip link delete br0
sudo ip link delete tap0
ifconfig

# Create a bridge interface at 172.20.0.1
sudo ip link add name br0 type bridge
sudo ip addr add 172.20.0.1/24 dev br0
sudo ip link set dev br0 up

# Remove all existing rules in the iptables
sudo iptables --flush			# Flush contents of the filter table
sudo iptables -t nat -F			# Flush contents of the NAT table
sudo iptables -t mangle -F		# Flush contents of the mangle table
sudo iptables -F				# Flush all contents
sudo iptables -X				# Delete chains

# sysctl - used to modify kernel parameters at runtime. Params: listed under /proc/sys/

# Enable IP forwarding for IPv4
sudo sysctl -w net.ipv4.ip_forward=1


# All address leaving translated to the interface for internet
sudo iptables --table nat --append POSTROUTING --out-interface eno1 -j MASQUERADE

# Accept network through the bridge interface
sudo iptables --insert FORWARD --in-interface br0 -j ACCEPT

# View the current set of rules
sudo iptables -L

# Create a tap interface 
sudo ip tuntap add dev tap0 mode tap
sudo brctl addif br0 tap0
sudo ifconfig tap0 up

# Rules in iptables are not persistent over system reboots - save contents
sudo iptables-save > iptables.rules.old

ifconfig




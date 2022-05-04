#!/bin/bash

# Bash script to run the microVM Manager process 

# Remove existing API endpoint socket 
rm -f /tmp/firecracker.socket

# Exposes an API endpoint to the host once started
# Saves the socket in /tmp
./firecracker --api-sock /tmp/firecracker.socket

# The API endpoint is used to configure the microVM
# 	set the # of vCPUs, memory size, CPU template
#	add one/more network interfaces 
# 	add one/more rw/r disks - each represented by a file-backed block device
# 	start the microVM using a given kernel image, root fs and boot args
#	stop the microVM


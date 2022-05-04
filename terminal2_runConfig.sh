#!/bin/bash

# Bash script to control Firecracker microVM configuration that writes to the API socket
if [ "$1" == "--new" ]; then
	if [ "$2" == "-n" ]; then
		Name=$3
		echo "Newly created $Name."
	else
		Name="default"
	fi
	bash /home/kvs_firecracker/firecracker/bashScripts/1_get_kernel_rootfs.sh -n $Name
else
	if [ "$1" == "-n" ]; then
		Name=$2
		echo "Using existing $Name."
	else
		Name="default"
		echo "Using default kernel and root fs."
	fi
fi

bash /home/kvs_firecracker/firecracker/bashScripts/2_set_guest_kernel.sh -n $Name
bash /home/kvs_firecracker/firecracker/bashScripts/3_set_guest_rootfs.sh -n $Name
bash /home/kvs_firecracker/firecracker/bashScripts/4_setup_net.sh
bash /home/kvs_firecracker/firecracker/bashScripts/5_setup_memcpu.sh
bash /home/kvs_firecracker/firecracker/bashScripts/6_start_guest_machine.sh

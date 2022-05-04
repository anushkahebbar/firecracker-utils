#!bin/bash 

# Get an uncompressed Linux kernel binary to use as the guest kernel and 
# An ext4 file system (fourth extended filesystem) image to use as the root filesystem

# Get the architecture of the system
arch=`uname -m`

image_bucket_url="https://s3.amazonaws.com/spec.ccfc.min/img/quickstart_guide/$arch"

echo "Using $2 in getting the guest kernel and rootfs."

dest_kernel="resources/$2-vmlinux.bin"
dest_rootfs="resources/$2-rootfs.ext4"

if [ ${arch}="x86_64" ]; then
    kernel="${image_bucket_url}/kernels/vmlinux.bin"
    rootfs="${image_bucket_url}/rootfs/bionic.rootfs.ext4"

elif [ ${arch}="aarch64" ]; then
    kernel="${image_bucket_url}/kernels/vmlinux.bin"
    rootfs="${image_bucket_url}/rootfs/bionic.rootfs.ext4"
else
    echo "Cannot run firecracker on $arch architecture!"
    exit 1
fi

echo "Downloading the guest kernel: $kernel..."
curl -fsSL -o $dest_kernel $kernel

echo "Downloading the root filesystem: $rootfs..."
curl -fsSL -o $dest_rootfs $rootfs

echo "Saved the kernel file to $dest_kernel and root block."

#!/bin/bash
# Creates a container using an Ubuntu Cloud ISO and then
# imports into Docker. This will provide an image that
# is nearly identical to an Amazon (or Rackspace) Ubuntu AMI.

DOCKER_USER=mopemope
UBUNTU_RELEASE=trusty
CONTAINER_NAME=drone
CONTAINER_DIR=/var/lib/lxc/$CONTAINER_NAME/rootfs

# make sure container and image don't already exist
set +e
lxc-stop -n $CONTAINER_NAME
lxc-destroy -n $CONTAINER_NAME
docker rmi $DOCKER_USER/$CONTAINER_NAME
set -e

# create the default LXC container (takes ~10 minutes)
lxc-create -n $CONTAINER_NAME -t ubuntu -- -r $UBUNTU_RELEASE

# upstart workaround for docker
# see https://github.com/dotcloud/docker/issues/1024
chroot $CONTAINER_DIR dpkg-divert --local --rename --add /sbin/initctl
chroot $CONTAINER_DIR ln -s /bin/true /sbin/initctl

# override configurations
#chroot $CONTAINER_DIR mkdir -p /home/ubuntu/.ssh
#chroot $CONTAINER_DIR mkdir -p /root/.ssh
#cat rootfs/etc/bash.bashrc > $CONTAINER_DIR/etc/bash.bashrc
#cat rootfs/etc/sudoers > $CONTAINER_DIR/etc/sudoers
#cat rootfs/etc/init.d/xvfb > $CONTAINER_DIR/etc/init.d/xvfb
#cat rootfs/etc/apt/apt.conf.d/90forceyes > $CONTAINER_DIR/etc/apt/apt.conf.d/90forceyes
#cat rootfs/root/.gitconfig > $CONTAINER_DIR/root/.gitconfig
#cat rootfs/root/.ssh/config > $CONTAINER_DIR/root/.ssh/config
#cat rootfs/home/ubuntu/.gitconfig > $CONTAINER_DIR/home/ubuntu/.gitconfig
#cat rootfs/home/ubuntu/.ssh/config > $CONTAINER_DIR/home/ubuntu/.ssh/config
#chroot $CONTAINER_DIR chown -R ubuntu:ubuntu /home/ubuntu

# backup the symlinked resolv.conf
# and override default resolve.conf
#mv $CONTAINER_DIR/etc/resolv.conf $CONTAINER_DIR/etc/resolv.conf.bak
#cat rootfs/etc/resolv.conf > $CONTAINER_DIR/etc/resolv.conf

# install essential command binaries (scm, xserver)
chroot $CONTAINER_DIR apt-get -y update
chroot $CONTAINER_DIR apt-get -y --no-install-recommends install git git-core subversion mercurial bzr fossil xvfb socat vim build-essential

# remove resolv.conf and restore backup
#chroot $CONTAINER_DIR rm /etc/resolv.conf
#mv $CONTAINER_DIR/etc/resolv.conf.bak $CONTAINER_DIR/etc/resolv.conf

# tar the container
tar -czf $CONTAINER_NAME.tar -C $CONTAINER_DIR .

# import the container into docker
cat $CONTAINER_NAME.tar | docker import - $DOCKER_USER/$CONTAINER_NAME

# cleanup after ourselves ...
# destroy the container
# delete the tar file
rm $CONTAINER_NAME.tar
lxc-destroy -n $CONTAINER_NAME

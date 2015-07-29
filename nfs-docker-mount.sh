#!/bin/bash
 
#
# This script will mount /Users in the docker-machine VM using NFS (instead of the
# default vboxsf). It's probably not a good idea to run it while there are
# Docker containers running in docker-machine.
#
# Usage: sudo ./docker-machine-use-nfs.sh
#
 
if [ "$USER" != "root" ]
then
  echo "This script must be run with sudo: sudo ${0}"
  exit -1
fi
 
# Run command as non root http://stackoverflow.com/a/10220200/96855
B2D_IP=$(sudo -u ${SUDO_USER} docker-machine ip dev &> /dev/null)
 
if [ "$?" != "0" ]
then
  sudo -u ${SUDO_USER} docker-machine up
  $(sudo -u ${SUDO_USER} docker-machine shellinit)
  B2D_IP=$(sudo -u ${SUDO_USER} docker-machine ip &> /dev/null)
  #echo "You need to start docker-machine first: docker-machine up && \$(docker-machine shellinit) "
  #exit -1
fi
 
OSX_IP=$(ifconfig en0 | grep --word-regexp inet | awk '{print $2}')
MAP_USER=${SUDO_USER}
MAP_GROUP=$(sudo -u ${SUDO_USER} id -n -g)
 
# Backup exports file
$(cp -n /etc/exports /etc/exports.bak) && \
  echo "Backed up /etc/exports to /etc/exports.bak"
 
# Delete previously generated line if it exists
grep -v '^/Users ' /etc/exports > /etc/exports
 
# We are using the OS X IP because the b2d VM is behind NAT
echo "/Users -mapall=${MAP_USER}:${MAP_GROUP} ${OSX_IP}" \
  >> /etc/exports
 
# https://gist.github.com/sirkkalap/40261ed82386ad8a6409
# This option controls whether MOUNT requests are required to originate from a reserved port
# (port < 1024).  The default value is 1 (yes).  Many NFS server implementations require this
# because of the false belief that this requirement increases security.
echo "nfs.server.mount.require_resv_port = 0" >> /etc/nfs.conf
 
nfsd restart
 
sudo -u ${SUDO_USER} docker-machine ssh dev << EOF
  echo "Unmounting /Users"
  sudo umount /Users 2> /dev/null
  echo "Restarting nfs-client"
  sudo /usr/local/etc/init.d/nfs-client restart 2> /dev/null
  echo "Waiting 10s for nfsd and nfs-client to restart."
  sleep 10
  echo "Mounting /Users"
  sudo mount $OSX_IP:/Users /Users -o rw,async,noatime,rsize=32768,wsize=32768,proto=tcp,nfsvers=3
  echo "Mounted /Users:"
  ls -al /Users
  exit
EOF

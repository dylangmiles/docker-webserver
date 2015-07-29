#!/bin/sh

#docker-machine ssh dev 'sudo umount /Users'
docker-machine ssh dev 'sudo mount -t vboxsf -o "defaults,uid=33,gid=33,rw" Users /Users'


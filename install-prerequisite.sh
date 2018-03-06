#!/bin/bash
#
# Use on ECS to initialize the envrionment.


# No need to install docker
# sudo yum remove docker \
#                 docker-client \
#                 docker-client-latest \
#                 docker-common \
#                 docker-latest \
#                 docker-latest-logrotate \
#                 docker-logrotate \
#                 docker-selinux \
#                 docker-engine-selinux \
#                 docker-engine

# sudo yum install -y yum-utils \
#       device-mapper-persistent-data \
#       lvm2
# sudo yum-config-manager \
#     --add-repo \
#     https://download.docker.com/linux/centos/docker-ce.repo

# sudo yum-config-manager --disable docker-ce-edge


set -e
CURRENT=pwd
fcn=$1

# install some toolkit
yum install git lsof jq tree curl -y

function cn() {
	if [ ! -f "$CURRENT/common/install.sh" ]; then
		gitSync
	fi
	$CURRENT/common/install.sh cn
	sudo apt -qq install -y moreutils
	npm install
}

if [ -n "$fcn" ]; then
	$fcn
else
	$CURRENT/common/install.sh
	# write to config: jq do not support in-place editing, use moreutils:sponge
	yum -qq install -y moreutils
	if ! go version; then
		$CURRENT/common/install.sh golang
	fi
fi
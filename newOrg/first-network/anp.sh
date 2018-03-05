#!/bin/bash
#

function printHelp () {
    echo "This script is used for spawning new peer"
}


export IMAGE_TAG=x86_64-1.1.0-rc1
# set default image tag

while getopts "h?m:c:t:d:f:s:l:i:" opt; do
  case "$opt" in
    h|\?)
      printHelp
      exit 0
    i)  IMAGETAG=`uname -m`"-"$OPTARG
    ;;
  esac
done


echo "=====> Spawning new peer using $IMAGE_TAG"
IMAGE_TAG=$IMAGETAG docker-compose -f docker-compose-new-peer.yaml up -d

echo "===> checking whether the peer has been launched"
docker ps 

echo "===> Joinning mychannel"
docker exec -it cli ./script/new-peer-org2.sh

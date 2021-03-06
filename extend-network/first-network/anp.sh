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
    ;;
    i)  IMAGE_TAG=`uname -m`"-"$OPTARG
    ;;
  esac
done

echo "=====> generate config file. Make sure you cleaned up the peers/peer2.org2..."
cryptogen extend --config=./crypto-config-new-peer.yaml


echo "=====> Spawning new peer using $IMAGE_TAG"
IMAGE_TAG=$IMAGE_TAG docker-compose -f docker-compose-new-peer.yaml up -d
# IMAGE_TAG=x86_64-1.1.0-rc1 docker-compose -f docker-compose-new-peer.yaml up -d

echo "===> checking whether the peer has been launched"
docker ps 

echo "==> chmod those script incase get permission denied"
chmod +x ./scripts/new-peer-1.sh
chmod +x ./scripts/new-peer-2.sh
chmod +x ./scripts/new-peer-3.sh

echo "===> Joinning mychannel"
docker exec -it cli ./scripts/new-peer-1.sh

echo "===> Installing chaincode"
docker exec -it cli ./scripts/new-peer-2.sh
# peer chaincode install -n mycc -v 2.0 -l golang -p github.com/chaincode/chaincode_example02/go/
# peer chaincode upgrade -o orderer.example.com:7050 --tls true --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem -C mychannel -n mycc -v 2.0 -c '{"Args":["init","a","90","b","210"]}' -P 'OR ('\''Org1MSP.peer'\'','\''Org2MSP.peer'\'')'

sleep 3

echo "===> Instantiating chaincode needs run manually"
docker exec -it cli ./scripts/new-peer-3.sh

echo "===> If no error, show chaincode result below."
docker logs dev-peer2.org2.example.com-mycc-3.0
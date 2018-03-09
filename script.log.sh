# Do not run this script
#
# 
#
# This script is used for log


#
#
# test the e2e
cd $GOPATH/src/github.com/hyperledger/
git clone https://github.com/hyperledger/fabric-samples.git
cd $GOPATH/src/github.com/hyperledger/fabric-samples/first-network
git checkout v1.0.6
bash byfn.sh -m up -i 1.0.6
bash byfn.sh -m down



# install docker compose
# Run this command to download the latest version of Docker Compose:
sudo curl -L https://github.com/docker/compose/releases/download/1.19.0/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
# Apply executable permissions to the binary:
sudo chmod +x /usr/local/bin/docker-compose
# Test
docker-compose --version


#
#
#
# 
cd $GOPATH/src/github.com/hyperledger/fabric-test/fabric/examples/e2e_cli/
git checkout v1.0.6
./generateArtifacts.sh mychannel

# send docker-compsoe to machine 
scp -r e2e_cli root@172.16.50.151:/opt/go/src/github.com/hyperledger/fabric-test/fabric/examples
scp -rf e2e_cli root@172.16.50.152:/opt/go/src/github.com/hyperledger/fabric-test/fabric/examples
scp -r e2e_cli root@172.16.50.153:/opt/go/src/github.com/hyperledger/fabric-test/fabric/examples



# stop network 
docker rm -f $(docker ps -a | grep hyperledger)

# start network
docker-compose -f docker-compose-orderer.yaml up -d
docker-compose -f docker-compose-peer-2.yaml up -d
docker-compose -f docker-compose-peer-1.yaml up -d
#!/bin/bash
#
#
# Use to install prerequisite

nvm install 6.10.0
nvm alias default 6.10.0
node --version
npm install -g node-gyp --registry=https://registry.npm.taobao.org
npm install -g gulp --registry=https://registry.npm.taobao.org
npm install -g cnpm --registry=https://registry.npm.taobao.org
yum install -y build-essential python libltdl-dev
# install build essential
yum install gcc-c++ make -y
rm -rf $HOME/.node-gyp
source ~/.profile

go get -d -v github.com/hyperledger/fabric-test
cd $GOPATH/src/github.com/hyperledger/fabric-test

# if Run this scripts first time
git submodule update --init --recursive
git submodule foreach git pull origin master
# else 
# git submodule foreach git pull origin master


# bootstraps-v1.0.6
echo "if v1.0.6 is not ready. You should run bootstraps-v1.0.6.sh after."

# install PTE
cd $GOPATH/src/github.com/hyperledger/fabric-test/tools/PTE
npm install fabric-client@1.0.2
npm install fabric-ca-client@1.0.2

# use fabric v1.0.6
echo "use fabric v1.0.6..."
cd $GOPATH/src/github.com/hyperledger/fabric-test/fabric/
git pull
git checkout v1.0.6

# use fabric-ca v1.0.6
echo "use fabric-ca v1.0.6..."
cd $GOPATH/src/github.com/hyperledger/fabric-test/fabric/
git pull
git checkout v1.0.6

# use fabric-sdk-node v1.0.4
echo "use fabric-sdk-node v1.0.4..."
cd $GOPATH/src/github.com/hyperledger/fabric-test/fabric-sdk-node/
git pull
git checkout v1.0.4
npm install --registry=https://registry.npm.taobao.org
gulp ca


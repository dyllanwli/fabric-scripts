#!/bin/bash
peer chaincode install -n mycc -v 2.0 -l golang -p github.com/chaincode/chaincode_example02/go/
peer chaincode upgrade -o orderer.example.com:7050 --tls true --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem -C mychannel -n mycc -v 2.0 -c '{"Args":["init","a","90","b","210"]}' -P 'OR ('\''Org1MSP.peer'\'','\''Org2MSP.peer'\'')'

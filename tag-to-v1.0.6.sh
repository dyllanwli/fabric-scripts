#!/bin/bash
#
# This scripts use to tag all fabric images to latest
for IMAGES in couchdb kafka zookeeper peer orderer ccenv javaenv tools; do
    echo "==> TAGGING DOCKER IMAGE: $IMAGES"
    echo
    docker tag hyperledger/fabric-$IMAGES:x86_64-1.0.6 hyperledger/fabric-$IMAGES:latest
done

echo "DONE."
docker images | grep hyperledger*
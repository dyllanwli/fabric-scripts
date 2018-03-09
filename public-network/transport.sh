#!/bin/bash
# transport to another machine



while getopts "p:" opt; do
  case "$opt" in
    p)  IP=$OPTARG
    ;;
  esac
done

cd ./first-network
bash ./byfn.sh -m generate -i 1.0.6
scp -r first-network root@${IP}:~/diya/fabric-scripts/public-network
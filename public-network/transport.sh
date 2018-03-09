#!/bin/bash
# transport to another machine

# Print the usage message
function printHelp () {
  echo "Usage: Please input -p"
}

while getopts "h?m:p:" opt; do
  case "$opt" in
    h|\?)
      printHelp
      exit 0
    ;;
    p)  IP=$OPTARG
    ;;
  esac
done

cd ./first-network
bash ./byfn.sh -m generate -i 1.0.6
scp -r first-network root@${IP}:~/diya/fabric-scripts/public-network
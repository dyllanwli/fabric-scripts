## Usage 

docker swarm init --advertise-addr [ip]

docker swarm join-token manager

docker network create --attachable -d overlay --subnet=10.200.1.0/24 hyperledger-ov

./genConfig -domain example.com -orderer 3 -org 2 -peer 2

./generateArtifacts.sh -c testorgschannel1 -o 2
docker stack deploy -c docker-compose-zookeeper.yaml hyperledger-zk
docker stack deploy -c docker-compose-kafka.yaml hyperledger-kafka
docker stack deploy -c docker-compose-orderer.yaml hyperledger-orderer
docker stack deploy -c docker-compose-couchdb.yaml hyperledger-couchdb
docker stack deploy -c docker-compose-peer.yaml hyperledger-peer
docker stack deploy -c docker-compose-ca.yaml hyperledger-ca
docker stack deploy -c docker-compose-cli.yaml hyperledger-cli

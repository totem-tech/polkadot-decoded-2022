> This document is no longer up-to-date. Refer to [ReadMe.md](./ReadMe.md)

```shell
# Polkadot Local Network Validator and Bootnode Node 1
## In the case of the Polkadot Rococo Local network, the network authorities and the bootnodes are predefined as `alice` and `bob`.
## In other circumstances the Network Boot nodes are identified by a NODEKEY and the validators are identified by the KEYSTORE key.
docker run \
--rm \
# once it is running use this so that the output is not shown
#-dit \
-it \
-p 30433:30333 \
-p 10033:9933 \
-p 10044:9944 \
-p 9715:9615 \
--name rococo-local-auth1 \
--pull=always \
-v="/$(pwd)/rococo-local-auth1:/data" \
parity/polkadot:latest \
# this file needs to be in the same directory as the chain data so that the -v will point to it?
--chain /data/genesis-file/rococo-local-totem.json \
--alice \
--name "rococo-local-auth1"


# Polkadot Local Network Validator Node 1
## In the case of the Polkadot Rococo Local network, the network authorities and the bootnodes are predefined as `alice` and `bob`.
## In other circumstances the Network Boot nodes are identified by a NODEKEY and the validators are identified by the KEYSTORE key.
docker run \
--rm \
# once it is running use this so that the output is not shown
#-dit \
-it \
-p 30434:30333 \
-p 10034:9933 \
-p 10045:9944 \
-p 9716:9615 \
--name rococo-local-auth2 \
--pull=always \
-v="/$(pwd)/rococo-local-auth2:/data" \
parity/polkadot:latest \
# this file needs to be in the same directory as the chain data so that the -v will point to it?
--chain /data/genesis-file/rococo-local-totem.json \
--bob \
--name "rococo-local-auth2"

#Polkadot Local Network UI Node 1 (used to be a websocket endpoint)
## UI nodes do not need to worry about their network identities these are ephemeral and generated on the fly
docker run \
--rm \
# once it is running use this so that the output is not shown
#-dit \
-it \
-p 30435:30333 \
-p 10035:9933 \
-p 127.0.0.1:10046:9944 \
-p 9717:9615 \
--name rococo-local-ui1 \
--pull=always \
-v="/$(pwd)/rococo-local-ui1:/data" \
parity/polkadot:latest \
# this file needs to be in the same directory as the chain data so that the -v will point to it?
--chain /data/genesis-file/rococo-local-totem.json \
--ws-external \
--name "rococo-local-ui1"

# Parachain Boot Node 1
# Identity seen in output: 12D3KooWBsMTJeHCa9Mgq4qQECkfxJ6P9WyajEFF8gEzSaC9npVm
# This relies upon the NODEKEY
docker run \
--rm \
# once it is running use this so that the output is not shown
#-dit \
-it \
-p 40433:40333 \
-p 30436:30333 \
-p 30534:30334 \
-p 10036:9933 \
-p 10134:9934 \
-p 10047:9944 \
-p 10051:9945 \
-p 9718:9615 \
-p 9816:9616 \
--name demo-boot-node-1 \
--pull=always \
-v="/$(pwd)/demo-boot-node-1:/data" \
totemlive/totem-parachain-collator:latest \
totem-parachain-collator \
--port 30333 \
--name "demo-boot-node-1" \
# This should be in a directory on the volume
--node-key-file /keystore/node-key/nodekey-demo-boot1 \
--node-key-type 'ed25519' \
-- \
# this file needs to be in the same directory as the chain data so that the -v will point to it?
--chain /data/genesis-file/rococo-local-totem.json \
--port 40333

# Parachain Collator/Validator Node 1
# This authority relies upon the KEYSTORE key
docker run \
--rm \
# once it is running use this so that the output is not shown
#-dit \
-it \
-p 40434:40333 \
-p 30437:30333 \
-p 30535:30334 \
-p 10037:9933 \
-p 10135:9934 \
-p 10048:9944 \
-p 10052:9945 \
-p 9719:9615 \
-p 9817:9616 \
--name demo-collator-node-1 \
--pull=always \
-v="/$(pwd)/demo-collator-node-1:/data" \
totemlive/totem-parachain-collator:latest \
totem-parachain-collator \
--port 30333 \
--name "demo-collator-node-1" \
--collator \
# this should also be in the volume directory
--keystore-path /keystore/auth-key/keystore-demo-auth1 \
--force-authoring \ 
-- \
# this file needs to be in the same directory as the chain data so that the -v will point to it?
--chain /data/genesis-file/rococo-local-totem.json \
--port 40333

# Parachain Collator/Validator Node 2
# This authority relies upon the KEYSTORE key
docker run \
--rm \
# once it is running use this so that the output is not shown
#-dit \
-it \
-p 40435:40333 \
-p 30438:30333 \
-p 30536:30334 \
-p 10038:9933 \
-p 10136:9934 \
-p 10049:9944 \
-p 10145:9945 \
-p 9720:9615 \
-p 9818:9616 \
--name demo-collator-node-2 \
--pull=always \
-v="/$(pwd)/demo-collator-node-2:/data" \
totemlive/totem-parachain-collator:latest \
totem-parachain-collator \
--port 30333 \
--name "demo-collator-node-2" \
--collator \
# this should also be in the volume directory
--keystore-path /keystore/auth-key/keystore-demo-auth2 \
--force-authoring \ 
-- \
# this file needs to be in the same directory as the chain data so that the -v will point to it?
--chain /data/genesis-file/rococo-local-totem.json \
--port 40333

# Parachain UI Node (full node running as an endpoint)
## UI nodes do not need to worry about their network identities these are ephemeral and generated on the fly
docker run \
--rm \
# once it is running use this so that the output is not shown
#-dit \
-it \
-p 40436:40333 \
-p 30439:30333 \
-p 30537:30334 \
-p 10039:9933 \
-p 10137:9934 \
-p 127.0.0.1:10050:9944 \
-p 10146:9945 \
-p 9721:9615 \
-p 9819:9616 \
--name demo-ui-node-1 \
--pull=always \
-v="/$(pwd)/demo-ui-node-1:/data" \
totemlive/totem-parachain-collator:latest \
totem-parachain-collator \
--port 30333 \
--ws-external \
--name "demo-ui-node-1" \
-- \
# this file needs to be in the same directory as the chain data so that the -v will point to it?
--chain /data/genesis-file/rococo-local-totem.json \
--port 40333
```

## Setting up nginx 

There are three separate files in this repo with the config for nginx.

You should enable nginx streaming connections for validators.
#!/usr/bin/env bash

docker run \
-it \
-p 127.0.0.1:40433:40333 \
-p 127.0.0.1:30436:30333 \
-p 127.0.0.1:9718:9615 \
--rm \
--name para-boot-node-1 \
--pull=always \
-v="/$(pwd)/para-boot-node-1:/data" \
totemlive/generic-parachain-collator:latest \
generic-parachain-collator \
--state-cache-size=1 \
--chain para \
--execution=wasm \
--name "para-boot-node-1" \
--node-key-file /data/keystore/node-key/nodekey-para-boot-ip \
--node-key-type 'ed25519' \
--public-addr /ip4/159.89.1.153/tcp/31436 \
--port 30333 \
-- \
--chain /data/genesis-file/rococo-local-totem.json \
--execution=wasm \
--public-addr /ip4/159.89.1.153/tcp/41433 \
--port 40333

# This script is currently for testing. If we have the possibility to use the fqdn then we use the following: 
# --node-key-file /data/keystore/node-key/nodekey-para-boot1 \

# Using the above will generate the libp2p identity used in the genesis file.
# For simplicity we use the same port as we will either run one or the other but probably not both. 
# /dns4/l-boot-1.kapex.network/tcp/31436/ws/p2p/12D3KooWNpTmqisnMwdAUtjRHCxdb6EQcymdwQvdQFNuFfgBX1K3

# Ports
# Mapped Docker Ports : Standard Ports : NGINX Ports
# 40433	40333	41433
# 30436	30333	31436
# 30534	30334	n/a
# 10036	9933	n/a
# 10134	9934	n/a
# 10247	9944	n/a
# 10345	9945	n/a
# 9718	9615	19718
# 9816	9616	n/a

# --wasm-execution compiled \
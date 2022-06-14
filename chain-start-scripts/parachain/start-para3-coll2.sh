#!/usr/bin/env bash

docker run \
-it \
-p 127.0.0.1:40435:40333 \
-p 127.0.0.1:30438:30333 \
-p 127.0.0.1:9720:9615 \
--rm \
--name para-collator-node-2 \
--pull=always \
-v="/$(pwd)/para-collator-node-2:/data" \
totemlive/generic-parachain-collator:latest \
generic-parachain-collator \
--state-cache-size=1 \
--chain para \
--name "para-collator-node-2" \
--collator \
--execution=wasm \
--keystore-path /data/keystore/auth-key \
--node-key-file /data/keystore/node-key/nodekey-para-auth2 \
--node-key-type 'ed25519' \
--public-addr /ip4/159.89.1.153/tcp/31438 \
--port 30333 \
-- \
--chain /data/genesis-file/rococo-local-totem.json \
--execution=wasm \
--public-addr /ip4/159.89.1.153/tcp/41435 \
--port 40333

# --force-authoring \
# --wasm-execution compiled \
# --rpc-methods=Unsafe \
# --ws-port 9944 \
# -p 10049:9944 \

# --rpc-methods=Unsafe \
# --ws-port 9945 \
# -p 10145:9945 \

# Ports
# Mapped Docker Ports : Standard Ports : NGINX Ports
# 40435	40333	41435
# 30438	30333	31438
# 30536	30334	n/a
# 10038	9933	n/a
# 10136	9934	n/a
# 10249	9944	n/a
# 10347	9945	n/a
# 9720	9615	19720
# 9818	9616	n/a
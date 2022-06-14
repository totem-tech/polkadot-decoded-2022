#!/usr/bin/env bash

docker run \
-it \
-p 127.0.0.1:40434:40333 \
-p 127.0.0.1:30437:30333 \
-p 127.0.0.1:9719:9615 \
--rm \
--name para-collator-node-1 \
--pull=always \
-v="/$(pwd)/para-collator-node-1:/data" \
totemlive/generic-parachain-collator:latest \
generic-parachain-collator \
--state-cache-size=1 \
--chain para \
--name "para-collator-node-1" \
--collator \
--execution=wasm \
--keystore-path /data/keystore/auth-key \
--node-key-file /data/keystore/node-key/nodekey-para-auth1 \
--node-key-type 'ed25519' \
--public-addr /ip4/159.89.1.153/tcp/31437 \
--port 30333 \
-- \
--chain /data/genesis-file/rococo-local-totem.json \
--execution=wasm \
--public-addr /ip4/159.89.1.153/tcp/41434 \
--port 40333

# --force-authoring \
# --wasm-execution compiled \
# --rpc-methods=Unsafe \
# -p 127.0.0.1:10248:9944
# --ws-port 9944 \
# --rpc-methods=Unsafe \
# -p 127.0.0.1:10346:9945
# --ws-port 9945 \

# Ports
# Mapped Docker Ports : Standard Ports : NGINX Ports
# 40434	40333	41434
# 30437	30333	31437
# 30535	30334	n/a
# 10037	9933	n/a
# 10135	9934	n/a
# 10248	9944	n/a
# 10346	9945	n/a
# 9719	9615	19719
# 9817	9616	n/a
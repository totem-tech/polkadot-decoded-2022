#!/usr/bin/env bash

docker run \
-it \
-p 127.0.0.1:30435:30333 \
-p 127.0.0.1:10246:9944 \
--rm \
--name rococo-local-ui1 \
--pull=always \
-v="/$(pwd)/rococo-local-ui1:/data" \
parity/polkadot:v0.9.16 \
--chain /data/genesis-file/rococo-local-totem.json \
--execution=wasm \
--ws-external \
--name "rococo-local-ui1" \
--public-addr /ip4/159.89.1.153/tcp/31435 \
--port 30333

# -p 10035:9933 \
# -p 9717:9615 \

# Ports
# Mapped Docker Ports : Standard Ports : NGINX Ports
# 30435	30333	31435
# 10035	9933	n/a
# 10246	9944	11111
# 9717	9615	19717
#!/usr/bin/env bash

docker run \
-it \
-p 127.0.0.1:30433:30333 \
-p 127.0.0.1:10244:9944 \
--rm \
--name rococo-local-auth1 \
--pull=always \
-v="/$(pwd)/rococo-local-auth1:/data" \
parity/polkadot:v0.9.16 \
--alice \
--validator \
--pruning=archive \
--chain /data/genesis-file/rococo-local-totem.json \
--execution=wasm \
--name "rococo-local-auth1" \
--public-addr /ip4/159.89.1.153/tcp/31433 \
--ws-port 9944 \
--port 30333

# --wasm-execution compiled \

# parity/polkadot:latest \
# --chain polkadot \
# --chain kusama \

# Ports
# Mapped Docker Ports : Standard Ports : NGINX Ports
# 30433	30333	31433
# 10033	9933	n/a
# 10244	9944	11244
# 9715	9615	19715
#!/usr/bin/env bash

docker run \
-it \
-p 127.0.0.1:30434:30333 \
-p 127.0.0.1:10245:9944 \
--rm \
--name rococo-local-auth2 \
--pull=always \
-v="/$(pwd)/rococo-local-auth2:/data" \
parity/polkadot:v0.9.16 \
--bob \
--validator \
--pruning=archive \
--chain /data/genesis-file/rococo-local-totem.json \
--execution=wasm \
--name "rococo-local-auth2" \
--public-addr /ip4/159.89.1.153/tcp/31434 \
--ws-port 9944 \
--port 30333

# -p 127.0.0.1:10034:9933 \
# -p 127.0.0.1:9716:9615 \

# parity/polkadot:latest \
# --chain polkadot \
# --chain kusama \

# Ports
# Mapped Docker Ports : Standard Ports : NGINX Ports
# 30434	30333	31434
# 10034	9933	n/a
# 10245	9944	11245
# 9716	9615	19716
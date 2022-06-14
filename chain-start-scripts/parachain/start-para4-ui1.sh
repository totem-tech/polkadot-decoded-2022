#!/usr/bin/env bash

docker run \
-it \
-p 127.0.0.1:40436:40333 \
-p 127.0.0.1:30439:30333 \
-p 127.0.0.1:10250:9944 \
-p 127.0.0.1:9721:9615 \
--rm \
--name para-ui-node-1 \
--pull=always \
-v="/$(pwd)/para-ui-node-1:/data" \
totemlive/generic-parachain-collator:latest \
generic-parachain-collator \
--state-cache-size=1 \
--chain para \
--execution=wasm \
--name "para-ui-node-1" \
--public-addr /ip4/159.89.1.153/tcp/31439 \
--port 30333 \
--ws-external \
-- \
--chain /data/genesis-file/rococo-local-totem.json \
--execution=wasm \
--public-addr /ip4/159.89.1.153/tcp/41436 \
--port 40333

# --wasm-execution compiled \
# Ports
# Mapped Docker Ports : Standard Ports : NGINX Ports
# 40436	40333	41436
# 30439	30333	31439
# 30537	30334	n/a
# 10039	9933	n/a
# 10137	9934	n/a
# 10250	9944	22222
# 10348	9945	n/a
# 9721	9615	19721
# 9819	9616	n/a
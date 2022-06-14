#!/usr/bin/env bash

# THIS SCRIPT REMOVES ALL THE BLOCKCHAIN STORAGE. DO NOT RUN UNLESS YOU KNOW WHAT YOU ARE DOING!

# All the scripts here contain the --tmp flag, which means that they will not persist the data once the node stops.

sudo rm -rf ./para/para-boot-node-1/parachain-collator && \
rm -rf ./para/para-boot-node-1/polkadot && \
rm -rf ./para/para-collator-node-1/parachain-collator && \
rm -rf ./para/para-collator-node-1/polkadot && \
rm -rf ./para/para-collator-node-2/parachain-collator && \
rm -rf ./para/para-collator-node-2/polkadot && \
rm -rf ./para/para-ui-node-1/parachain-collator && \
rm -rf ./para/para-ui-node-1/polkadot && \

# Don't automatically remove polkadot as it might be running OK

rm -rf ./rococo/rococo-local-auth1/chains && \
rm -rf ./rococo/rococo-local-auth2/chains && \
rm -rf ./rococo/rococo-local-ui1/chains && \

# Inspect the directories to check that they have been cleaned up

cd ~/ops/blockchain/chain-start-scripts/para/para-boot-node-1 && \
echo "" && \
echo "Contents of this directory:" && \
pwd && \
ls -lh && \
cd ~/ops/blockchain/chain-start-scripts/para/para-collator-node-1 && \
echo "" && \
echo "Contents of this directory:" && \
pwd && \
ls -lh && \
cd ~/ops/blockchain/chain-start-scripts/para/para-collator-node-2 && \
echo "" && \
echo "Contents of this directory:" && \
pwd && \
ls -lh && \
cd ~/ops/blockchain/chain-start-scripts/para/para-ui-node-1 && \
echo "" && \
echo "Contents of this directory:" && \
pwd && \
ls -lh && \
cd ~/ops/blockchain/chain-start-scripts/rococo/rococo-local-auth1 && \
echo "" && \
echo "Contents of this directory:" && \
pwd && \
ls -lh && \
cd ~/ops/blockchain/chain-start-scripts/rococo/rococo-local-auth2 && \
echo "" && \
echo "Contents of this directory:" && \
pwd && \
ls -lh && \
echo "" && \
echo "Contents of this directory:" && \
pwd && \
cd ~/ops/blockchain/chain-start-scripts/rococo/rococo-local-ui1 && \
ls -lh
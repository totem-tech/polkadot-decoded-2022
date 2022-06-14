# Key generation commands

This page contains basic key generation commands for setting up the test networks. It may be useful for some people.

```shell
#!/bin/sh

#----------------------KAPEX KEYS------------------------#
# The following generates the keys for the nodes
# Generate Node Identity Keys for 3 bootnodes for kapex
# The node identity is crezted from these keys - which is used in the genesis file - there is an output that appears after generation
docker run --rm parity/subkey:latest generate-node-key > ./keys/nodekey-kapex-boot1 && \
docker run --rm parity/subkey:latest generate-node-key > ./keys/nodekey-kapex-boot2 && \
docker run --rm parity/subkey:latest generate-node-key > ./keys/nodekey-kapex-boot3 && \

# Generate Node Identity Keys for each Authority Node
# This is used when starting up the autrhority nodes
docker run --rm parity/subkey:latest generate-node-key > ./keys/nodekey-kapex-auth1 && \
docker run --rm parity/subkey:latest generate-node-key > ./keys/nodekey-kapex-auth2 && \

# Generate Authority Keys for 2 Collators for kapex type Sr25519 
# The Auth Keys are used by validators/collators to sign blocks - they are also used in the genesis file - there is an output that appears after generation
docker run --rm parity/subkey:latest generate --scheme Sr25519 --words 24 > ./keys/authkey-kapex-1 && \
docker run --rm parity/subkey:latest generate --scheme Sr25519 --words 24 > ./keys/authkey-kapex-2 && \

# Generate Authority Keys for 1 Sudo for kapex type Sr25519
# The sudo keys must also be used in the genesis file
docker run --rm parity/subkey:latest generate --scheme Sr25519 --words 24 > ./keys/sudokey-kapex

# OPTiONAL Generate Node Keys for 1 UI for kapex
# docker run --rm parity/subkey:latest generate-node-key > ./keys/nodekey-kapex-ui1
#----------------------KAPEX KEYS------------------------#

#----------------------WAPEX KEYS------------------------#
# The following generates the keys for the nodes
# Generate Node Identity Keys for 1 bootnodes for wapex
# The node identity is crezted from these keys - which is used in the genesis file - there is an output that appears after generation
docker run --rm parity/subkey:latest generate-node-key > ./keys/nodekey-wapex-boot1 && \

# Generate Node Identity Keys for each Authority Node
# This is used when starting up the autrhority nodes
docker run --rm parity/subkey:latest generate-node-key > ./keys/nodekey-wapex-auth1 && \
docker run --rm parity/subkey:latest generate-node-key > ./keys/nodekey-wapex-auth2 && \

# Generate Authority Keys for 2 Collators for wapex type Sr25519 
# The Auth Keys are used by validators/collators to sign blocks - they are also used in the genesis file - there is an output that appears after generation
docker run --rm parity/subkey:latest generate --scheme Sr25519 --words 24 > ./keys/authkey-wapex-1 && \
docker run --rm parity/subkey:latest generate --scheme Sr25519 --words 24 > ./keys/authkey-wapex-2 && \

# Generate Authority Keys for 1 Sudo for wapex type Sr25519
# The sudo keys must also be used in the genesis file
docker run --rm parity/subkey:latest generate --scheme Sr25519 --words 24 > ./keys/sudokey-wapex

# OPTiONAL Generate Node Keys for 1 UI for wapex
# docker run --rm parity/subkey:latest generate-node-key > ./keys/nodekey-wapex-ui1
#----------------------WAPEX KEYS------------------------#


#----------------------DEMO KEYS------------------------#
# The following generates the keys for the nodes
# Generate Node Identity Keys for 1 bootnodes for demo
# The node identity is crezted from these keys - which is used in the genesis file - there is an output that appears after generation
docker run --rm parity/subkey:latest generate-node-key > ./keys/nodekey-demo-boot1 && \

# Generate Node Identity Keys for each Authority Node
# This is used when starting up the autrhority nodes
docker run --rm parity/subkey:latest generate-node-key > ./keys/nodekey-demo-auth1 && \
docker run --rm parity/subkey:latest generate-node-key > ./keys/nodekey-demo-auth2 && \

# Generate Authority Keys for 2 Collators for demo type Sr25519 
# The Auth Keys are used by validators/collators to sign blocks - they are also used in the genesis file - there is an output that appears after generation
docker run --rm parity/subkey:latest generate --scheme Sr25519 --words 24 > ./keys/authkey-demo-1 && \
docker run --rm parity/subkey:latest generate --scheme Sr25519 --words 24 > ./keys/authkey-demo-2 && \

# Generate Authority Keys for 1 Sudo for demo type Sr25519
# The sudo keys must also be used in the genesis file
docker run --rm parity/subkey:latest generate --scheme Sr25519 --words 24 > ./keys/sudokey-demo

# OPTiONAL Generate Node Keys for 1 UI for demo
# docker run --rm parity/subkey:latest generate-node-key > ./keys/nodekey-demo-ui1
#----------------------DEMO KEYS------------------------#

# Full nodes do not need to have their own keys - unless you want to use them to identify a node

# Generate Node Keys for 1 Full for kapex 
docker run --rm parity/subkey:latest generate-node-key > ./keys/nodekey-kapex-full1 && \
# Generate Node Keys for 1 Full for wapex
docker run --rm parity/subkey:latest generate-node-key > ./keys/nodekey-wapex-full1 && \
# Generate Node Keys for 1 Full for demo
docker run --rm parity/subkey:latest generate-node-key > ./keys/nodekey-demo-full1
```

<!-- Demo Identities
12D3KooWCwPGSVmQSLTRMgaU1GaK6oHXijKdFcMiCBzzKygxVcXL
12D3KooWMMmr6aQWKocpGhXo4EXZdPuNmohx16GYLAjGNvY3zPda
12D3KooWHXYjgQN6xDUixC8uK1aaXJC3dEGjQgdzC9TnYHmHayp3 -->
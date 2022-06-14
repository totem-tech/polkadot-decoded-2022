# Step 1

> Start this node until it has syncronised the blockchain

Note I have commented out the sections that are not needed in this step.

parity/polkadot:latest
- "--name"
- "p-validator-1"
- "--chain"
- "polkadot"
- "--port"
- "30333"
- "--pruning"
- "archive" 
# - "--validator"
# - "--ws-external"
# - "--rpc-cors"
# - "all"
# - "--rpc-external"
# - "--unsafe-rpc-external"
- "--public-addr"
- "/dns4/p-validator-1.kapex.network/tcp/port"
- "--prometheus-external"

# Step 2

Stop the node and configure these settings:

parity/polkadot:latest
- "--name"
- "p-validator-1"
- "--chain"
- "polkadot"
- "--port"
- "30333"
# - "--pruning"
# - "archive" 
- "--validator"
- "--ws-external"
- "--rpc-cors"
- "all"
- "--rpc-external"
- "--unsafe-rpc-external"
- "--public-addr"
- "/dns4/p-validator-1.kapex.network/tcp/port"
- "--prometheus-external"

Some manual key injection will need to be performed. 
This is also used if we need to pause validation for maintenance reasons for example.

# Step 3

Final stop the node again, to switch off direct public access to the node. The start up again.

parity/polkadot:latest
- "--name"
- "p-validator-1"
- "--chain"
- "polkadot"
- "--port"
- "30333"
- "--validator"
# - "--pruning"
# - "archive" 
# - "--ws-external"
# - "--rpc-cors"
# - "all"
# - "--rpc-external"
# - "--unsafe-rpc-external"
- "--public-addr"
- "/dns4/p-validator-1.kapex.network/tcp/port"
- "--prometheus-external"
# Polakdot & Parachain Network Commands 

#### Based on the Substrate and Cumulus Framework

---

> This document is no longer up-to-date. Refer to [ReadMe.md](./ReadMe.md)


These commands are used on all Substrate based blockchain nodes, and allow configuration beyond the in-built settings for each node.

The default in-built settings are generally also included in the runtime, however the design of the network is such that you can pass in a _chain specification file_ `chainspec.json` and your node will behave (execute) as if it is another network.

It is possible to do this because the `chainspec.json` file also contains a WASM executable, which is executed on startup. It will also contain other configuration parameters such as bootnodes. The totality of the `chainspec.json` file is the fingerprint for the network, and the first block in the blockchain is created from this file. In this way all nodes on the network are starting from the same seed inforlmation and can compute the hashes for all subsequent blocks so that they know which blocks are correct and which are not.

NOTE: in all cases below the docker `--rm`command is used. This will remove the container and hence all block data upon stopping. I also use the `-it` option to print the output to the terminal, but if you do not want to see this use the `-d` docker option.

## Listing all the various commands for execution of Polakdot

    docker run \
    --rm \
    -it \
    parity/polkadot:latest \
    --help

## Listing all the various commands for execution of a Parachain

    docker run \
    --rm \
    -it \
    parity/polkadot-collator:latest \
    --help

It is also possible to do help on each command.

## Extracting the chain specification for this node.

For Polkadot the `--chain` types are limited to all Polkadot-like chains.

    docker run \
    --rm \
    -it \
    parity/polkadot:latest \
    build-spec \
    --chain rococo-local > rococo-local-spec.json

## Minimal executing from docker 

This example executes the Westend version of Polkadot and connects to the Westend Network. Other options include `polkadot`, `kusama`, `rococo`, and `rococo-local`.

    docker run \
    --rm \
    -it \
    parity/polkadot:latest \
    --chain westend \
    --name "🍀🍀🍀chris🍀🍀🍀"

## Inspecting your running node

This is the URL for the Westend Network. You can navigate to ther networks selecting them from the dropdown list on the top right.

    https://telemetry.polkadot.io/#list/0xe143f23803ac50e8f6f8e62695d1ce9e4e1d68aa36c1cd2cfd15340213f3423e

Other networks can be selected from the menu on the top right. When running your own network you can see it in a sorted list in that menu. The list is sorted by the number of nodes on the network.


## Creating a network of nodes on the same machine means you will need to specify seperate ports. 

The default ports are `30333`, `9933`, `9944` and also [Prometheus](https://prometheus.io/) is started on `9615`.

    docker run \
    --rm \
    -dit \
    -p 30333:30333 \
    -p 9939:9933 \
    -p 9949:9944 \
    parity/polkadot:latest \
    --chain westend \
    --name "🍀🍀🍀chris2🍀🍀🍀"

### Other useful Docker options

A couple of useful ones!

    --restart unless-stopped
    --name <name for your container>
    --pull=always <---- Pulls `latest` version in dockerhub when available

### Persistent Data

In this example I have linked a persistent volume `-v` for the storage of the blockchain data, and network information. Permissions needs to be adjusted to allow storing the data.

### Specific IP address

`--public-addr` fixes the IP address for the node is useful when using docker and nginx in the format `/ip4/ip/tcp/port/ws` or `/dns4/FQDN/tcp/port/ws` [fully qualified domain name]

### Exposing a websocket so that clients can connect.

A client is considered a UI, a wallet, or some other service that needs to read blockchain data, and/or transmit transactions to the network. 

This can be carried out through RPC or Websocket using `--ws-external` or `--rpc-external`. 

RPC is generally considered unsafe to expose and should only be used in certain controlled circumstances.

In the case of Totem - there will be a UI that may connect to one or more nodes. This could be handled by one websocket endpoint with load-balancing to nodes that are behind the endpoint. Alternatively the client could select random nodes from a list of multiple different websocket URIs. 

Users can also run their own nodes and expose a websocket and connect their devices to their own node.

Connections are usually handled by the UI itself using either a domain name or IP address and port number using secure websockets `wss://...`.

### Safety of exposed services

**Websocket is the preferred method of connection** however, if RPC is used limits can be applied to the set of possible commands. These are referred to by the `--rpc-methods` option with selections of `Safe`, `Unsafe` and `Auto`. Read the docs for more information! 

    docker run \
    --rm \
    -dit \
    -p 30333:30333 \
    -p 9939:9933 \
    -p 9949:9944 \
    -v /my/local/folder:/polkadot \
    parity/polkadot:latest \
    --chain westend \
    --public-addr /ip4/ip/tcp/port
    --ws-external \
    --rpc-methods "Safe" \
    --name "🍀🍀🍀chris2🍀🍀🍀"

### Other RPC essentials

RPC can be employed safely if the service that is using it is on `localhost`. However if they are to be used externally, the following two options are needed, along with the `--rpc-methods` option. 

    --rpc-external
    --rpc-cors all

#### Validator nodes

In almost all cases the nodes will not be validators. However in the case where validators are running using the `--validator` option they **must not** also be websocket or RPC nodes.

# Running various nodes

## Running a Polakdot Full Node

    docker run \
    --rm \
    -it \
    parity/polkadot:latest \
    --name "Polkadot run by Totem Live"

## Running a Custom node from a chainspec file

The chainspec file should be extracted and adapted from the [`rococo-local`](#extracting-the-chain-specification-for-this-node) version of Polkadot.

    docker run \
    --rm \
    -it \
    parity/polkadot:latest \
    --chain chain-spec-file.json
    --name "Custom Node"

## Running a private local version of Polkadot for testing

Running on the same machine, distinguished by different ports. The chain type `local` can also be substituted by a custom chainspec file, but that chainspec file should be extracted and adapted from the [`rococo-local`](#extracting-the-chain-specification-for-this-node) version of Polkadot.

    #first node
    docker run \
    --rm \
    -it \
    -p 30333:30333 \
    -p 9933:9933 \
    -p 9944:9944 \
    parity/polkadot:latest \
    --chain local
    --alice
    --name "Private Node 1"

    # second node
    docker run \
    --rm \
    -it \
    -p 30334:30333 \
    -p 9934:9933 \
    -p 9945:9944 \
    parity/polkadot:latest \
    --chain local
    --bob
    --name "Private Node 2"

### Preferred Setup    

It is preferable to run using a chainspec file rather than the local option because this allows you to create a specific public network.

> **This setup uses `alice` and `bob` authorities which must not be used in production.**

    #Polkadot Local Network Validator and Bootnode Node 1
    docker run \
    --rm \
    -it \
    -p 30333:30333 \
    -p 9933:9933 \
    -p 9944:9944 \
    parity/polkadot:latest \
    --chain /path/to/rococo-local-totem.json \
    --alice
    --name "rococo-local-auth1"

    #Polkadot Local Network Validator Node 1
    docker run \
    --rm \
    -it \
    -p 30333:30333 \
    -p 9933:9933 \
    -p 9944:9944 \
    parity/polkadot:latest \
    --chain /path/to/rococo-local-totem.json \
    --bob
    --name "rococo-local-auth2"

    #Polkadot Local Network UI Node 1 (used to be a websocket endpoint)
    docker run \
    --rm \
    -it \
    -p 30333:30333 \
    -p 9933:9933 \
    -p 9944:9944 \
    parity/polkadot:latest \
    --chain /path/to/rococo-local-totem.json \
    --ws-external \
    --name "rococo-local-ui1"

## Running a parachain network 

Note this is using a test image from docker hub called `polkadot-collator:latest`. 

In order to run a real parachain network, a newly compiled docker image of the Totem node will be needed.

**BEFORE THIS CAN RUN** There are a number of steps to register the parachain on the Polkadot test network set out in the next section. It is assumed that the parachain id is `2000`.

> ~~This setup uses `alice` and `bob` authorities which must not be used in production.~~

The large number of ports are because parachains also run mini-polkadot nodes and need to connect to that network too. The 96* ports are for prometheus.

    # Parachain Boot Node 1
    # Identity seen in output: 12D3KooWBsMTJeHCa9Mgq4qQECkfxJ6P9WyajEFF8gEzSaC9npVm
    docker run \
    --rm \
    -it \
    -p 40333:40333 \
    -p 30333:30333 \
    -p 30334:30334 \
    -p 9933:9933 \
    -p 9934:9934 \
    -p 9944:9944 \
    -p 9945:9945 \
    -p 9615:9615 \
    -p 9616:9616 \
    totemlive/totem-parachain-collator:latest \
totem-parachain-collator \
    --port 30333 \
    --name "demo-boot-node-1" \
    --node-key-file /path/to/nodekey-demo-boot1 \
    --node-key-type 'ed25519' \
    -- \
    --chain /path/to/rococo-local-totem.json \
    --port 40333

    # Parachain Collator/Validator Node 1
    docker run \
    --rm \
    -it \
    -p 40333:40333 \
    -p 30333:30333 \
    -p 30334:30334 \
    -p 9933:9933 \
    -p 9934:9934 \
    -p 9944:9944 \
    -p 9945:9945 \
    -p 9615:9615 \
    -p 9616:9616 \
    totemlive/totem-parachain-collator:latest \
totem-parachain-collator \
    --port 30333 \
    --name "demo-collator-node-1" \
    --collator \
    --keystore-path /path/to/keystore-demo-auth1 \
    --force-authoring \ 
    -- \
    --chain /path/to/rococo-local-totem.json \
    --port 40333

    # Parachain Collator/Validator Node 2
    docker run \
    --rm \
    -it \
    -p 40333:40333 \
    -p 30333:30333 \
    -p 30334:30334 \
    -p 9933:9933 \
    -p 9934:9934 \
    -p 9944:9944 \
    -p 9945:9945 \
    -p 9615:9615 \
    -p 9616:9616 \
    totemlive/totem-parachain-collator:latest \
totem-parachain-collator \
    --port 30333 \
    --name "demo-collator-node-1" \
    --collator \
    --keystore-path /path/to/keystore-demo-auth2 \
    --force-authoring \ 
    -- \
    --chain /path/to/rococo-local-totem.json \
    --port 40333

    # Parachain UI Node (full node running as an endpoint)
    docker run \
    --rm \
    -it \
    -p 40333:40333 \
    -p 30333:30333 \
    -p 30334:30334 \
    -p 9933:9933 \
    -p 9934:9934 \
    -p 9944:9944 \
    -p 9945:9945 \
    -p 9615:9615 \
    -p 9616:9616 \
    totemlive/totem-parachain-collator:latest \
totem-parachain-collator \
    --port 30333 \
    --node-key-file /path/to/nodekey-demo-ui1 \
    --node-key-type 'ed25519' \
    --ws-external \
    --name "demo-ui-node-1" \
    -- \
    --chain /path/to/rococo-local-totem.json \
    --port 40333

## Extract Genesis State and WASM blob from Parachain 

It is necessary to do this in order to register the parachain with the Polkadot (Test) network.

If this is is a Totem Parachain Node running from Docker you will not require the `--chain` option.

### Genesis State

    docker run \
    --rm \
    -it \
    totemlive/totem-parachain-collator:latest \
totem-parachain-collator \
    export-genesis-state \
    --parachain-id 2000 > genesis-state

### WASM Blob

    docker run \
    --rm \
    -it \
    totemlive/totem-parachain-collator:latest \
totem-parachain-collator \
    export-genesis-wasm > genesis-wasm

---

# Domain Naming 

This is the naming convention to be used for the various endpoints on the network

    //All nodes are to be considered archive nodes, meaning that we will not be pruning the data 

    //Demo Test Network
    l-boot-1.kapex.network // a permanent boot node
    l-auth-1.kapex.network // a collator or validator
    l-auth-2.kapex.network // a collator or validator
    l-ui-1.kapex.network // a node that exposes --ws-external
    l-full-1.kapex.network // just a plain node
    
    //Demo Polkadot Test Network (aka rococo-local)
    r-boot-1.kapex.network 
    r-auth-1.kapex.network 
    r-auth-2.kapex.network 
    r-ui-1.kapex.network 
    r-full-1.kapex.network 

    //Kapex Live Network 
    k-boot-1.kapex.network
    k-boot-2.kapex.network
    k-boot-3.kapex.network
    k-auth-1.kapex.network
    k-auth-2.kapex.network
    k-ui-1.kapex.network
    k-full-1.kapex.network

    //Wapex Quality Test Network
    w-boot-1.kapex.network
    w-auth-1.kapex.network
    w-auth-2.kapex.network
    w-ui-1.kapex.network
    w-full-1.kapex.network

    //Future Polakadot Network (as a participant - no boot nodes needed)
    p-auth-1.kapex.network
    p-ui-1.kapex.network
    p-full-1.kapex.network

    //Future Totem Main Network 
    t-boot-1.kapex.network
    t-boot-2.kapex.network
    t-boot-3.kapex.network
    t-auth-1.kapex.network
    t-auth-2.kapex.network
    t-auth-3.kapex.network
    t-auth-4.kapex.network
    t-auth-5.kapex.network
    t-ui-1.kapex.network
    t-ui-2.kapex.network
    t-ui-3.kapex.network
    t-full-1.kapex.network

## Boot node config 

Boot nodes are determined by their network identity which is created from a key file. They are as follows:

    l-boot-1.kapex.network
    k-boot-1.kapex.network
    w-boot-1.kapex.network

### These are the expected identities seen when running the boot nodes:

    # demo-boot1
    12D3KooWBsMTJeHCa9Mgq4qQECkfxJ6P9WyajEFF8gEzSaC9npVm

    # -demo-polkadot-boot1
    12D3KooWHvQWJrZBbfH2yCTtFLMBthThjTuYemjRRRVWpxTN1WQv

    # -wapex-boot1
    12D3KooWDAu2WpmipvUkuE4535LBTzfc37KJPjK46on45Widn7ud

    # -kapex-boot1
    12D3KooWEFd1cZEKAV76y9Uv3kE3eBJGnBeEDMrs7vFDYy5VgRPK

    # -kapex-boot2
    12D3KooWEcnVLou4oqPJUstYDT91JbPrFaYj7MFJPV6Nz4m3BNn6

    # -kapex-boot3
    12D3KooWJySWN9YdTcvBDXjwhoEMKnHg88LMfBWh2FXYDWFV6LdJ

---

# Full list of Polkadot commands [Dec 2021]

These are slightly different from the parachain collator commands, which are listed in the next section.

```shell
Parity Technologies <admin@parity.io>
Polkadot Relay-chain Client Node

USAGE:
    polkadot [FLAGS] [OPTIONS]
    polkadot <SUBCOMMAND>

FLAGS:
        --alice                            
            Shortcut for `--name Alice --validator` with session keys for `Alice` added to keystore

        --allow-private-ipv4               
            Always accept connecting to private IPv4 addresses (as specified in
            [RFC1918](https://tools.ietf.org/html/rfc1918)). Enabled by default for chains marked as "local" in their
            chain specifications, or when `--dev` is passed
        --bob                              
            Shortcut for `--name Bob --validator` with session keys for `Bob` added to keystore

        --charlie                          
            Shortcut for `--name Charlie --validator` with session keys for `Charlie` added to keystore

        --dave                             
            Shortcut for `--name Dave --validator` with session keys for `Dave` added to keystore

        --detailed-log-output              
            Enable detailed log output.
            
            This includes displaying the log target, log level and thread name.
            
            This is automatically enabled when something is logged with any higher level than `info`.
        --dev                              
            Specify the development chain.
            
            This flag sets `--chain=dev`, `--force-authoring`, `--rpc-cors=all`, `--alice`, and `--tmp` flags, unless
            explicitly overridden.
        --disable-log-color                
            Disable log color output

        --discover-local                   
            Enable peer discovery on local networks.
            
            By default this option is `true` for `--dev` or when the chain type is `Local`/`Development` and false
            otherwise.
        --enable-log-reloading             
            Enable feature to dynamically update and reload the log filter.
            
            Be aware that enabling this feature can lead to a performance decrease up to factor six or more. Depending
            on the global logging level the performance decrease changes.
            
            The `system_addLogFilter` and `system_resetLogFilter` RPCs will have no effect with this option not being
            set.
        --eve                              
            Shortcut for `--name Eve --validator` with session keys for `Eve` added to keystore

        --ferdie                           
            Shortcut for `--name Ferdie --validator` with session keys for `Ferdie` added to keystore

        --force-authoring                  
            Enable authoring even when offline

        --force-kusama                     
            Force using Kusama native runtime

        --force-rococo                     
            Force using Rococo native runtime

        --force-westend                    
            Force using Westend native runtime

    -h, --help                             
            Prints help information

        --ipfs-server                      
            Join the IPFS network and serve transactions over bitswap protocol

        --kademlia-disjoint-query-paths    
            Require iterative Kademlia DHT queries to use disjoint paths for increased resiliency in the presence of
            potentially adversarial nodes.
            
            See the S/Kademlia paper for more information on the high level design as well as its security improvements.
        --light                            
            Experimental: Run in light client mode

        --no-beefy                         
            Disable BEEFY gadget

        --no-grandpa                       
            Disable GRANDPA voter when running in validator mode, otherwise disable the GRANDPA observer

        --no-mdns                          
            Disable mDNS discovery.
            
            By default, the network will use mDNS to discover other nodes on the local network. This disables it.
            Automatically implied when using --dev.
        --no-private-ipv4                  
            Always forbid connecting to private IPv4 addresses (as specified in
            [RFC1918](https://tools.ietf.org/html/rfc1918)), unless the address was passed with `--reserved-nodes` or
            `--bootnodes`. Enabled by default for chains marked as "live" in their chain specifications
        --no-prometheus                    
            Do not expose a Prometheus exporter endpoint.
            
            Prometheus metric endpoint is enabled by default.
        --no-telemetry                     
            Disable connecting to the Substrate telemetry server.
            
            Telemetry is on by default on global chains.
        --one                              
            Shortcut for `--name One --validator` with session keys for `One` added to keystore

        --password-interactive             
            Use interactive shell for entering the password used by the keystore

        --prometheus-external              
            Expose Prometheus exporter on all interfaces.
            
            Default is local.
        --reserved-only                    
            Whether to only synchronize the chain with reserved nodes.
            
            Also disables automatic peer discovery.
            
            TCP connections might still be established with non-reserved nodes. In particular, if you are a validator
            your node might still connect to other validator nodes and collator nodes regardless of whether they are
            defined as reserved nodes.
        --rpc-external                     
            Listen to all RPC interfaces.
            
            Default is local. Note: not all RPC methods are safe to be exposed publicly. Use an RPC proxy server to
            filter out dangerous methods. More details: <https://docs.substrate.io/v3/runtime/custom-rpcs/#public-rpcs>.
            Use `--unsafe-rpc-external` to suppress the warning if you understand the risks.
        --storage-chain                    
            Enable storage chain mode
            
            This changes the storage format for blocks bodies. If this is enabled, each transaction is stored separately
            in the transaction database column and is only referenced by hash in the block body column.
        --tmp                              
            Run a temporary node.
            
            A temporary directory will be created to store the configuration and will be deleted at the end of the
            process.
            
            Note: the directory is random per process execution. This directory is used as base path which includes:
            database, node key and keystore.
            
            When `--dev` is given and no explicit `--base-path`, this option is implied.
        --two                              
            Shortcut for `--name Two --validator` with session keys for `Two` added to keystore

        --unsafe-pruning                   
            Force start with unsafe pruning settings.
            
            When running as a validator it is highly recommended to disable state pruning (i.e. 'archive') which is the
            default. The node will refuse to start as a validator if pruning is enabled unless this option is set.
        --unsafe-rpc-external              
            Listen to all RPC interfaces.
            
            Same as `--rpc-external`.
        --unsafe-ws-external               
            Listen to all Websocket interfaces.
            
            Same as `--ws-external` but doesn't warn you about it.
        --validator                        
            Enable validator mode.
            
            The node will be started with the authority role and actively participate in any consensus task that it can
            (e.g. depending on availability of local keys).
    -V, --version                          
            Prints version information

        --ws-external                      
            Listen to all Websocket interfaces.
            
            Default is local. Note: not all RPC methods are safe to be exposed publicly. Use an RPC proxy server to
            filter out dangerous methods. More details: <https://docs.substrate.io/v3/runtime/custom-rpcs/#public-rpcs>.
            Use `--unsafe-ws-external` to suppress the warning if you understand the risks.

OPTIONS:
    -d, --base-path <PATH>                                           
            Specify custom base path

        --bootnodes <ADDR>...                                        
            Specify a list of bootnodes

        --chain <CHAIN_SPEC>                                         
            Specify the chain specification.
            
            It can be one of the predefined ones (dev, local, or staging) or it can be a path to a file with the
            chainspec (such as one exported by the `build-spec` subcommand).
        --database <DB>
            Select database backend to use [possible values: rocksdb, paritydb-experimental, auto]

        --db-cache <MiB>                                             
            Limit the memory the database cache can use

        --offchain-worker <ENABLED>
            Should execute offchain workers on every block.
            
            By default it's only enabled for nodes that are authoring new blocks. [default: WhenValidating]
            [possible values: Always, Never, WhenValidating]
        --execution <STRATEGY>
            The execution strategy that should be used by all execution contexts [possible values: Native,
            Wasm, Both, NativeElseWasm]
        --execution-block-construction <STRATEGY>
            The means of execution used when calling into the runtime while constructing blocks [possible values:
            Native, Wasm, Both, NativeElseWasm]
        --execution-import-block <STRATEGY>
            The means of execution used when calling into the runtime for general block import (including locally
            authored blocks) [possible values: Native, Wasm, Both, NativeElseWasm]
        --execution-offchain-worker <STRATEGY>
            The means of execution used when calling into the runtime while using an off-chain worker [possible values:
            Native, Wasm, Both, NativeElseWasm]
        --execution-other <STRATEGY>
            The means of execution used when calling into the runtime while not syncing, importing or constructing
            blocks [possible values: Native, Wasm, Both, NativeElseWasm]
        --execution-syncing <STRATEGY>
            The means of execution used when calling into the runtime for importing blocks as part of an initial sync
            [possible values: Native, Wasm, Both, NativeElseWasm]
        --grandpa-pause <grandpa-pause> <grandpa-pause>              
            Setup a GRANDPA scheduled voting pause.
            
            This parameter takes two values, namely a block number and a delay (in blocks). After the given block number
            is finalized the GRANDPA voter will temporarily stop voting for new blocks until the given delay has elapsed
            (i.e. until a block at height `pause_block + delay` is imported).
        --in-peers <COUNT>
            Specify the maximum number of incoming connections we're accepting [default: 25]

        --enable-offchain-indexing <ENABLE_OFFCHAIN_INDEXING>
            Enable Offchain Indexing API, which allows block import to write to Offchain DB.
            
            Enables a runtime to write directly to a offchain workers DB during block import.
        --ipc-path <PATH>                                            
            Specify IPC RPC server path

        --jaeger-agent <jaeger-agent>                                
            Add the destination address to the jaeger agent.
            
            Must be valid socket address, of format `IP:Port` commonly `127.0.0.1:6831`.
        --keep-blocks <COUNT>
            Specify the number of finalized blocks to keep in the database.
            
            Default is to keep all blocks.
        --keystore-path <PATH>                                       
            Specify custom keystore path

        --keystore-uri <keystore-uri>
            Specify custom URIs to connect to for keystore-services

        --listen-addr <LISTEN_ADDR>...                               
            Listen on this multiaddress.
            
            By default: If `--validator` is passed: `/ip4/0.0.0.0/tcp/<port>` and `/ip6/[::]/tcp/<port>`. Otherwise:
            `/ip4/0.0.0.0/tcp/<port>/ws` and `/ip6/[::]/tcp/<port>/ws`.
    -l, --log <LOG_PATTERN>...
            Sets a custom logging filter. Syntax is <target>=<level>, e.g. -lsync=debug.
            
            Log levels (least to most verbose) are error, warn, info, debug, and trace. By default, all targets log
            `info`. The global log level can be set with -l<level>.
        --max-parallel-downloads <COUNT>
            Maximum number of peers from which to ask for the same blocks in parallel.
            
            This allows downloading announced blocks from multiple peers. Decrease to save traffic and risk increased
            latency. [default: 5]
        --max-runtime-instances <max-runtime-instances>              
            The size of the instances cache for each runtime.
            
            The default value is 8 and the values higher than 256 are ignored.
        --name <NAME>                                                
            The human-readable name for this node.
            
            The node name will be reported to the telemetry server, if enabled.
        --node-key <KEY>                                             
            The secret key to use for libp2p networking.
            
            The value is a string that is parsed according to the choice of `--node-key-type` as follows:
            
            `ed25519`: The value is parsed as a hex-encoded Ed25519 32 byte secret key, i.e. 64 hex characters.
            
            The value of this option takes precedence over `--node-key-file`.
            
            WARNING: Secrets provided as command-line arguments are easily exposed. Use of this option should be limited
            to development and testing. To use an externally managed secret key, use `--node-key-file` instead.
        --node-key-file <FILE>
            The file from which to read the node's secret key to use for libp2p networking.
            
            The contents of the file are parsed according to the choice of `--node-key-type` as follows:
            
            `ed25519`: The file must contain an unencoded 32 byte or hex encoded Ed25519 secret key.
            
            If the file does not exist, it is created with a newly generated secret key of the chosen type.
        --node-key-type <TYPE>
            The type of secret key to use for libp2p networking.
            
            The secret key of the node is obtained as follows:
            
            * If the `--node-key` option is given, the value is parsed as a secret key according to the type. See the
            documentation for `--node-key`.
            
            * If the `--node-key-file` option is given, the secret key is read from the specified file. See the
            documentation for `--node-key-file`.
            
            * Otherwise, the secret key is read from a file with a predetermined, type-specific name from the chain-
            specific network config directory inside the base directory specified by `--base-dir`. If this file
            does not exist, it is created with a newly generated secret key of the chosen type.
            
            The node's secret key determines the corresponding public key and hence the node's peer ID in the context of
            libp2p. [default: Ed25519]  [possible values: Ed25519]
        --out-peers <COUNT>
            Specify the number of outgoing connections we're trying to maintain [default: 25]

        --password <password>
            Password used by the keystore. This allows appending an extra user-defined secret to the seed

        --password-filename <PATH>
            File that contains the password used by the keystore

        --pool-kbytes <COUNT>
            Maximum number of kilobytes of all transactions stored in the pool [default: 20480]

        --pool-limit <COUNT>
            Maximum number of transactions in the transaction pool [default: 8192]

        --port <PORT>                                                
            Specify p2p protocol TCP port

        --prometheus-port <PORT>                                     
            Specify Prometheus exporter TCP Port

        --pruning <PRUNING_MODE>
            Specify the state pruning mode, a number of blocks to keep or 'archive'.
            
            Default is to keep all block states if the node is running as a validator (i.e. 'archive'), otherwise state
            is only kept for the last 256 blocks.
        --public-addr <PUBLIC_ADDR>...
            The public address that other nodes will use to connect to it. This can be used if there's a proxy in front
            of this node
        --reserved-nodes <ADDR>...                                   
            Specify a list of reserved node addresses

        --rpc-cors <ORIGINS>
            Specify browser Origins allowed to access the HTTP & WS RPC servers.
            
            A comma-separated list of origins (protocol://domain or special `null` value). Value of `all` will disable
            origin validation. Default is to allow localhost and <https://polkadot.js.org> origins. When running in
            --dev mode the default is to allow all origins.
        --rpc-max-payload <rpc-max-payload>
            Set the the maximum RPC payload size for both requests and responses (both http and ws), in megabytes.
            Default is 15MiB
        --rpc-methods <METHOD SET>
            RPC methods to expose.
            
            - `Unsafe`: Exposes every RPC method.
            - `Safe`: Exposes only a safe subset of RPC methods, denying unsafe RPC methods.
            - `Auto`: Acts as `Safe` if RPC is served externally, e.g. when `--{rpc,ws}-external` is
              passed, otherwise acts as `Unsafe`. [default: Auto]  [possible values: Auto, Safe,
            Unsafe]
        --rpc-port <PORT>                                            
            Specify HTTP RPC server TCP port

        --state-cache-size <Bytes>
            Specify the state cache size [default: 67108864]

        --sync <SYNC_MODE>                                           
            Blockchain syncing mode.
            
            - `Full`: Download and validate full blockchain history.
            
            - `Fast`: Download blocks and the latest state only.
            
            - `FastUnsafe`: Same as `Fast`, but skip downloading state proofs. [default: Full]
        --telemetry-url <URL VERBOSITY>...                           
            The URL of the telemetry server to connect to.
            
            This flag can be passed multiple times as a means to specify multiple telemetry endpoints. Verbosity levels
            range from 0-9, with 0 denoting the least verbosity. Expected format is 'URL VERBOSITY', e.g. `--telemetry-
            url 'wss://foo/bar 0'`.
        --tracing-receiver <RECEIVER>
            Receiver to process tracing messages [default: Log]  [possible values: Log]

        --tracing-targets <TARGETS>
            Sets a custom profiling filter. Syntax is the same as for logging: <target>=<level>

        --wasm-execution <METHOD>
            Method for executing Wasm runtime code [default: Compiled]  [possible values: interpreted-i-know-
            what-i-do, compiled]
        --wasm-runtime-overrides <PATH>
            Specify the path where local WASM runtimes are stored.
            
            These runtimes will override on-chain runtimes when the version matches.
        --ws-max-connections <COUNT>                                 
            Maximum number of WS RPC server connections

        --ws-max-out-buffer-capacity <ws-max-out-buffer-capacity>
            Set the the maximum WebSocket output buffer size in MiB. Default is 16

        --ws-port <PORT>                                             
            Specify WebSockets RPC server TCP port


SUBCOMMANDS:
    benchmark        Benchmark runtime pallets.
    build-spec       Build a chain specification
    check-block      Validate blocks
    export-blocks    Export blocks
    export-state     Export the state of a given block into a chain spec
    help             Prints this message or the help of the given subcommand(s)
    import-blocks    Import blocks
    key              Key management CLI utilities
    purge-chain      Remove the whole chain
    revert           Revert the chain to a previous state
    try-runtime      Try some command against runtime state. Note: `try-runtime` feature must be enabled
```

# Full list of Parachain Commands [Dec 2021]

There are some specific commands related to parachain execution in this list of commands.

```shell
Parity Technologies <admin@parity.io>
Polkadot collator

The command-line arguments provided first will be passed to the parachain node, while the arguments provided after --
will be passed to the relaychain node.

polkadot-collator [parachain-args] -- [relaychain-args]

USAGE:
    polkadot-collator [FLAGS] [OPTIONS] [-- <relaychain-args>...]
    polkadot-collator <SUBCOMMAND>

FLAGS:
        --alice                            
            Shortcut for `--name Alice --validator` with session keys for `Alice` added to keystore

        --allow-private-ipv4               
            Always accept connecting to private IPv4 addresses (as specified in
            [RFC1918](https://tools.ietf.org/html/rfc1918)). Enabled by default for chains marked as "local" in their
            chain specifications, or when `--dev` is passed
        --bob                              
            Shortcut for `--name Bob --validator` with session keys for `Bob` added to keystore

        --charlie                          
            Shortcut for `--name Charlie --validator` with session keys for `Charlie` added to keystore

        --collator                         
            Run node as collator.
            
            Note that this is the same as running with `--validator`.
        --dave                             
            Shortcut for `--name Dave --validator` with session keys for `Dave` added to keystore

        --dev                              
            Specify the development chain

        --disable-log-color                
            Disable log color output

        --disable-log-reloading            
            Disable feature to dynamically update and reload the log filter.
            
            By default this feature is enabled, however it leads to a small performance decrease. The
            `system_addLogFilter` and `system_resetLogFilter` RPCs will have no effect with this option set.
        --discover-local                   
            Enable peer discovery on local networks.
            
            By default this option is `true` for `--dev` or when the chain type is `Local`/`Development` and false
            otherwise.
        --eve                              
            Shortcut for `--name Eve --validator` with session keys for `Eve` added to keystore

        --ferdie                           
            Shortcut for `--name Ferdie --validator` with session keys for `Ferdie` added to keystore

        --force-authoring                  
            Enable authoring even when offline

    -h, --help                             
            Prints help information

        --ipfs-server                      
            Join the IPFS network and serve transactions over bitswap protocol

        --kademlia-disjoint-query-paths    
            Require iterative Kademlia DHT queries to use disjoint paths for increased resiliency in the presence of
            potentially adversarial nodes.
            
            See the S/Kademlia paper for more information on the high level design as well as its security improvements.
        --light                            
            Experimental: Run in light client mode

        --no-grandpa                       
            Disable GRANDPA voter when running in validator mode, otherwise disable the GRANDPA observer

        --no-mdns                          
            Disable mDNS discovery.
            
            By default, the network will use mDNS to discover other nodes on the local network. This disables it.
            Automatically implied when using --dev.
        --no-private-ipv4                  
            Always forbid connecting to private IPv4 addresses (as specified in
            [RFC1918](https://tools.ietf.org/html/rfc1918)), unless the address was passed with `--reserved-nodes` or
            `--bootnodes`. Enabled by default for chains marked as "live" in their chain specifications
        --no-prometheus                    
            Do not expose a Prometheus exporter endpoint.
            
            Prometheus metric endpoint is enabled by default.
        --no-telemetry                     
            Disable connecting to the Substrate telemetry server.
            
            Telemetry is on by default on global chains.
        --one                              
            Shortcut for `--name One --validator` with session keys for `One` added to keystore

        --password-interactive             
            Use interactive shell for entering the password used by the keystore

        --prometheus-external              
            Expose Prometheus exporter on all interfaces.
            
            Default is local.
        --reserved-only                    
            Whether to only synchronize the chain with reserved nodes.
            
            Also disables automatic peer discovery.
            
            TCP connections might still be established with non-reserved nodes. In particular, if you are a validator
            your node might still connect to other validator nodes and collator nodes regardless of whether they are
            defined as reserved nodes.
        --rpc-external                     
            Listen to all RPC interfaces.
            
            Default is local. Note: not all RPC methods are safe to be exposed publicly. Use an RPC proxy server to
            filter out dangerous methods. More details: <https://github.com/paritytech/substrate/wiki/Public-RPC>. Use
            `--unsafe-rpc-external` to suppress the warning if you understand the risks.
        --storage-chain                    
            Enable storage chain mode
            
            This changes the storage format for blocks bodies. If this is enabled, each transaction is stored separately
            in the transaction database column and is only referenced by hash in the block body column.
        --tmp                              
            Run a temporary node.
            
            A temporary directory will be created to store the configuration and will be deleted at the end of the
            process.
            
            Note: the directory is random per process execution. This directory is used as base path which includes:
            database, node key and keystore.
        --two                              
            Shortcut for `--name Two --validator` with session keys for `Two` added to keystore

        --unsafe-pruning                   
            Force start with unsafe pruning settings.
            
            When running as a validator it is highly recommended to disable state pruning (i.e. 'archive') which is the
            default. The node will refuse to start as a validator if pruning is enabled unless this option is set.
        --unsafe-rpc-external              
            Listen to all RPC interfaces.
            
            Same as `--rpc-external`.
        --unsafe-ws-external               
            Listen to all Websocket interfaces.
            
            Same as `--ws-external` but doesn't warn you about it.
        --validator                        
            Enable validator mode.
            
            The node will be started with the authority role and actively participate in any consensus task that it can
            (e.g. depending on availability of local keys).
    -V, --version                          
            Prints version information

        --ws-external                      
            Listen to all Websocket interfaces.
            
            Default is local. Note: not all RPC methods are safe to be exposed publicly. Use an RPC proxy server to
            filter out dangerous methods. More details: <https://github.com/paritytech/substrate/wiki/Public-RPC>. Use
            `--unsafe-ws-external` to suppress the warning if you understand the risks.

OPTIONS:
    -d, --base-path <PATH>                                       
            Specify custom base path

        --bootnodes <ADDR>...                                    
            Specify a list of bootnodes

        --chain <CHAIN_SPEC>                                     
            Specify the chain specification.
            
            It can be one of the predefined ones (dev, local, or staging) or it can be a path to a file with the
            chainspec (such as one exported by the `build-spec` subcommand).
        --database <DB>
            Select database backend to use [possible values: rocksdb, paritydb-experimental]

        --db-cache <MiB>                                         
            Limit the memory the database cache can use

        --offchain-worker <ENABLED>
            Should execute offchain workers on every block.
            
            By default it's only enabled for nodes that are authoring new blocks. [default: WhenValidating]
            [possible values: Always, Never, WhenValidating]
        --execution <STRATEGY>
            The execution strategy that should be used by all execution contexts [possible values: Native,
            Wasm, Both, NativeElseWasm]
        --execution-block-construction <STRATEGY>
            The means of execution used when calling into the runtime while constructing blocks [possible values:
            Native, Wasm, Both, NativeElseWasm]
        --execution-import-block <STRATEGY>
            The means of execution used when calling into the runtime for general block import (including locally
            authored blocks) [possible values: Native, Wasm, Both, NativeElseWasm]
        --execution-offchain-worker <STRATEGY>
            The means of execution used when calling into the runtime while using an off-chain worker [possible values:
            Native, Wasm, Both, NativeElseWasm]
        --execution-other <STRATEGY>
            The means of execution used when calling into the runtime while not syncing, importing or constructing
            blocks [possible values: Native, Wasm, Both, NativeElseWasm]
        --execution-syncing <STRATEGY>
            The means of execution used when calling into the runtime for importing blocks as part of an initial sync
            [possible values: Native, Wasm, Both, NativeElseWasm]
        --in-peers <COUNT>
            Specify the maximum number of incoming connections we're accepting [default: 25]

        --enable-offchain-indexing <ENABLE_OFFCHAIN_INDEXING>
            Enable Offchain Indexing API, which allows block import to write to Offchain DB.
            
            Enables a runtime to write directly to a offchain workers DB during block import.
        --ipc-path <PATH>                                        
            Specify IPC RPC server path

        --keep-blocks <COUNT>
            Specify the number of finalized blocks to keep in the database.
            
            Default is to keep all blocks.
        --keystore-path <PATH>                                   
            Specify custom keystore path

        --keystore-uri <keystore-uri>                            
            Specify custom URIs to connect to for keystore-services

        --listen-addr <LISTEN_ADDR>...                           
            Listen on this multiaddress.
            
            By default: If `--validator` is passed: `/ip4/0.0.0.0/tcp/<port>` and `/ip6/[::]/tcp/<port>`. Otherwise:
            `/ip4/0.0.0.0/tcp/<port>/ws` and `/ip6/[::]/tcp/<port>/ws`.
    -l, --log <LOG_PATTERN>...
            Sets a custom logging filter. Syntax is <target>=<level>, e.g. -lsync=debug.
            
            Log levels (least to most verbose) are error, warn, info, debug, and trace. By default, all targets log
            `info`. The global log level can be set with -l<level>.
        --max-parallel-downloads <COUNT>
            Maximum number of peers from which to ask for the same blocks in parallel.
            
            This allows downloading announced blocks from multiple peers. Decrease to save traffic and risk increased
            latency. [default: 5]
        --max-runtime-instances <max-runtime-instances>          
            The size of the instances cache for each runtime.
            
            The default value is 8 and the values higher than 256 are ignored.
        --name <NAME>                                            
            The human-readable name for this node.
            
            The node name will be reported to the telemetry server, if enabled.
        --node-key <KEY>                                         
            The secret key to use for libp2p networking.
            
            The value is a string that is parsed according to the choice of `--node-key-type` as follows:
            
            `ed25519`: The value is parsed as a hex-encoded Ed25519 32 byte secret key, i.e. 64 hex characters.
            
            The value of this option takes precedence over `--node-key-file`.
            
            WARNING: Secrets provided as command-line arguments are easily exposed. Use of this option should be limited
            to development and testing. To use an externally managed secret key, use `--node-key-file` instead.
        --node-key-file <FILE>
            The file from which to read the node's secret key to use for libp2p networking.
            
            The contents of the file are parsed according to the choice of `--node-key-type` as follows:
            
            `ed25519`: The file must contain an unencoded 32 byte or hex encoded Ed25519 secret key.
            
            If the file does not exist, it is created with a newly generated secret key of the chosen type.
        --node-key-type <TYPE>
            The type of secret key to use for libp2p networking.
            
            The secret key of the node is obtained as follows:
            
            * If the `--node-key` option is given, the value is parsed as a secret key according to the type. See the
            documentation for `--node-key`.
            
            * If the `--node-key-file` option is given, the secret key is read from the specified file. See the
            documentation for `--node-key-file`.
            
            * Otherwise, the secret key is read from a file with a predetermined, type-specific name from the chain-
            specific network config directory inside the base directory specified by `--base-dir`. If this file
            does not exist, it is created with a newly generated secret key of the chosen type.
            
            The node's secret key determines the corresponding public key and hence the node's peer ID in the context of
            libp2p. [default: Ed25519]  [possible values: Ed25519]
        --out-peers <COUNT>
            Specify the number of outgoing connections we're trying to maintain [default: 25]

        --parachain-id <parachain-id>                            
            Found DEPRECATED 29/12/2021 Id of the parachain this collator collates for

        --password <password>                                    
            Password used by the keystore

        --password-filename <PATH>                               
            File that contains the password used by the keystore

        --pool-kbytes <COUNT>
            Maximum number of kilobytes of all transactions stored in the pool [default: 20480]

        --pool-limit <COUNT>
            Maximum number of transactions in the transaction pool [default: 8192]

        --port <PORT>                                            
            Specify p2p protocol TCP port

        --prometheus-port <PORT>                                 
            Specify Prometheus exporter TCP Port

        --pruning <PRUNING_MODE>
            Specify the state pruning mode, a number of blocks to keep or 'archive'.
            
            Default is to keep all block states if the node is running as a validator (i.e. 'archive'), otherwise state
            is only kept for the last 256 blocks.
        --public-addr <PUBLIC_ADDR>...
            The public address that other nodes will use to connect to it. This can be used if there's a proxy in front
            of this node
        --reserved-nodes <ADDR>...                               
            Specify a list of reserved node addresses

        --rpc-cors <ORIGINS>
            Specify browser Origins allowed to access the HTTP & WS RPC servers.
            
            A comma-separated list of origins (protocol://domain or special `null` value). Value of `all` will disable
            origin validation. Default is to allow localhost and <https://polkadot.js.org> origins. When running in
            --dev mode the default is to allow all origins.
        --rpc-http-threads <COUNT>                               
            Size of the RPC HTTP server thread pool

        --rpc-max-payload <rpc-max-payload>
            Set the the maximum RPC payload size for both requests and responses (both http and ws), in megabytes.
            Default is 15MiB
        --rpc-methods <METHOD SET>
            RPC methods to expose.
            
            - `Unsafe`: Exposes every RPC method.
            - `Safe`: Exposes only a safe subset of RPC methods, denying unsafe RPC methods.
            - `Auto`: Acts as `Safe` if RPC is served externally, e.g. when `--{rpc,ws}-external` is
              passed, otherwise acts as `Unsafe`. [default: Auto]  [possible values: Auto, Safe,
            Unsafe]
        --rpc-port <PORT>                                        
            Specify HTTP RPC server TCP port

        --state-cache-size <Bytes>                               
            Specify the state cache size [default: 67108864]

        --sync <SYNC_MODE>                                       
            Blockchain syncing mode.
            
            - `Full`: Download and validate full blockchain history.
            
            - `Fast`: Download blocks and the latest state only.
            
            - `FastUnsafe`: Same as `Fast`, but skip downloading state proofs. [default: Full]
        --telemetry-url <URL VERBOSITY>...                       
            The URL of the telemetry server to connect to.
            
            This flag can be passed multiple times as a means to specify multiple telemetry endpoints. Verbosity levels
            range from 0-9, with 0 denoting the least verbosity. Expected format is 'URL VERBOSITY', e.g. `--telemetry-
            url 'wss://foo/bar 0'`.
        --tracing-receiver <RECEIVER>
            Receiver to process tracing messages [default: Log]  [possible values: Log]

        --tracing-targets <TARGETS>
            Sets a custom profiling filter. Syntax is the same as for logging: <target>=<level>

        --wasm-execution <METHOD>
            Method for executing Wasm runtime code [default: Compiled]  [possible values: interpreted-i-know-
            what-i-do, compiled]
        --wasm-runtime-overrides <PATH>                          
            Specify the path where local WASM runtimes are stored.
            
            These runtimes will override on-chain runtimes when the version matches.
        --ws-max-connections <COUNT>                             
            Maximum number of WS RPC server connections

        --ws-port <PORT>                                         
            Specify WebSockets RPC server TCP port


ARGS:
    <relaychain-args>...    
            Relaychain arguments


SUBCOMMANDS:
    benchmark               Benchmark runtime pallets.
    build-spec              Build a chain specification
    check-block             Validate blocks
    export-blocks           Export blocks
    export-genesis-state    Export the genesis state of the parachain
    export-genesis-wasm     Export the genesis wasm of the parachain
    export-state            Export the state of a given block into a chain spec
    help                    Prints this message or the help of the given subcommand(s)
    import-blocks           Import blocks
    purge-chain             Remove the whole chain
    revert                  Revert the chain to a previous state
```
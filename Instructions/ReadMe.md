# Starting Demo and Rococo

In the directory called `ops/blockchain/chain-start-scripts` are a series of folders and files that will begin to execute the Polkadot Local Network (also known as Rococo Local) and the Demo network.

The lessons here are commonly applicable to all Totem's parachains.

## Directory Structure

* Inside `ops/blockchain/chain-start-scripts` there are folders named after the network:

> In this example we have two folders **_Demo_** and **_Rococo_**
> Demo folder contains the start scripts and directories for running a Totem Demo Testnet Parachain.

> FYI Rococo is the equivalent of the Polkadot Live Relaychain Network and Westend Public Test Relaychain Network. It also contains the relevant start scripts. To support the Westend and Polkadot networks we may need to run nodes, but it is optional.

* One level down from the network directory (`ops/blockchain/chain-start-scripts/demo` or `ops/blockchain/chain-start-scripts/rococo`) contains the execution scripts and folders that will be used for persistent stirage. 

> Each node has its own named storage. The blockchain database storage cannot be shared across nodes - hence there is one folder per node, named after the relevant node.

* If you inspect the node folder for persistent storage it contains a further two folders:

#### The genesis file folder

This is not optimal at the moment because it repeatedly contains the same files for each node (depending on if you are running Demo Parachain or Rococo Relaychain).

* In the case of **Demo Parachain** it contains two genesis files:
    
    * Relaychain genesis files - each is unique to the Relaychain network that is to be connected to:
        
        * rococo-local-totem.json (for demo)
        * westend.json (for wapex)
        * polkadot.json (for kapex)

    * Parachain genesis file - again each will be unique for the parachain network node that it will spawn
        
        *  demo-parachain-raw.json
        *  wapex-parachain-raw.json
        *  kapex-parachain-raw.json

The reason why the parachains conatin 2 files is because each parachain runs two nodes: a relaychain node and its own parachain node.

* In the case of **Rococo Relaychain** it contains one genesis file:
    
    * Relaychain genesis files - each is unique to the Relaychain network node that it will spawn:
        
        * rococo-local-totem.json (for demo)
        * westend.json (for wapex)
        * polkadot.json (for kapex)



#### The keystore folder contains the node specific keys.

This is only relevant if the node is going to be a bootnode, or a collator/validator node, otherwise it not mandatory to have these keys setup. Therefore only they are only seen in the startup scripts when they are applicable.

There are two folders in the keystore folder:

**1) auth-key folder**

This is only required for collator nodes. The file that is contained therein must be unique to the node, and must be named employing a specific naming convention:

* The first part of the name must contain the hex equivalent of `aura` i.e. `61757261` and this should be concatenated with the hex representation of the public key of the secret that this file contains dropping the `0x` prefix. For example:

Public key hex: `0xac49f26318fb86df0412aaa6ce69fee878fbf98f783af4654d53aec7bdb3472d`

becomes... 

Filename: `61757261ac49f26318fb86df0412aaa6ce69fee878fbf98f783af4654d53aec7bdb3472d`

The secret inside this file can be a 24 word seed phrase in double quotes [example do not use!]:

`"smooth piece machine garage cave smoke kite response cube piece ramp uphold believe symbol fury ramp swear share city host keen vanish purchase detect"`

**It must not contain a carriage return or line return character.**

**2) node-key folder**

This file does not have to employ a specific naming convention, but must contain a `Ed25519` secret in hex format dropping the `0x` prefix. 

**The secret must not be surrounded by double quotes and must not contain a carriage return or line return character.**

## Scripts

Under each network (Demo or Rococo) folder there are individual scripts for each node. Each network should be started byt starting the bootnodes first and also should be in the sequence Relaychain network then Parachain network as follows:

1) [start-auth1-rococo.sh](./chain-start-scripts/rococo/start-auth1-rococo.sh)

2) [start-auth2-rococo.sh](./chain-start-scripts/rococo/start-auth2-rococo.sh)

3) [start-boot1-demo.sh](./chain-start-scripts/demo/start-boot1-demo.sh)

4) [start-auth1-demo.sh](./chain-start-scripts/demo/start-auth1-demo.sh)

5) [start-auth2-demo.sh](./chain-start-scripts/demo/start-auth2-demo.sh)

6) [start-ui1-rococo.sh](./chain-start-scripts/rococo/start-ui1-rococo.sh)

7) [start-ui1-demo.sh](./chain-start-scripts/demo/start-ui1-demo.sh)

Note these scripts all reference the genesis files mentioned above, and the storage locations.

For WAPEX and KAPEX you can find the start scripts here:

### WAPEX

1) [start-boot1-wapex.sh](./chain-start-scripts/wapex/start-boot1-wapex.sh)

2) [start-auth1-wapex.sh](./chain-start-scripts/wapex/start-auth1-wapex.sh)

3) [start-auth2-wapex.sh](./chain-start-scripts/wapex/start-auth2-wapex.sh)

4) [start-ui1-wapex.sh](./chain-start-scripts/wapex/start-ui1-wapex.sh)

### KAPEX

#### Kapex Boot nodes

We have 3 boot nodes, the config is more or less the same, but ensure that the _node-keys_ are correct for each one.

1) [start-boot1-kapex.sh](./chain-start-scripts/kapex/start-boot1-kapex.sh)

The rest are as follows:

2) [start-auth1-kapex.sh](./chain-start-scripts/kapex/start-auth1-kapex.sh)

3) [start-auth2-kapex.sh](./chain-start-scripts/kapex/start-auth2-kapex.sh)

4) [start-ui1-kapex.sh](./chain-start-scripts/kapex/start-ui1-kapex.sh)

## Ports

These are the standard (default) ports for various use cases are explained below.

These ports can be mapped for execution on the same machine but there are some additional mappings and startup flags that need to be considered when optional ports are used.

**1) `30333/tcp` libp2p port (default mandatory open)**
This is the port that a node will search for peers on. By default it must be open.

You can optionally specify your own port with `--port <port>`.

**2) `9944` websocket (default optionally open)**
This is used to allow the node to be connected to by a UI. It must be combined with `--ws-external` flag to function correctly.

You can optionally specify your own port with `--ws-port <port>`.

**3) `9933 http rpc` (default optionally open with ad-hoc usage (on then off again))**
This exposes additional functionality that cannot be accessed via the websocket connection. It is only really relevant for use with validator/collator nodes so that node-specific instructions can be sent on the command-line.

This must be combined with `--rpc-cors=all`and `--rpc-methods=unsafe`.

You can optionally specify your own port with `--rpc-port <port>`.

**1) `9615` Prometheus (default)**
For monitoring the node.

#### Additional ports for parachain execution

When executing a Relaychain node, the above mentioned port configuration is sufficient, however when executing a Parachain node (which contains a lightweight Relaychain node), additional ports should also be used.

In the Totem docker images the standard ports above refer to the Parachain, whereas the following ports refer to the Relaychain.

1) 40333/tcp libp2p port (default mandatory open)
2) 9945	websocket
3) 9934	http rpc
4) 9616	Prometheus

The same additional flags and optional settings also apply.

## NGINX

The current test setup is running on one VPS server running docker containers and two node that support UI connection, and therefore we have employed an nginx reverse proxy.

This is only necessary because we are running both UI nodes and boot nodes.

#### Websockets

The websocket setup here does not employ certificates however in the live version **_must use certificates_** so that certain remote UI and javascript libraries can connect.

UI nodes require websockets with valid certificates being served with connections, so that the normal `ws://` protocol can be upgraded to secure websockets `wss://` protocol. UIs and remote connections cannot connect without this being in place. 

#### Domains

In both the case of UI nodes and boot nodes, these are best set up with a known domain name, but the boot nodes do not need certificates.

We would not need to run an `nginx reverse proxy` if we were just running vanilla nodes or collator/validator nodes on the same machine.

#### Note on latency for validator nodes behind nginx

> _According to the [Polkadot documentation](https://wiki.polkadot.network/docs/maintain-guides-how-to-setup-a-validator-with-reverse-proxy) validator or collator nodes, should not run behind a reverse proxy due to latency issues which may cause the node to be penalised._

If it is absolutely necessary to run a reverse proxy the above is somewhat mitigated by employing `nginx streams-enabled` setup which is what has been done in the `demo` test environment that is currently running.

We implemented three config files. This is an exhaustive setp for all the ports that _could_ be used. In reality only _some_ of these ports were used:

1) [nginx.conf](./nginx.conf)
2) [nginx-streams.conf](./nginx-streams.conf)
3) [nginx-sites.conf](./nginx-sites.conf)

## Firewall Ports

We have used `UFW` an only opened the ports that are required by the scripts. We have not opened all the ports in the `nginx` setup.

## Polkadot catchup and sync.

To start a parachain it must be syncronised with the Relaychain it is connecting to before it can produce blocks. Therefore we will need to start the parachain nodes far ahead of actual operation in order to syncronize with the Polkadot (or Westent) networks. See the [docs](https://wiki.polkadot.network/docs/maintain-guides-how-to-validate-kusama#synchronize-chain-data).

According to other teams we may need in excess of 100Gib per Parachain Collator. There does not appear to be any reason why the Polkadot node inside a parachain needs to run as a full archive node.
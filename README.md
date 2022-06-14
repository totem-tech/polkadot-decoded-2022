# Workshop : Prepare your Parachain for Production

### Polkadot Decoded NYC 2022

**Speaker: Chris D’Costa - Totem Kapex Parachain Founder**

## Preamble
The workshop is designed for intermediate level Substrate/parachain developers and above. It is based around a checklist of tasks to get prepare your Parachain node and network ready for Polkadot or Kusama, supported by working examples for participants.

It is assumed that the participants are developers and already have 

* a Parachain close to deployment 

* they have already tested and benchmarked the pallets that they wish to include. 

> This workshop is not intended to do development, but instead focus on the next-steps to production as a heads-up for the tasks involved.

For the demonstration part of the workshop we will rely on this repository with code and various scripts that we have used at Totem as well as providing a supporting docker image from Dockerhub that will be used in the workshop.

Participants will not be expected to compile code but should have access to a VPS or laptop if they wish to follow along. Docker, nginx, yarn and Certbot should be installed and UFW or similar firewalls should be employed. 

If developers wish to use Polkadotjs apps locally on their own machine (to provide a UI into their UI node) the requisite code and dependencies should be installed before the workshop.

The workshop will focus on understanding the “how” and more importantly the “why” of the steps. 

## Workshop
The workshop is split into 6 sections:

### 1. Introduction and basic requirements - 5 mins.

- [ ] Prerequisites (docker, nginx, yarn, cerbot etc…).

- [ ] Sizing your platform.

- [ ] Setting up the directory structure for persistent data.

- [ ] Where to find the code and scripts.

- [ ] Using Subkey.

- [ ] What key types you need, why and where to use them.

- [ ] Creating the keys.

### 2. Parachain specifics - 5 mins.

- [ ] When to regenerate WASM blob and Genesis States how & why.

- [ ] Setting up your code base for convenience and utility.

- [ ] Creating multiple parachain types from the same code-base.

- [ ] Preparing your container.
* e.g. Running a parachain without a separate chain-spec file etc….
* Don’t forget Sudo.

### 3. Infrastructure - 15 mins.

- [ ] Deal with setting up a pre-production environment:.

- [ ] Parachain Node types:.

* Boot-node(s).

* Collator-node(s).

* UI-node(s).

- [ ] Traffic consideration.

- [ ] Relaychain Node types:.

- [ ] Bootnode.

- [ ] Validator Node.

- [ ] UI Node.

- [ ] Connectivity:.

- [ ] Nginx configuration.

- [ ] Tracking host and nginx port mappings.

- [ ] Usefulness of a domain-name.

- [ ] Secure websockets on UI nodes.

- [ ] Certbot.

- [ ] ufw.

### 4. UI Node Integration with Polkadotjs Apps - 5 mins.

- [ ] SS58 address type.

- [ ] Adding UI end points.

- [ ] Configuring branding.

### 5. Deployment - 5 mins.

- [ ] Monitoring.

- [ ] Telemetry.

- [ ] Stop/start/restart.

- [ ] Upgrade parachain network.

### 6. Checklist recap & QA - 5 mins.
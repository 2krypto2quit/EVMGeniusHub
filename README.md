## Foundry

**Foundry is a blazing fast, portable and modular toolkit for Ethereum application development written in Rust.**

Foundry consists of:

-   **Forge**: Ethereum testing framework (like Truffle, Hardhat and DappTools).
-   **Cast**: Swiss army knife for interacting with EVM smart contracts, sending transactions and getting chain data.
-   **Anvil**: Local Ethereum node, akin to Ganache, Hardhat Network.
-   **Chisel**: Fast, utilitarian, and verbose solidity REPL.

## Documentation

https://book.getfoundry.sh/

## Usage

### Build

```shell
$ forge build
```

### Test

```shell
$ forge test
```

### Format

```shell
$ forge fmt
```

### Gas Snapshots

```shell
$ forge snapshot
```

### Anvil

```shell
$ anvil
```

### Deploy

```shell
$ forge script script/Counter.s.sol:CounterScript --rpc-url <your_rpc_url> --private-key <your_private_key>
```

### Cast

```shell
$ cast <subcommand>
```

### Help

```shell
$ forge --help
$ anvil --help
$ cast --help



###Deploy: forge create 'path0x5fbdb2315678afecb367f032d93f642f64180aa3-to-contract-file:smart-contract-name' --rpc-url `RPC_URL` --private-key 'PRIVATE_KEY'


###forge create ./src/Counter.sol:Counter --rpc-url 127.0.0.1:8545 --private-key 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80

###Read: cast call 'SMART_CONTRACT_ADDRESS' "function(params)(output_params/return value)" --rpc-url 'RPC_URL'

###cast call 0x5fbdb2315678afecb367f032d93f642f64180aa3 "number()(uint256)" --rpc-url 127.0.0.1:8545

###Write: cast send 'SMART_CONTRACT_ADDRESS' "function(params)(output_params)" "params" --rpc-url 'RPC_URL' --private-key 'PRIVATE_KEY'

###cast send 0x5fbdb2315678afecb367f032d93f642f64180aa3 "setNumber(uint256)" "17042024" --rpc-url 127.0.0.1:8545 --private-key 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80

###cast send 0x5fbdb2315678afecb367f032d93f642f64180aa3 "increment()" --rpc-url 127.0.0.1:8545 --private-key 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80

###Examples:

###forge create ./src/Counter.sol:Counter --rpc-url 127.0.0.1:8545 --private-key 'PRIVATE_KEY'
###cast send 'SMART_CONTRACT_ADDRESS' "setNumber(uint256)" "17042024" --rpc-url 127.0.0.1:8545 --private-key 'PRIVATE_KEY'
###cast send 'SMART_CONTRACT_ADDRESS' "increment()" --rpc-url 127.0.0.1:8545 --private-key 'PRIVATE_KEY'
###cast call 'SMART_CONTRACT_ADDRESS' "number()(uint256)" --rpc-url 127.0.0.1:8545

###Forge is the Ethereum development and testing framework.

###Cast is a CLI that allows you to interact with EVM smart contracts, send transactions, and read data from the network.

###Anvil is a local Ethereum node, similar to Ganache or Hardhat node.



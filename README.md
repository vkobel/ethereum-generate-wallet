# Ethereum wallet generator
Simple script collection, currently in bash and python format, to generate a complete offline Ethereum wallet by creating an ECDSA keypair and derive its Ethereum address.

You can read my article about it here: https://kobl.one/blog/create-full-ethereum-keypair-and-address/

**IMPORTANT** The python version of this script has been updated to support mixed-case checksum address encoding through [EIP55](https://github.com/ethereum/EIPs/blob/master/EIPS/eip-55.md).

## Docker Example
```bash
docker run deanshelton913/ethereum-wallet-keygen:latest
# {"private": "f208...", "public": "b0831...", "address": "0x76....."}
```
```bash
# write to a file for other apps to read in later
docker run deanshelton913/ethereum-wallet-keygen:latest > ./ethereum.json
```



## Python dependencies
- ECDSA https://pypi.python.org/pypi/ecdsa
- pysha3 https://pypi.python.org/pypi/pysha3

You can also use the included requirements.txt file to install them
```bash
pip install -r requirements.txt
```

## Bash dependencies
- OpenSSL
- SHA3sum (keccak-256sum) https://github.com/maandree/sha3sum

*Compiled, statically linked versions of the keccak-256sum executable are available in the lib folder of this repo for i386 and x86_64.*

## Importing private key to geth
You can use the generated private key to import in to geth (https://github.com/ethereum/go-ethereum).
```bash
# First save the private hexadecimal key to a file
echo eff415edb6331f4f67bdb7f1ecc639da9bcc0550b100bb275c7b5b21ce3a7804 > key
# Then use account import feature of geth (here importing in the 'testnet' directory)
./go-ethereum/build/bin/geth --datadir ~/.ethereum/testnet account import key
```
Note that geth will ask you immediately to choose a passphrase to protect the newly imported key.

## Example
```bash
./ethereum-wallet-generator.py
Private key: 981679905857953c9a21e1807aab1b897a395ea0c5c96b32794ccb999a3cd781
Public key:  7454f003941bba7c5e16d8c9fce19104b2f51486e00d47f39e6eb0aea6f1c6f80cad2d239c8b4b1bf903e41960920f735fda4fcc4422aa815416b7d0df62f8a5
Address:     0x5fe3062B24033113fbf52b2b75882890D7d8CA54
```

```bash
./ethereum-wallet-generator.sh
Private key: 9442b4b82c8011530f3a363cc87a4ea91efd53552faab2e63fd352db9367bb24
Public key:  3f538de115393e2a8851b4c19f686b6bb245213c3823e69336583f1d72c53d20831ea0574900b31d833932b3e8e71b4e99d574c6480890d60153fc2dccbc96d6
Address:     0x083c41ea13af6c2d5aaddf6e73142eb9a7b00183
```


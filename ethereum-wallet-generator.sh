#!/bin/sh
keys=$(openssl ecparam -name secp256k1 -genkey -noout | openssl ec -text -noout 2> /dev/null)

# extract private key in hex format, removing newlines, leading zeroes and semicolon 
priv=$(printf "%s\n" $keys | grep priv -A 3 | tail -n +2 | tr -d '\n' | sed 's/^00//; s/://g')

# extract public key in hex format, removing newlines, leading '04' and semicolon 
pub=$(printf "%s\n" $keys | grep pub -A 5 | tail -n +2 | tr -d '\n' | sed 's/^04//; s/://g')

# get the keecak hash, removing the trailing ' -' and taking the last 40 chars
# https://github.com/maandree/sha3sum
addr=0x$(echo $pub | keccak-256sum -x -l | tr -d ' -' | tail -c 41) 

echo 'Private key:' $priv
echo 'Public key: ' $pub 
echo 'Address:    ' $addr 


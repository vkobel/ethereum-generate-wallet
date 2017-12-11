#!/usr/bin/python3

# pip install ecdsa
# pip install pysha3

from ecdsa import SigningKey, SECP256k1
import sha3

keccak = sha3.keccak_256()

priv = SigningKey.generate(curve=SECP256k1)
pub = priv.get_verifying_key().to_string()

keccak.update(pub)
address = keccak.hexdigest()[24:]

print("Private key:", priv.to_string().hex())
print("Public key: ", pub.hex())
print("Address:     0x" + address)

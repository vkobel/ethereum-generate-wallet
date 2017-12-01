#!/bin/sh

if [ `getconf LONG_BIT` = "64" ]
then
	arch="x86-64"
else
	arch="i386"
fi

echo "# Ethereum Wallet Generator"
echo "# How many keypairs would you like to generate? (type in the number you would like, e.g '5' will generate 5 keypairs.)"

read keysAmount

if [ "$keysAmount" -eq "$keysAmount" ] 2>/dev/null; then #this checks if input is numeric
	if [ $keysAmount -eq "0" ]; then
		echo "# You typed in 0. Will exit now.";
	else
		echo "# You typed in: $keysAmount, will generate those now.";
		echo "# Format of the output is: PRIVATE KEY;PUBLIC KEY;ADDRESS";
		for i in $( seq 0 $keysAmount )
			do
				keys=$(openssl ecparam -name secp256k1 -genkey -noout | openssl ec -text -noout 2> /dev/null)

				# extract private key in hex format, removing newlines, leading zeroes and semicolon
				priv=$(printf "%s\n" $keys | grep priv -A 3 | tail -n +2 | tr -d '\n[:space:]:' | sed 's/^00//')

				# extract public key in hex format, removing newlines, leading '04' and semicolon
				pub=$(printf "%s\n" $keys | grep pub -A 5 | tail -n +2 | tr -d '\n[:space:]:' | sed 's/^04//')

				# get the keecak hash, removing the trailing ' -' and taking the last 40 chars
				# https://github.com/maandree/sha3sum
				addr=0x$(echo $pub | lib/$arch/keccak-256sum -x -l | tr -d ' -' | tail -c 41)
				
				echo "$priv;$pub;$addr";
			done
	fi
else
	echo not a number;
fi



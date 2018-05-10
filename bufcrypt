#!/bin/bash

function encrypt(){
    echo $(aws kms encrypt --key-id alias/encrypter --plaintext "$1" --output text --query CiphertextBlob)
}

function decrypt(){
    echo "$1" | base64 --decode > awsencrypteddata.temp
    OLDIFS=$IFS
    IFS=
    echo $(aws kms decrypt --ciphertext-blob fileb://awsencrypteddata.temp --output text --query Plaintext | base64 --decode)
    IFS=$OLDIFS
    rm awsencrypteddata.temp
}

function encryptfile(){
    echo $(aws kms encrypt --key-id alias/encrypter --plaintext fileb://"$1" --output text --query CiphertextBlob)
}

function help(){
    printf "
A utility to encrypt sensitive information that we might need to paste
in sensitive locations.

Usage: bufcrypt COMMAND \"input\"

Commands:

  encrypt                 Use this to encrypt text directly via terminal.
                          Supports multi line strings
  decrypt                 Use this to decrypt encrypted text. Paste the encrypted
                          text inside quotes
  encryptfile             Encrypt the contents of a file using this.

Examples:

Encrypt single line text:
bufcrypt encrypt \"senstive info goes here\"

Encrypt multi line text:
bufcrypt encrypt \"my sensitive info
goes
on multiple lines\"

Decrypt
bufcrypt decrypt \"ciphertexttodecrypt\"

Encrypt a file
bufcrypt encryptfile \"~/.aws/credentials.backup\"
"
}

$1 "$2"

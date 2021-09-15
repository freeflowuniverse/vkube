#!/bin/sh
set -e

if [ -z $1 ]; then
    echo "Missing k3s.yaml"
    exit 1
fi

config=$1

if ! grep -q apiVersion $config; then
    echo "Wrong config file"
    exit 1
fi

rootca=$(grep certificate-authority-data $config | awk '{ print $2 }')
cert=$(grep client-certificate-data $config | awk '{ print $2 }')
key=$(grep client-key-data $config | awk '{ print $2 }')

echo "rootca := \"$rootca\""
echo "cert := \"$cert\""
echo "key := \"$key\""

#!/bin/bash

#Development on localhost
openssl req -x509 -out ./data/certs/localhost.crt -keyout ./data/certs/localhost.key \
  -newkey rsa:2048 -nodes -sha256 \
  -subj '/CN=localhost' -extensions EXT -config <( \
   printf "[dn]\nCN=localhost\n[req]\ndistinguished_name = dn\n[EXT]\nsubjectAltName=DNS:localhost\nkeyUsage=digitalSignature\nextendedKeyUsage=serverAuth")
   
   
#Development with .local 
openssl req -x509 -out ./data/certs/local.crt -keyout ./data/certs/local.key \
  -newkey rsa:2048 -nodes -sha256 \
  -subj '/CN=local' -extensions EXT -config <( \
   printf "[dn]\nCN=local\n[req]\ndistinguished_name = dn\n[EXT]\nsubjectAltName=DNS:local\nkeyUsage=digitalSignature\nextendedKeyUsage=serverAuth")
   

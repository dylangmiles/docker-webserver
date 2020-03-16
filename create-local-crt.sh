#!/bin/bash

#Development on localhost
openssl req -x509 -out ./data/certs/localhost.crt -keyout ./data/certs/localhost.key \
  -newkey rsa:2048 -nodes -sha256 \
  -days 999 \
  -subj '/CN=localhost' -extensions EXT -config <( \
   printf "[dn]\nCN=localhost\n[req]\ndistinguished_name = dn\n[EXT]\nsubjectAltName=DNS:localhost\nkeyUsage=digitalSignature\nextendedKeyUsage=serverAuth")
   
   
#Development with .local 
openssl req -x509 -out ./data/certs/local.crt -keyout ./data/certs/local.key \
  -newkey rsa:2048 -nodes -sha256 \
  -days 999 \
  -subj '/CN=local' -extensions EXT -config <( \
   printf "[dn]\nCN=local\n[req]\ndistinguished_name = dn\n[EXT]\nsubjectAltName=DNS:local\nkeyUsage=digitalSignature\nextendedKeyUsage=serverAuth")
   
   
   
openssl req -x509 -out ./data/certs/account.comra-therapy.com.crt -keyout ./data/certs/account.comra-therapy.com.key \
  -newkey rsa:2048 -nodes -sha256 \
  -days 999 \
  -subj '/CN=account.comra-therapy.com' -extensions EXT -config <( \
   printf "[dn]\nCN=account.comra-therapy.com\n[req]\ndistinguished_name = dn\n[EXT]\nsubjectAltName=DNS:account.comra-therapy.com\nkeyUsage=digitalSignature\nextendedKeyUsage=serverAuth")
   
   
openssl req -x509 -out ./data/certs/blog.comra-palm.com.crt -keyout ./data/certs/blog.comra-palm.com.key \
  -newkey rsa:2048 -nodes -sha256 \
  -days 999 \
  -subj '/CN=blog.comra-palm.com' -extensions EXT -config <( \
   printf "[dn]\nCN=blog.comra-palm.com\n[req]\ndistinguished_name = dn\n[EXT]\nsubjectAltName=DNS:blog.comra-palm.com\nkeyUsage=digitalSignature\nextendedKeyUsage=serverAuth")      
   

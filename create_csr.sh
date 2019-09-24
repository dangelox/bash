#!/bin/bash 

###################################################################
#Script Name	: create_csr.sh
#Description	: Creates CSR with given CSR filename command line
#                 arguments
#Args           : CSR filename
#Author       	: Dilesh Fernando
#Email         	: fernando.dilesh@gmail.com
###################################################################

# Check command line arguments
if [ "$#" -ne 1 ]; then
    echo "Illegal number of parameters"
    exit 1
fi

# Generate RSA 2048 private key
echo "Generate RSA 2048 private key"
openssl genrsa -out private.key 2048

# Create a CSR
openssl req -new -key private.key -out $1

# Print CSR in text
openssl req -in $1 -noout -text
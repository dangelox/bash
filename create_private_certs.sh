#!/bin/bash 

###################################################################
#Script Name	: create_private_certs.sh                                                                                             
#Description	: Create private CA for test purposes. Script will
				  create CA, server, and client certificates.	                                                                                
#Args           : None.                                                                                           
#Author       	: Dilesh Fernando                                                
#Email         	: fernando.dilesh@gmail.com                                           
###################################################################

# Create the CA Key and Certificate for signing Client Certs
echo "Create the CA Key and Certificate"
openssl genrsa -des3 -out ca.key 4096
openssl req -new -x509 -days 365 -key ca.key -out ca.crt

# Create the Server Key, CSR, and Certificate
echo "Create the Server Key, CSR, and Certificate"
openssl genrsa -des3 -out server.key 1024
openssl req -new -key server.key -out server.csr

# We're self signing our own server cert here.  This is a no-no in production.
openssl x509 -req -days 365 -in server.csr -CA ca.crt -CAkey ca.key -set_serial 01 -out server.crt
echo "Server certificate done."

# Create the Client Key and CSR
echo "Create the Client Key and CSR"
openssl genrsa -des3 -out client.key 1024
openssl req -new -key client.key -out client.csr

# Sign the client certificate with our CA cert.  Unlike signing our own server cert, this is what we want to do.
openssl x509 -req -days 365 -in client.csr -CA ca.crt -CAkey ca.key -set_serial 01 -out client.crt
echo "Client certificate done."

# Print all certificates to console
openssl x509 -in ca.crt -text -noout
openssl x509 -in server.crt -text -noout
openssl x509 -in client.crt -text -noout

echo "All done!"


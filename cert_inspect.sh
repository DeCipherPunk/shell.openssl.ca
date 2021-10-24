#!/bin/sh
if [ -n "$CA_NAME" ]; then 
    openssl x509 \
        --in $CA_NAME.pem \
        -text \
        --noout

else 
    echo "Please provide information for CA";
    read -p "Enter Certificate Authority Name (for ex. mytestorg): " CA_NAME 
    if [ -n "$CA_NAME" ]; then 
    openssl x509 \
        --in $CA_NAME.pem \
        -text \
        --noout
    
    else
        echo "input missing, please try again"
    fi;    
fi;


#!/bin/sh

if [ -n "$CA_NAME"   -a -n "$CA_PASS" -a -n "$CA_VALIDITY" -a -n "$CA_COUNTRY" -a -n "$CA_STATE" -a -n "$CA_LOCATION" -a -n "$CA_ORG" ]; then 
    if [ -d "$CA_NAME" ]; then
        echo "CA Already exists"
    else
        mkdir -p $CA_NAME/CA/ $CA_NAME/SERVERS/ $CA_NAME/CLIENTS
        openssl genrsa -des3 -out $CA_NAME/CA/$CA_NAME.key  -passout pass:$CA_PASS 4096; 
        openssl req -x509 -new -nodes -key $CA_NAME/CA/$CA_NAME.key \
            -sha256 -days $CA_VALIDITY -out $CA_NAME/CA/$CA_NAME.pem \
            -subj "/C=$CA_COUNTRY/ST=$CA_STATE/L=$CA_LOCATION/O=$CA_ORG/CN=$CA_NAME" -passin pass:$CA_PASS
    fi
else 
    echo "Please provide information for CA";
    read -p "Enter Certificate Authority Name (for ex. mytestorg): " CA_NAME 
    echo -n Password: 
    read  CA_PASS
    read -p "CA_VALIDITY: (in no of days, for ex: 365 ) " CA_VALIDITY
    read -p "CA_COUNTRY: (for ex: US) " CA_COUNTRY
    read -p "CA_STATE: (for ex: Texas) " CA_STATE
    read -p "CA_LOCATION: (for ex: your location) " CA_LOCATION
    read -p "CA_ORG: (for ex: your organization) " CA_ORG
    if [ -n "$CA_NAME"   -a -n "$CA_PASS" -a -n "$CA_VALIDITY" -a -n "$CA_COUNTRY" -a -n "$CA_STATE" -a -n "$CA_LOCATION" -a -n "$CA_ORG" -a -n "$CA_NAME" ]; then 
        if [ -d "$CA_NAME" ]; then
            echo "CA Already exists"
        else
            mkdir -p $CA_NAME/CA/ $CA_NAME/SERVERS/ $CA_NAME/CLIENTS
            openssl genrsa -des3 -out $CA_NAME/CA/$CA_NAME.key  -passout pass:$CA_PASS 4096; 
            openssl req -x509 -new -nodes -key $CA_NAME/CA/$CA_NAME.key \
                -sha256 -days $CA_VALIDITY -out $CA_NAME/CA/$CA_NAME.pem \
                -subj "/C=$CA_COUNTRY/ST=$CA_STATE/L=$CA_LOCATION/O=$CA_ORG/CN=$CA_NAME" -passin pass:$CA_PASS
        fi
    else
        echo "input missing, please try again"
    fi;    
fi;

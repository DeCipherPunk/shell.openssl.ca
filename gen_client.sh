if [ -n "$CA_NAME" -a -n   "$CA_PASS" -a -n "$CLIENT_NAME"   -a -n "$CLIENT_PASS" -a -n "$CLIENT_VALIDITY" -a -n "$CLIENT_COUNTRY" -a -n "$CLIENT_STATE" -a -n "$CLIENT_LOCATION" -a -n "$CLIENT_ORG" -a -n "$CLIENT_COMMON_NAME" ]; then 
    openssl genrsa -des3 -out $CA_NAME/CLIENTS/$CLIENT_NAME.key  -passout pass:$CLIENT_PASS 4096; 
    openssl req \
        -new \
        -key $CA_NAME/CLIENTS/$CLIENT_NAME.key \
        -subj "/C=$CLIENT_COUNTRY/ST=$CLIENT_STATE/L=$CLIENT_LOCATION/O=$CLIENT_ORG/CN=$CLIENT_COMMON_NAME" \
        -out $CA_NAME/CLIENTS/$CLIENT_NAME.csr -passin pass:$CLIENT_PASS    
    
    openssl x509 \
        -req \
        -in $CA_NAME/CLIENTS/$CLIENT_NAME.csr \
        -CA $CA_NAME/CA/$CA_NAME.pem \
        -CAkey $CA_NAME/CA/$CA_NAME.key \
        -CAcreateserial \
        -days $CLIENT_VALIDITY \
        -out $CA_NAME/CLIENTS/$CLIENT_NAME.pem -passin pass:$CA_PASS

else 
    echo "Please provide information for CLIENT";
    read -p "Enter Certificate Authority Name (for ex. mytestorg): " CA_NAME 
    read -p "Enter CLIENT Name (for ex. bob): " CLIENT_NAME 
    echo -n CLIENT Password: 
    read  CLIENT_PASS
    echo -n CA Password: 
    read  CA_PASS
    read -p "CLIENT_VALIDITY: (in no of days, for ex: 365 ) " CLIENT_VALIDITY
    read -p "CLIENT_COUNTRY: (for ex: US) " CLIENT_COUNTRY
    read -p "CLIENT_STATE: (for ex: Texas) " CLIENT_STATE
    read -p "CLIENT_LOCATION: (for ex: your location) " CLIENT_LOCATION
    read -p "CLIENT_ORG: (for ex: your organization) " CLIENT_ORG 
    read -p "CLIENT_COMMON_NAME: (for ex: localhost) " CLIENT_COMMON_NAME
    if [ -n "$CA_NAME" -a -n "$CLIENT_NAME"   -a -n "$CLIENT_PASS" -a -n "$CLIENT_VALIDITY" -a -n "$CLIENT_COUNTRY" -a -n "$CLIENT_STATE" -a -n "$CLIENT_LOCATION" -a -n "$CLIENT_ORG" -a -n "$CLIENT_COMMON_NAME" ]; then 
    openssl genrsa -des3 -out $CA_NAME/CLIENTS/$CLIENT_NAME.key  -passout pass:$CLIENT_PASS 4096; 
    openssl req \
        -new \
        -key $CA_NAME/CLIENTS/$CLIENT_NAME.key \
        -subj "/C=$CLIENT_COUNTRY/ST=$CLIENT_STATE/L=$CLIENT_LOCATION/O=$CLIENT_ORG/CN=$CLIENT_COMMON_NAME" \
        -out $CA_NAME/CLIENTS/$CLIENT_NAME.csr -passin pass:$CLIENT_PASS    
    
    openssl x509 \
        -req \
        -in $CA_NAME/CLIENTS/$CLIENT_NAME.csr \
        -CA $CA_NAME/CA/$CA_NAME.pem \
        -CAkey $CA_NAME/CA/$CA_NAME.key \
        -CAcreateserial \
        -days $CLIENT_VALIDITY \
        -out $CA_NAME/CLIENTS/$CLIENT_NAME.pem -passin pass:$CA_PASS

    else
        echo "input missing, please try again"
    fi;    
fi;

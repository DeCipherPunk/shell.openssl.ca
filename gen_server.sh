if [ -n "$CA_NAME" -a -n   "$CA_PASS" -a -n "$SERVER_NAME"   -a -n "$SERVER_PASS" -a -n "$SERVER_VALIDITY" -a -n "$SERVER_COUNTRY" -a -n "$SERVER_STATE" -a -n "$SERVER_LOCATION" -a -n "$SERVER_ORG" -a -n "$SERVER_COMMON_NAME" ]; then 
    openssl genrsa -des3 -out $CA_NAME/SERVERS/$SERVER_NAME.key  -passout pass:$SERVER_PASS 4096; 
    openssl req \
        -new \
        -key $CA_NAME/SERVERS/$SERVER_NAME.key \
        -subj "/C=$SERVER_COUNTRY/ST=$SERVER_STATE/L=$SERVER_LOCATION/O=$SERVER_ORG/CN=$SERVER_COMMON_NAME" \
        -out $CA_NAME/SERVERS/$SERVER_NAME.csr -passin pass:$SERVER_PASS    
    
    openssl x509 \
        -req \
        -in $CA_NAME/SERVERS/$SERVER_NAME.csr \
        -CA $CA_NAME/CA/$CA_NAME.pem \
        -CAkey $CA_NAME/CA/$CA_NAME.key \
        -CAcreateserial \
        -days $SERVER_VALIDITY \
        -out $CA_NAME/SERVERS/$SERVER_NAME.pem -passin pass:$CA_PASS

else 
    echo "Please provide information for Server";
    read -p "Enter Certificate Authority Name (for ex. mytestorg): " CA_NAME 
    read -p "Enter server Name (for ex. dev.local): " SERVER_NAME 
    echo -n Server Password: 
    read  SERVER_PASS
    echo -n CA Password: 
    read  CA_PASS
    read -p "SERVER_VALIDITY: (in no of days, for ex: 365 ) " SERVER_VALIDITY
    read -p "SERVER_COUNTRY: (for ex: US) " SERVER_COUNTRY
    read -p "SERVER_STATE: (for ex: Texas) " SERVER_STATE
    read -p "SERVER_LOCATION: (for ex: your location) " SERVER_LOCATION
    read -p "SERVER_ORG: (for ex: your organization) " SERVER_ORG 
    read -p "SERVER_COMMON_NAME: (for ex: localhost) " SERVER_COMMON_NAME
    if [ -n "$CA_NAME" -a -n "$SERVER_NAME"   -a -n "$SERVER_PASS" -a -n "$SERVER_VALIDITY" -a -n "$SERVER_COUNTRY" -a -n "$SERVER_STATE" -a -n "$SERVER_LOCATION" -a -n "$SERVER_ORG" -a -n "$SERVER_COMMON_NAME" ]; then 
    openssl genrsa -des3 -out $CA_NAME/SERVERS/$SERVER_NAME.key  -passout pass:$SERVER_PASS 4096; 
    openssl req \
        -new \
        -key $CA_NAME/SERVERS/$SERVER_NAME.key \
        -subj "/C=$SERVER_COUNTRY/ST=$SERVER_STATE/L=$SERVER_LOCATION/O=$SERVER_ORG/CN=$SERVER_COMMON_NAME" \
        -out $CA_NAME/SERVERS/$SERVER_NAME.csr -passin pass:$SERVER_PASS    
    
    openssl x509 \
        -req \
        -in $CA_NAME/SERVERS/$SERVER_NAME.csr \
        -CA $CA_NAME/CA/$CA_NAME.pem \
        -CAkey $CA_NAME/CA/$CA_NAME.key \
        -CAcreateserial \
        -days $SERVER_VALIDITY \
        -out $CA_NAME/SERVERS/$SERVER_NAME.pem -passin pass:$CA_PASS

    else
        echo "input missing, please try again"
    fi;    
fi;

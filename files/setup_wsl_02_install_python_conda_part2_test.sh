echo "test variable env"


if [ -z "${REQUESTS_CA_BUNDLE}" ]; then 
tee -a ~/.bashrc << EOF
export REQUESTS_CA_BUNDLE=/etc/ssl/certs/ca-certificates.crt
EOF
fi


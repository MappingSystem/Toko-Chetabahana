FROM google/cloud-sdk:alpine
COPY test-kms.sh /test-kms.sh
ENTRYPOINT ["sh", "test-kms.sh"]

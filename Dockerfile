FROM google/cloud-sdk:alpine
ENTRYPOINT ["sh", "scripts/cloud_builder.sh"]

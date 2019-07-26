FROM google/cloud-sdk:alpine
COPY ./scripts/cloud_builder.sh /cloud_builder.sh
ENTRYPOINT ["sh", "cloud_builder.sh"]

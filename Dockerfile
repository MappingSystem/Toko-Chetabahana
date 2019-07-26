FROM google/cloud-sdk:alpine

VOLUME /scripts
COPY ./scripts/cloud_builder.sh /scripts/cloud_builder.sh

ENTRYPOINT ["sh", "scripts/cloud_builder.sh"]

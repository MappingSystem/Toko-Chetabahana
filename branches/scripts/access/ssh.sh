#!/bin/sh
: <<'END'
To use your SSH key with Cloud Build, you must use a Cloud KMS CryptoKey:
https://cloud.google.com/cloud-build/docs/access-private-github-repos

Enable KMS API
https://console.cloud.google.com/flows/enableapi?apiid=cloudkms.googleapis.com

KEY_NAME=github-key
KEYRING_NAME=my-keyring
SERVICE_ACCOUNT=792657441134

$ gcloud kms keyrings create my-keyring \
--location=global
$ gcloud kms keys create $KEY_NAME \
--location=global --keyring=$KEYRING_NAME --purpose=encryption
$ gcloud kms encrypt --plaintext-file=$HOME/.ssh/id_rsa \
--ciphertext-file=$HOME/.ssh/id_rsa.enc \
--location=global --keyring=$KEYRING_NAME --key=github-key

Grant the Cloud Build service account permission to access and decrypt the CryptoKey during the build.
$ gcloud kms keys add-iam-policy-binding \
    $KEY_NAME --location=global --keyring=$KEYRING_NAME \
    --member=serviceAccount:$SERVICE_ACCOUNT@cloudbuild.gserviceaccount.com \
    --role=roles/cloudkms.cryptoKeyDecrypter
Updated IAM policy for key [github-key].
bindings:
- members:
  - serviceAccount:792657441134@cloudbuild.gserviceaccount.com
  role: roles/cloudkms.cryptoKeyDecrypter
etag: BwWLmz5ANcY=
version: 1
END

cd /workspace/home/chetabahana
mv -f .gitconfig .transifexrc -t $HOME

cd /workspace/home/chetabahana/.ssh
mv -f config agent_builder known_hosts -t /root/.ssh
chmod 600 /root/.ssh/*

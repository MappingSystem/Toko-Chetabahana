#!/bin/sh
: <<'END'
To use your SSH key with Cloud Build, you must use a Cloud KMS CryptoKey:
https://cloud.google.com/cloud-build/docs/access-private-github-repos

Enable KMS API
https://console.cloud.google.com/flows/enableapi?apiid=cloudkms.googleapis.com

KEY_NAME=github-key
FILE_NAME=id_rsa
KEYRING_NAME=my-keyring
SERVICE_ACCOUNT=792657441134

$ gcloud kms keyrings create my-keyring \
--location=global
$ gcloud kms keys create $KEY_NAME \
--location=global --keyring=$KEYRING_NAME --purpose=encryption
$ gcloud kms encrypt --plaintext-file=$HOME/.ssh/$FILE_NAME \
--ciphertext-file=$HOME/.ssh/$FILE_NAME.enc \
--location=global --keyring=$KEYRING_NAME --key=$KEY_NAME

Grant the Cloud Build service account permission to access and decrypt the CryptoKey during the build.
$ gcloud kms keys add-iam-policy-binding $KEY_NAME \
--location=global --keyring=$KEYRING_NAME \
--member=serviceAccount:$SERVICE_ACCOUNT@cloudbuild.gserviceaccount.com \
--role=roles/cloudkms.cryptoKeyDecrypter
Updated IAM policy for key [github-key].
bindings:
- members:
  - serviceAccount:792657441134@cloudbuild.gserviceaccount.com
  role: roles/cloudkms.cryptoKeyDecrypter
etag: BwWLmz5ANcY=
version: 1

-----------------------------------------------------------------
KEY_NAME=google-compute-engine-key
FILE_NAME=google_compute_engine
KEYRING_NAME=my-keyring
SERVICE_ACCOUNT=792657441134
gcloud kms keys create $KEY_NAME \
--location=global --keyring=$KEYRING_NAME --purpose=encryption
gcloud kms encrypt --plaintext-file=$HOME/.ssh/$FILE_NAME \
--ciphertext-file=$HOME/.ssh/$FILE_NAME.enc \
--location=global --keyring=$KEYRING_NAME --key=$KEY_NAME
gcloud kms keys add-iam-policy-binding $KEY_NAME \
--location=global --keyring=$KEYRING_NAME \
--member=serviceAccount:$SERVICE_ACCOUNT@cloudbuild.gserviceaccount.com \
--role=roles/cloudkms.cryptoKeyDecrypter
-----------------------------------------------------------------
END

echo "\nASSETS\n"
mkdir -p /root/.ssh
cd /workspace/home/chetabahana/.ssh
cp -f config known_hosts -t /root/.ssh
cp -frpvT /workspace/home/chetabahana $HOME
chmod 600 $HOME/.ssh/*

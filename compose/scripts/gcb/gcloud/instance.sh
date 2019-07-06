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

echo "\nMETADATA\n"
gcloud projects describe chetabahana && gcloud app describe && gcloud config list --all
gcloud compute project-info describe #gist.github.com/pydevops/cffbd3c694d599c6ca18342d3625af97
ZONE=`gcloud compute project-info describe --format 'value(commonInstanceMetadata.items.google-compute-default-zone)'`
INSTANCE=$PROJECT_ID@`gcloud compute instances list --filter="status=('RUNNING')" | head -2 | tail -1 | sed 's/ .*//'`

echo "\nSTORAGE\n"
export BOTO_CONFIG=/dev/null
gsutil -o GSUtil:default_project_id=$PROJECT_ID du -shc

echo "\nCLEANING\n"
BEFORE_DATE=`date +%Y-%m-%d -d "3 month ago"`
REGISTRY_NAME=us.gcr.io/$PROJECT_ID/app-engine-tmp
echo "Cleaning old images from 3 months ago: $BEFORE_DATE"
bash /workspace/scripts/gcb/docker/assets.bash $REGISTRY_NAME $BEFORE_DATE

echo "\nHOME\n"
USER_REPO=github_${PROJECT_ID}_branches
sleep 1 && cd $HOME && gcloud source repos clone $USER_REPO branches
cd branches && SHOW_ALL=`git show-branch --all | grep -w $BRANCH_NAME`
[ $? = 0 ] && git checkout $BRANCH_NAME || echo "$BRANCH_NAME not exist"
mv -f $HOME/branches/home /workspace && rm -rf $HOME/branches

echo "\nASSETS\n"
cp -frpT $BUILD_DIR/$PROJECT_ID $HOME
gcloud kms decrypt --location global \
--keyring my-keyring --key google-compute-engine-key \
--plaintext-file $HOME/.ssh/google_compute_engine \
--ciphertext-file $HOME/.ssh/google_compute_engine.enc 
chmod 600 $HOME/.ssh/*
ls -alR $HOME

echo '\nINSTANCE\n'

gcloud compute scp --zone $ZONE --verbosity info --recurse \
--force-key-file-overwrite $BUILD_DIR/$PROJECT_ID $INSTANCE:/home

gcloud compute ssh --zone $ZONE $INSTANCE \
--command 'sh /home/'$PROJECT_ID'/.docker/init.sh $BRANCH_NAME'

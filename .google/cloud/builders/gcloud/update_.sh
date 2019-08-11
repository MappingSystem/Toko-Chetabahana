#!/bin/sh
[ -z "${INSTANCE_NAME}" ] && return
echo "\n$hr\nINSTANCE PROFILES\n$hr"
[ "$REPO_NAME" != "$INSTANCE_NAME" ] && return

return
INSTANCE_HOME="$PROJECT_ID@$INSTANCE_NAME:/home"
for i in /workspace/.google/cloud/compute/home/*; do
    rm -rvf $i/.ssh/*.enc $i/.ssh/known_hosts $i/.ssh/google_compute_*
    gcloud compute scp --verbosity info --recurse --force-key-file-overwrite --zone $INSTANCE_ZONE $i $INSTANCE_HOME
done

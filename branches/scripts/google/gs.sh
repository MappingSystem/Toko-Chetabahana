#!/bin/sh

: <<'END'
#https://stackoverflow.com/a/47978804/4058484
$ export BOTO_CONFIG=/dev/null

$ gsutil --help
Usage: gsutil [-D] [-DD] [-h header]... [-m] [-o] [-q] [command [opts...] args...]
Available commands:
  acl              Get, set, or change bucket and/or object ACLs
  bucketpolicyonly Configure Bucket Policy Only
  cat              Concatenate object content to stdout
  compose          Concatenate a sequence of objects into a new composite object.
  config           Obtain credentials and create configuration file
  cors             Get or set a CORS JSON document for one or more buckets
  cp               Copy files and objects
  defacl           Get, set, or change default ACL on buckets
  defstorageclass  Get or set the default storage class on buckets
  du               Display object size usage
  hash             Calculate file hashes
  help             Get help about commands and topics
  iam              Get, set, or change bucket and/or object IAM permissions.
  kms              Configure Cloud KMS encryption
  label            Get, set, or change the label configuration of a bucket.
  lifecycle        Get or set lifecycle configuration for a bucket
  logging          Configure or retrieve logging on buckets
  ls               List providers, buckets, or objects
  mb               Make buckets
  mv               Move/rename objects and/or subdirectories
  notification     Configure object change notification
  perfdiag         Run performance diagnostic
  rb               Remove buckets
  requesterpays    Enable or disable requester pays for one or more buckets
  retention        Provides utilities to interact with Retention Policy feature.
  rewrite          Rewrite objects
  rm               Remove objects
  rsync            Synchronize content of two buckets/directories
  setmeta          Set metadata on already uploaded objects
  signurl          Create a signed url
  stat             Display object status
  test             Run gsutil unit/integration tests (for developers)
  update           Update to the latest gsutil release
  version          Print version info about gsutil
  versioning       Enable or suspend versioning for one or more buckets
  web              Set a main page and/or error page for one or more buckets

Additional help topics:
  acls             Working With Access Control Lists
  anon             Accessing Public Data Without Credentials
  apis             Cloud Storage APIs
  crc32c           CRC32C and Installing crcmod
  creds            Credential Types Supporting Various Use Cases
  dev              Contributing Code to gsutil
  encoding         Filename encoding and interoperability problems
  encryption       Using Encryption Keys
  metadata         Working With Object Metadata
  naming           Object and Bucket Naming
  options          Top-Level Command-Line Options
  prod             Scripting Production Transfers
  projects         Working With Projects
  retries          Retry Handling Strategy
  security         Security and Privacy Considerations
  subdirs          How Subdirectories Work
  support          Google Cloud Storage Support
  throttling       Throttling gsutil
  versions         Object Versioning and Concurrency Control
  wildcards        Wildcard Names

Use gsutil help <command or topic> for detailed help.

$ gcsfuse --help
NAME:
   gcsfuse - Mount a GCS bucket locally

USAGE:
   gcsfuse [global options] bucket mountpoint
   
VERSION:
   0.27.0 (Go version go1.12.1)
   
GLOBAL OPTIONS:
   --foreground                 Stay in the foreground after mounting.
   -o value                     Additional system-specific mount options. Be careful!
   --dir-mode value             Permissions bits for directories, in octal. (default: 755)
   --file-mode value            Permission bits for files, in octal. (default: 644)
   --uid value                  UID owner of all inodes. (default: -1)
   --gid value                  GID owner of all inodes. (default: -1)
   --implicit-dirs              Implicitly define directories based on content. See docs/semantics.md
   --only-dir value             Mount only the given directory, relative to the bucket root.
   --billing-project value      Project to use for billing when accessing requester pays buckets. (default: none)
   --key-file value             Absolute path to JSON key file for use with GCS. (default: none, Google application default credentials used)
   --limit-bytes-per-sec value  Bandwidth limit for reading data, measured over a 30-second window. (use -1 for no limit) (default: -1)
   --limit-ops-per-sec value    Operations per second limit, measured over a 30-second window (use -1 for no limit) (default: 5)
   --stat-cache-ttl value       How long to cache StatObject results and inode attributes. (default: 1m0s)
   --type-cache-ttl value       How long to cache name -> file/dir mappings in directory inodes. (default: 1m0s)
   --temp-dir value             Absolute path to temporary directory for local GCS object copies. (default: system default, likely /tmp)
   --debug_fuse                 Enable fuse-related debugging output.
   --debug_gcs                  Print GCS request and timing information.
   --debug_http                 Dump HTTP requests and responses to/from GCS.
   --debug_invariants           Panic when internal invariants are violated.
   --help, -h                   show help
   --version, -v                print the version
END

echo "\nGCLOUD\n"
gcloud version

#echo "\nROLES\n"
#gcloud projects get-iam-policy chetabahana --flatten="bindings[].members"

echo "\nREGISTRY\n"
DIGEST=`gcloud container images list-tags gcr.io/chetabahana/backend \
--filter='-tags:*' --format='get(digest)'`
[ -z "$DIGEST" ] && echo "No digest" || gcloud container images delete \
--quiet gcr.io/chetabahana/backend@$DIGEST

#echo "\nGCS MEDIA\n"
#gcsfuse -o allow_other -o nonempty --uid 1001 --gid 999 --temp-dir /tmp --only-dir saleor/media appspot.chetabahana.com /tmp/volume/media
#gcsfuse -o allow_other --uid 1001 --gid 999 --temp-dir /tmp --only-dir saleor/static appspot.chetabahana.com volume/static
#rm -rfv volume/media/products volume/media/category-backgrounds volume/media/collection-backgrounds
#cd /tmp/volume/media && rm -rfv products category-backgrounds collection-backgrounds

echo "\nSTORAGE\n"
export BOTO_CONFIG=/dev/null
gsutil -o GSUtil:default_project_id=chetabahana du -shc
#gsutil -mq rm -rf gs://appspot.chetabahana.com/saleor/media
#gsutil -mq rm -rf gs://appspot.chetabahana.com/saleor/static

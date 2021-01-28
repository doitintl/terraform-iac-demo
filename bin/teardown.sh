#!/usr/bin/env bash

source .env
echo "Tearing down $PROJECT_ID"

BUCKET_ID="${PROJECT_ID}-tfstate"
CLOUDBUILD_SA="${PROJECT_NUMBER}@cloudbuild.gserviceaccount.com"

# add IAM role for CloudBuild
echo "Removing IAM role 'Editor' for ${CLOUDBUILD_SA} ..."
gcloud projects remove-iam-policy-binding $PROJECT_ID \
    --member serviceAccount:$CLOUDBUILD_SA --role roles/editor

# create storage bucket for TF state
echo "Removing storage bucket ${BUCKET_ID} ..."
gsutil rm -r gs://${BUCKET_ID}

echo "Done"
exit 0

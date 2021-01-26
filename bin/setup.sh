#!/usr/bin/env bash

source .env
echo "Initializing $PROJECT_ID"

BUCKET_ID="${PROJECT_ID}-tfstate"
CLOUDBUILD_SA="${PROJECT_NUMBER}@cloudbuild.gserviceaccount.com"

# enable apis
echo "Enabling APIs ..."
gcloud services enable compute.googleapis.com \
    cloudbuild.googleapis.com \
    storage.googleapis.com

# add IAM role for CloudBuild
echo "Creating IAM role 'Editor' for ${CLOUDBUILD_SA} ..."
gcloud projects add-iam-policy-binding $PROJECT_ID \
    --member serviceAccount:$CLOUDBUILD_SA --role roles/editor

# create storage bucket for TF state
echo "Creating storage bucket ${BUCKET_ID} for tfstate ..."
gsutil mb gs://${BUCKET_ID}
gsutil versioning set on gs://${BUCKET_ID}

# in console: connect Github repo, create cloudbuild trigger (push)
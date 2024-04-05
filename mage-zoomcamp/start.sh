#!/bin/bash

# Load environment variables from the .env file
source .env

# Change directory to the parent directory
cd ..

# Change directory to the Terraform directory
cd terraform

# Build the Terraform Docker image
docker build -t terraform-docker .

# Wait for the Docker container to be fully up and running
while ! docker images -q terraform-docker >/dev/null 2>&1; do
    sleep 1
done

# Initialize Terraform in the current directory
docker run --rm -v "$(pwd)":/terraform \
                -v "$LOCAL_PATH_SERVICE_ACCOUNT":/root/service_account.json \
                -e TF_VAR_gcs_bucket_name="$TF_VAR_gcs_bucket_name" \
                -e TF_VAR_bq_dataset_name="$TF_VAR_bq_dataset_name" \
                -e TF_VAR_project="$TF_VAR_project" \
                -e TF_VAR_region="$TF_VAR_region" \
                -e TF_VAR_location="$TF_VAR_location" \
                terraform-docker init

# Plan Terraform changes
docker run --rm -v "$(pwd)":/terraform \
                -v "$LOCAL_PATH_SERVICE_ACCOUNT":/root/service_account.json \
                -e TF_VAR_gcs_bucket_name="$TF_VAR_gcs_bucket_name" \
                -e TF_VAR_bq_dataset_name="$TF_VAR_bq_dataset_name" \
                -e TF_VAR_project="$TF_VAR_project" \
                -e TF_VAR_region="$TF_VAR_region" \
                -e TF_VAR_location="$TF_VAR_location" \
                terraform-docker plan

# Apply Terraform changes (auto-approve)
docker run --rm -v "$(pwd)":/terraform \
                -v "$LOCAL_PATH_SERVICE_ACCOUNT":/root/service_account.json \
                -e TF_VAR_gcs_bucket_name="$TF_VAR_gcs_bucket_name" \
                -e TF_VAR_bq_dataset_name="$TF_VAR_bq_dataset_name" \
                -e TF_VAR_project="$TF_VAR_project" \
                -e TF_VAR_region="$TF_VAR_region" \
                -e TF_VAR_location="$TF_VAR_location" \
                terraform-docker apply -auto-approve

# Change directory back to the parent directory
cd ..

# Change directory to the mage-zoomcamp directory
cd mage-zoomcamp

# Build Docker images and start containers using docker-compose
docker-compose build magic

# Start containers
docker-compose up -d
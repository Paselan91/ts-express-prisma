#!/bin/bash

# How to exec this script
# ECR_ENDPOINT=<your-ecr-endpoint> ECS_CLUSTER_NAME=my-cluster ECS_SERVICE_NAME=my-service IMAGE_NAME=latest ./build-deploy-to-ecr.sh

# Exit the script if any command fails
set -e

# Set default values for optional environment variables
: "${AWS_REGION:=ap-northeast-1}"

# Display input arguments
echo "ECR_ENDPOINT: $ECR_ENDPOINT"
echo "ECS_CLUSTER_NAME: $ECS_CLUSTER_NAME"
echo "ECS_SERVICE_NAME: $ECS_SERVICE_NAME"
echo "IMAGE_NAME: $IMAGE_NAME"
echo "AWS_REGION: $AWS_REGION"

# Check if required environment variables are set
if [ -z "$ECR_ENDPOINT" ]; then
    echo "Error: ECR_ENDPOINT is not set"
    exit 1
fi

if [ -z "$ECS_CLUSTER_NAME" ]; then
    echo "Error: ECS_CLUSTER_NAME is not set"
    exit 1
fi

if [ -z "$ECS_SERVICE_NAME" ]; then
    echo "Error: ECS_SERVICE_NAME is not set"
    exit 1
fi

if [ -z "$IMAGE_NAME" ]; then
    echo "Error: IMAGE_NAME is not set"
    exit 1
fi

# Log in to AWS ECR
echo -e "\n Logging in to AWS ECR..."
aws ecr get-login-password --region $AWS_REGION | docker login --username AWS --password-stdin $ECR_ENDPOINT

# Build the Docker image
echo -e "\n Building the Docker image..."
docker build --platform linux/amd64 -t $IMAGE_NAME .

# Tag the Docker image
echo -e "\n Tagging the Docker image..."
docker tag $IMAGE_NAME:latest $ECR_ENDPOINT:latest

# Push the Docker image to ECR
echo -e "\n Pushing the Docker image to ECR..."
docker push $ECR_ENDPOINT:latest

# Update the ECS service
echo -e "\n Updating the ECS service..."
aws ecs update-service \
    --region $AWS_REGION \
    --cluster $ECS_CLUSTER_NAME \
    --service $ECS_SERVICE_NAME \
    --force-new-deployment

echo -e "\n Deployment completed successfully."

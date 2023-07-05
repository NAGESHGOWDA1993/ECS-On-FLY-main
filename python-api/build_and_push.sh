# #!/bin/bash

# Define variables
DOCKERFILE_PATH="./Dockerfile"
AWS_ACCOUNT_ID="564208559043"
AWS_REGION="eu-west-2"
ECR_REPOSITORY="flask-app"
CONTAINER_NAME="flask-app"
TAG="v1.0.0"


# Build the Docker container
docker build -t $CONTAINER_NAME:$TAG -f $DOCKERFILE_PATH .

# Add health check to the Docker container
docker run -d --name $CONTAINER_NAME-$TAG $CONTAINER_NAME:$TAG

# Wait for the health check to pass
HEALTH_CHECK_TIMEOUT=60
HEALTH_CHECK_INTERVAL=5
ELAPSED_TIME=0
HEALTH_STATUS="unhealthy"

while [ "$HEALTH_STATUS" != "running" ] && [ $ELAPSED_TIME -lt $HEALTH_CHECK_TIMEOUT ]; do
    HEALTH_STATUS=$(docker inspect --format='{{.State.Status}}' $CONTAINER_NAME-$TAG)
    if [ "$HEALTH_STATUS" = "running" ]; then
        break
    fi
    sleep $HEALTH_CHECK_INTERVAL
    ELAPSED_TIME=$((ELAPSED_TIME + HEALTH_CHECK_INTERVAL))
done

if [ "$HEALTH_STATUS" != "running" ]; then
    echo "Health check failed for container $CONTAINER_NAME-$TAG. Please check app.py file for potential error.."
    exit 1
fi

# Push the Docker container to AWS ECR
ECR_REPOSITORY_URI="$AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/$ECR_REPOSITORY"
aws ecr get-login-password --region $AWS_REGION | docker login --username AWS --password-stdin $ECR_REPOSITORY_URI
docker tag $CONTAINER_NAME:$TAG $ECR_REPOSITORY_URI:$TAG
docker push $ECR_REPOSITORY_URI:$TAG

# Cleanup
docker stop $CONTAINER_NAME-$TAG
docker rm $CONTAINER_NAME-$TAG
docker rmi $CONTAINER_NAME:$TAG
docker rmi $ECR_REPOSITORY_URI:$TAG
docker logout $ECR_REPOSITORY_URI

#!/bin/env bash
source ./.env

echo "Building jenkins..."
docker build -t ${DOCKER_REGISTRY}/jenkins-server:latest .

echo "Pushing jenkins..."
docker login $DOCKER_REGISTRY -u $DOCKER_REGISTRY_USER -p $DOCKER_REGISTRY_PAT
docker push ${DOCKER_REGISTRY}/jenkins-server:latest
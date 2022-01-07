#!/bin/zsh

ROUTE=$1
TAG_NAME=$2
PORT=$3

if [[ -z $ROUTE ]]; then
  echo "Route not provided"
  exit
fi

if [[ -z $TAG_NAME ]]; then
  TAG_NAME="fashion"
fi

if [[ -z $PORT ]]; then
  PORT="3000"
fi


echo "Removing previous stuff..."
docker stop $TAG_NAME
docker rm $TAG_NAME
docker rmi $TAG_NAME

echo "Building new stuff..."
docker build -t $TAG_NAME $ROUTE
docker run -d --name $TAG_NAME -p $PORT:80 $TAG_NAME

docker ps

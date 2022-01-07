#!/bin/zsh

TAG_NAME=$1
PORT=$2

if [[ -z $TAG_NAME ]]; then
  TAG_NAME="fashion"
  PORT='3000'
fi


echo "Removing previous stuff..."
docker stop $TAG_NAME
docker rm $TAG_NAME
docker rmi $TAG_NAME

echo "Building new stuff..."
docker build -t $TAG_NAME .
docker run -d --name $TAG_NAME -p $PORT:80 $TAG_NAME

docker ps

#!/bin/bash

# vars
# $1 e.g. 2124_vertex, 2122_nano_folio, 2120_ben_resume, 2058_metallic_slider
TEMPLATE_DIR=$1
TEMPLATE_URL="https://www.tooplate.com/zip-templates/$TEMPLATE_DIR.zip"
TEMP_DIR="/tmp/webfiles"
SERVER_DIR="/var/www/html"

echo "Installing dependencies..."
sudo apt-get update > /dev/null
sudo apt-get install apache2 > /dev/null

echo "Downloading template..."
mkdir -p $TEMP_DIR
cd $TEMP_DIR
sudo wget --output-file /dev/null $TEMPLATE_URL
sudo unzip $TEMPLATE_DIR.zip > /dev/null

echo "Moving template to server source..."
sudo rm -rf $SERVER_DIR
sudo mkdir $SERVER_DIR
sudo cp -r $TEMPLATE_DIR/* $SERVER_DIR

echo "Restarting server..."
service apache2 reload

echo "Cleaning up..."
sudo rm -rf $TEMP_DIR

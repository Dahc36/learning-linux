#! /bin/bash

# vars
# $1 e.g. 2124_vertex, 2122_nano_folio, 2120_ben_resume, 2058_metallic_slider
TEMPLATE_DIR=$1
TEMPLATE_URL="https://www.tooplate.com/zip-templates/$TEMPLATE_DIR.zip"
TEMP_DIR="/tmp/webfiles"
SERVER_DIR="/var/www/html"

echo "Installing dependencies..."
yum install httpd wget unzip -y > /dev/null

echo "Setting up server"
systemctl start httpd
systemctl enable httpd > /dev/null

echo "Downloading template..."
mkdir -p $TEMP_DIR
cd $TEMP_DIR
wget --output-file /dev/null $TEMPLATE_URL
unzip $TEMPLATE_DIR.zip > /dev/null

echo "Moving template to server source..."
rm -rf $SERVER_DIR
mkdir $SERVER_DIR
cp -r $TEMPLATE_DIR/* $SERVER_DIR

echo "Restarting server..."
systemctl restart httpd

echo "Cleaning up..."
rm -rf $TEMP_DIR

FROM ubuntu:latest
LABEL "Author"="David"
LABEL "Project"="fashion"

ENV DEBIAN_FRONTEND=noninteractive;
ENV TARGET_DIR="/var/www/html"
ENV TEMP_DIR="/tmp/downloaded-files"
ENV TEMPLATE_DIR="2127_little_fashion"
ENV TEMPLATE_URL="https://www.tooplate.com/zip-templates/$TEMPLATE_DIR.zip"

RUN echo "Installing dependencies..."
RUN apt-get update > /dev/null
RUN apt-get install apache2 -y > /dev/null
RUN apt-get install wget -y > /dev/null
RUN apt-get install unzip -y  > /dev/null

RUN echo "Downloading template..." && \
  mkdir $TEMP_DIR
WORKDIR $TEMP_DIR
RUN wget --output-file /dev/null $TEMPLATE_URL && \
  unzip $TEMPLATE_DIR.zip > /dev/null

RUN echo "Moving template to server source..." && \
  rm -rf $TARGET_DIR && \
  mkdir $TARGET_DIR && \
  cp -r $TEMPLATE_DIR/* $TARGET_DIR && \
  rm -rf $TEMP_DIR

CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
EXPOSE 80

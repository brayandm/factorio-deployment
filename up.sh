#!/bin/bash

if [ -f .active ]; then
  echo "There is an active deployment. Please run down.sh first."
  exit 1
fi

touch .active

source .env

TMP_DIR=$(ssh -q $SERVER "TMP=\$(mktemp -d) && mkdir -p \$TMP/saves && mkdir -p \$TMP/config && echo \$TMP")

echo $TMP_DIR > .tmp_dir

scp $SAVE_PATH$SAVE_FILE $SERVER:$TMP_DIR/saves/

scp server-settings.json $SERVER:$TMP_DIR/config/

CONTAINER_NAME="factorio-$(uuidgen)"

echo $CONTAINER_NAME > .container_name

ssh -q $SERVER "bash -c '
  sed -i \"s/\\\"game_password\\\": \\\"\\\"/\\\"game_password\\\": \\\"$GAMEPLAY_PASSWORD\\\"/\" $TMP_DIR/config/server-settings.json && \
  docker run -d \
    -p $UDP_PORT:34197/udp \
    -p $TCP_PORT:27015/tcp \
    -v $TMP_DIR:/factorio \
    --name $CONTAINER_NAME \
    --restart=unless-stopped \
    factoriotools/factorio
'"



echo "Deployment done."
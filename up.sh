#!/bin/bash

source .env

TMP_DIR=$(ssh -q $SERVER "TMP=\$(mktemp -d) && mkdir -p \$TMP/saves && echo \$TMP")

echo $TMP_DIR > .tmp_dir

scp $SAVE_PATH$SAVE_FILE $SERVER:$TMP_DIR/saves/

ssh -q $SERVER << EOF
docker run -d \
  -p 34197:34197/udp \
  -p 27015:27015/tcp \
  -v $TMP_DIR:/factorio \
  --name factorio \
  --restart=unless-stopped \
  factoriotools/factorio
EOF

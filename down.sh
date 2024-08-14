#!/bin/bash

source .env

TMP_DIR=$(cat .tmp_dir)

ssh -q $SERVER << EOF
docker stop factorio
docker rm factorio
EOF

ssh -q $SERVER "rm -rf $TMP_DIR"

rm -f .tmp_dir

echo "Down done."

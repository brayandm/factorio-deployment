#!/bin/bash

if [ ! -f .active ]; then
  echo "There is no active deployment. Please run up.sh first."
  exit 1
fi

rm -f .active

source .env

TMP_DIR=$(cat .tmp_dir)

CONTAINER_NAME=$(cat .container_name)

ssh -q $SERVER "bash -c 'docker stop $CONTAINER_NAME && docker rm $CONTAINER_NAME && rm -rf $TMP_DIR'"

rm -f .tmp_dir

rm -f .container_name

echo "Down done."

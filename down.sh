#!/bin/bash

if [ ! -f .active ]; then
  echo "There is no active deployment. Please run up.sh first."
  exit 1
fi

rm -f .active

source .env

TMP_DIR=$(cat .tmp_dir)

ssh -q $SERVER "bash -c 'docker stop factorio && docker rm factorio'"

ssh -q $SERVER "rm -rf $TMP_DIR"

rm -f .tmp_dir

echo "Down done."

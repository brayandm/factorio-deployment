#!/bin/bash

source .env

TMP_DIR=$(cat .tmp_dir)

ssh -q $SERVER "bash -c 'docker stop factorio && docker rm factorio'"

ssh -q $SERVER "rm -rf $TMP_DIR"

rm -f .tmp_dir

echo "Down done."

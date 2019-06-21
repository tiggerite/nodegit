#!/bin/sh

CURRENT_DIR=$(pwd)

docker build --target nodegit-build --tag nodegit-build .

docker run --rm \
           -t \
           -v "$CURRENT_DIR/dist:/dist" \
           -v "$CURRENT_DIR/nodegit:/nodegit" \
           -v "$CURRENT_DIR/build.sh:/build.sh" \
           nodegit-build ./build.sh

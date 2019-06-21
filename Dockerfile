#--------------------------------------------------------------------------------
# nodegit-base
# Minimal alpine linux with node.js and nodegit dependencies
#--------------------------------------------------------------------------------
FROM node:10.16.0-alpine as nodegit-base
RUN apk add --no-cache \
    git \
    libgit2-dev \
    libressl2.7-libssl

#--------------------------------------------------------------------------------
# nodegit-build
# nodegit-base plus builds nodegit
#--------------------------------------------------------------------------------
FROM nodegit-base as nodegit-build
RUN apk add --no-cache python tzdata build-base && \
    BUILD_ONLY=true npm install --no-save --no-package-lock --production nodegit@0.24.3 && \
    mkdir -p ./nodegit-build/Release/obj.target ./nodegit-dist && \
    cp -R ./node_modules/nodegit/build/Release/*.node ./nodegit-build/Release && \
    cp -R ./node_modules/nodegit/build/Release/obj.target/*.node ./nodegit-build/Release/obj.target && \
    cp -R ./node_modules/nodegit/dist/* ./nodegit-dist && \
    rm -rf ./node_modules && \
    apk del python tzdata build-base

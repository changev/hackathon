#!/bin/bash

set -x
build_config_dir="$1"
manifest_path="$2"
build_status="$3"

pushd $1
if [ "${build_status}" != "SUCCESS" ]; then
    ./tools/ENV-BUILD ./tools/app/post-result.py \
    --manifest_file "${manifest_path}" \
    --jenkins_url "${JENKINS_URL}" \
    --build_url "${BUILD_URL}" \
    --public_jenkins_url "http://147.178.202.18/" \
    --ghtoken ${GITHUB_TOKEN}
fi

./tools/ENV-BUILD ./tools/app/commit_status_setter.py \
--manifest "${manifest_path}" \
--build-url "${BUILD_URL}" \
--public-jenkins-url "http://147.178.202.18/" \
--status "${build_status,,}" \
--ghtoken ${GITHUB_TOKEN}
popd

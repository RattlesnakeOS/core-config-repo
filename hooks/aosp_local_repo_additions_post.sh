#!/usr/bin/env bash

# TODO: apv workaround - remove once alternative is built
mkdir -p "${AOSP_BUILD_DIR}/.repo/local_manifests"
cat <<EOF >> "${AOSP_BUILD_DIR}/.repo/local_manifests/apv.xml"
<?xml version="1.0" encoding="UTF-8"?>
<manifest>
  <remote name="vendor" fetch="${APV_REMOTE}" revision="${APV_BRANCH}" />
  <project path="vendor/android-prepare-vendor" name="android-prepare-vendor" remote="vendor" revision="${APV_REVISION}" />
</manifest>
EOF
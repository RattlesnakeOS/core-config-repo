#!/usr/bin/env bash

# TODO: apv workaround - remove once alternative is built
mkdir -p "${AOSP_BUILD_DIR}/.repo/local_manifests"
cat <<EOF >> "${AOSP_BUILD_DIR}/.repo/local_manifests/vendor.xml"
<?xml version="1.0" encoding="UTF-8"?>
<manifest>
  <remote name="apv" fetch="${APV_REMOTE}" revision="${APV_BRANCH}" />
  <project path="vendor/adevtool" name="adevtool" remote="rattlesnakeos" />
  <project path="vendor/state" name="vendor_state" remote="rattlesnakeos" />
  <project path="vendor/android-prepare-vendor" name="android-prepare-vendor" remote="apv" revision="${APV_REVISION}" />
</manifest>
EOF
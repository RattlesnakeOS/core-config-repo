#!/usr/bin/env bash

# TODO: apv workaround - remove once alternative is built
cd "${AOSP_BUILD_DIR}/vendor/android-prepare-vendor"
git am --whitespace=nowarn "${CORE_DIR}/patches/apv.patch" || true

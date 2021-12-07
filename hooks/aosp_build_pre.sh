#!/usr/bin/env bash

patch_android12_build_workarounds() {
  log_header "${FUNCNAME[0]}"

  # workaround for a number of APK and XML files in current setup that cause build error with strict PRODUCT_ENFORCE_ARTIFACT_PATH_REQUIREMENTS
  sed -i "s@PRODUCT_ENFORCE_ARTIFACT_PATH_REQUIREMENTS@#PRODUCT_ENFORCE_ARTIFACT_PATH_REQUIREMENTS@" "${PRODUCT_MAKEFILE}"

  # workaround for issue with jar files from apv that the build system is not happy with
  cd "${AOSP_BUILD_DIR}/build/soong"
  git am --whitespace=nowarn "${CORE_DIR}/patches/build_soong.patch"

  # workaround for build issue with unused turbo_adapter.te
  rm -rf "${AOSP_BUILD_DIR}/hardware/google/pixel-sepolicy/googlebattery/turbo_adapter.te"
}

patch_updater() {
  log_header "${FUNCNAME[0]}"

  # update config to s3 release url
  cd "${AOSP_BUILD_DIR}/packages/apps/Updater/res/values"
  sed -i --expression "s@s3bucket@${RELEASE_URL}/@g" config.xml

  # include selinux changes required to support updater in 11.0
  if ! grep -q "vendor/core/vendor/sepolicy/common/sepolicy.mk" "${AOSP_BUILD_DIR}/build/core/config.mk"; then
    sed -i '/product-graph dump-products/a #add selinux policies last\n$(eval include vendor/core/vendor/sepolicy/common/sepolicy.mk)' "${AOSP_BUILD_DIR}/build/core/config.mk"
  fi
}

patch_launcher() {
  log_header "${FUNCNAME[0]}"

  # disable QuickSearchBox widget on home screen
  sed -i "s/QSB_ON_FIRST_SCREEN = true;/QSB_ON_FIRST_SCREEN = false;/" "${AOSP_BUILD_DIR}/packages/apps/Launcher3/src/com/android/launcher3/config/FeatureFlags.java"
}

patch_device_config() {
  log_header "${FUNCNAME[0]}"

  # rename devices to friendly name
  sed -i "s@PRODUCT_MODEL := AOSP on ${DEVICE}@PRODUCT_MODEL := ${DEVICE_FRIENDLY}@" "${PRODUCT_MAKEFILE}" || true
}

patch_android12_build_workarounds
patch_updater
patch_launcher
patch_device_config
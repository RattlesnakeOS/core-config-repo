#!/usr/bin/env bash

patch_updater() {
  log_header "${FUNCNAME[0]}"

  cd "${AOSP_BUILD_DIR}/packages/apps/Updater/res/values"
  sed --in-place --expression "s@s3bucket@${RELEASE_URL}/@g" config.xml

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

patch_disable_apex() {
  log_header "${FUNCNAME[0]}"

  # currently don't have a need for apex updates (https://source.android.com/devices/tech/ota/apex)
  sed -i 's@$(call inherit-product, $(SRC_TARGET_DIR)/product/updatable_apex.mk)@@' "${AOSP_BUILD_DIR}/build/make/target/product/mainline_system.mk"
}

patch_device_config() {
  log_header "${FUNCNAME[0]}"

  # rename devices to friendly name
  sed -i "s@PRODUCT_MODEL := AOSP on ${DEVICE}@PRODUCT_MODEL := ${DEVICE_FRIENDLY}@" "${PRODUCT_MAKEFILE}" || true
}

patch_updater
patch_launcher
patch_disable_apex
patch_device_config
#!/usr/bin/env bash

# workaround for libsdsprpc and libadsprpc not specifying LOCAL_SHARED_LIBRARIES
sed -i '/LOCAL_MODULE := libsdsprpc/a LOCAL_SHARED_LIBRARIES := libc++ libc libcutils libdl libion liblog libm' "${AOSP_BUILD_DIR}/vendor/google_devices/${DEVICE}/Android.mk" || true
sed -i '/LOCAL_MODULE := libadsprpc/a LOCAL_SHARED_LIBRARIES := libc++ libc libcutils libdl libion liblog libm' "${AOSP_BUILD_DIR}/vendor/google_devices/${DEVICE}/Android.mk" || true
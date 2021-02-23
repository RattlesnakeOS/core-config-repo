DEVICE_PACKAGE_OVERLAYS += vendor/core/vendor/overlay/common

BUILD_BROKEN_VINTF_PRODUCT_COPY_FILES := true

VENDOR_DEVICE := $(TARGET_PRODUCT:aosp_%=%)

ifeq ($(filter-out flame coral, $(VENDOR_DEVICE)),)
DEVICE_PACKAGE_OVERLAYS += vendor/core/vendor/overlay/coral
PRODUCT_ENFORCE_ARTIFACT_PATH_REQUIREMENTS := strict
endif

PRODUCT_PACKAGES += Updater
PRODUCT_PACKAGES += TrichromeChrome
PRODUCT_PACKAGES += TrichromeWebView
PRODUCT_PACKAGES += F-Droid
PRODUCT_PACKAGES += F-DroidPrivilegedExtension

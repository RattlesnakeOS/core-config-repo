DEVICE_PACKAGE_OVERLAYS += vendor/core/vendor/overlay/common

VENDOR_DEVICE := $(TARGET_PRODUCT:aosp_%=%)

ifeq ($(filter-out flame coral, $(VENDOR_DEVICE)),)
DEVICE_PACKAGE_OVERLAYS += vendor/core/vendor/overlay/coral
endif

# Enable gestural navigation overlay to match default navigation mode
PRODUCT_PRODUCT_PROPERTIES += \
    ro.boot.vendor.overlay.theme=com.android.internal.systemui.navbar.gestural

PRODUCT_PACKAGES += Updater
PRODUCT_PACKAGES += TrichromeChrome
PRODUCT_PACKAGES += TrichromeWebView
PRODUCT_PACKAGES += F-Droid
PRODUCT_PACKAGES += F-DroidPrivilegedExtension

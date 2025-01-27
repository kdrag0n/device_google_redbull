#
# Copyright (C) 2016 The Android Open-Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

include build/make/target/board/BoardConfigMainlineCommon.mk
include build/make/target/board/BoardConfigPixelCommon.mk

TARGET_BOARD_PLATFORM := lito
USES_DEVICE_GOOGLE_REDBULL := true

TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-a
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_ABI2 :=
TARGET_CPU_VARIANT := generic
TARGET_CPU_VARIANT_RUNTIME := cortex-a76

ifeq (,$(filter %_64,$(TARGET_PRODUCT)))
TARGET_2ND_ARCH := arm
TARGET_2ND_ARCH_VARIANT := armv8-a
TARGET_2ND_CPU_ABI := armeabi-v7a
TARGET_2ND_CPU_ABI2 := armeabi
TARGET_2ND_CPU_VARIANT := generic
TARGET_2ND_CPU_VARIANT_RUNTIME := cortex-a76
endif

BUILD_BROKEN_DUP_RULES := true
BOARD_KERNEL_CMDLINE += console=ttyMSM0,115200n8 androidboot.console=ttyMSM0 printk.devkmsg=on
BOARD_KERNEL_CMDLINE += msm_rtb.filter=0x237
BOARD_KERNEL_CMDLINE += ehci-hcd.park=3
BOARD_KERNEL_CMDLINE += service_locator.enable=1
BOARD_KERNEL_CMDLINE += androidboot.memcg=1 cgroup.memory=nokmem
BOARD_KERNEL_CMDLINE += lpm_levels.sleep_disabled=1 # STOPSHIP b/113233473
BOARD_KERNEL_CMDLINE += usbcore.autosuspend=7
BOARD_KERNEL_CMDLINE += androidboot.usbcontroller=a600000.dwc3 swiotlb=2048
BOARD_KERNEL_CMDLINE += androidboot.boot_devices=soc/1d84000.ufshc
BOARD_KERNEL_CMDLINE += loop.max_part=7
BOARD_KERNEL_CMDLINE += snd_soc_cs35l41_i2c.async_probe=1
BOARD_KERNEL_CMDLINE += i2c_qcom_geni.async_probe=1
BOARD_KERNEL_CMDLINE += st21nfc.async_probe=1
BOARD_KERNEL_CMDLINE += spmi_pmic_arb.async_probe=1
BOARD_KERNEL_CMDLINE += ufs_qcom.async_probe=1

BOARD_KERNEL_BASE        := 0x00000000
BOARD_KERNEL_PAGESIZE    := 4096

BOARD_INCLUDE_DTB_IN_BOOTIMG := true
BOARD_BOOT_HEADER_VERSION := 3
BOARD_MKBOOTIMG_ARGS += --header_version $(BOARD_BOOT_HEADER_VERSION)

BOARD_DTBOIMG_PARTITION_SIZE := 16777216

TARGET_NO_KERNEL := false
BOARD_USES_GENERIC_KERNEL_IMAGE := true
BOARD_MOVE_GSI_AVB_KEYS_TO_VENDOR_BOOT := true
ifneq ($(PRODUCT_BUILD_VENDOR_BOOT_IMAGE),false)
BOARD_MOVE_RECOVERY_RESOURCES_TO_VENDOR_BOOT := true
endif

BOARD_USES_METADATA_PARTITION := true

AB_OTA_UPDATER := true

AB_OTA_PARTITIONS += \
    boot \
    vendor_boot \
    system \
    vbmeta \
    dtbo \
    product \
    system_ext

# Partitions (listed in the file) to be wiped under recovery.
TARGET_RECOVERY_WIPE := device/google/redbull/recovery.wipe
TARGET_RECOVERY_FSTAB := device/google/redbull/fstab.hardware
TARGET_RECOVERY_PIXEL_FORMAT := RGBX_8888
TARGET_RECOVERY_UI_LIB := \
    librecovery_ui_pixel \
    libfstab

# product.img
BOARD_PRODUCTIMAGE_FILE_SYSTEM_TYPE := ext4

# userdata.img
TARGET_USERIMAGES_USE_F2FS := true
BOARD_USERDATAIMAGE_PARTITION_SIZE := 10737418240
BOARD_USERDATAIMAGE_FILE_SYSTEM_TYPE := f2fs

# persist.img
BOARD_PERSISTIMAGE_PARTITION_SIZE := 33554432
BOARD_PERSISTIMAGE_FILE_SYSTEM_TYPE := ext4

# boot.img
BOARD_BOOTIMAGE_PARTITION_SIZE := 0x06000000

# vendor_boot.img
BOARD_VENDOR_BOOTIMAGE_PARTITION_SIZE := 0x06000000

# Allow LZ4 compression
BOARD_RAMDISK_USE_LZ4 := true

# system_ext.img
BOARD_SYSTEM_EXTIMAGE_FILE_SYSTEM_TYPE := ext4

BOARD_FLASH_BLOCK_SIZE := 131072

BOARD_ROOT_EXTRA_SYMLINKS := /vendor/lib/dsp:/dsp
BOARD_ROOT_EXTRA_SYMLINKS += /mnt/vendor/persist:/persist

include device/google/redbull-sepolicy/redbull-sepolicy.mk

QCOM_BOARD_PLATFORMS += lito
QC_PROP_ROOT := vendor/qcom/sm7250/proprietary
QC_PROP_PATH := $(QC_PROP_ROOT)
BOARD_HAVE_BLUETOOTH_QCOM := true
BOARD_HAVE_QCOM_FM := false
TARGET_USE_QTI_BT_SAR := true
TARGET_USE_QTI_BT_CHANNEL_AVOIDANCE := true
BOARD_USES_COMMON_BLUETOOTH_HAL := true

# Camera
TARGET_USES_AOSP := true
BOARD_QTI_CAMERA_32BIT_ONLY := false
CAMERA_DAEMON_NOT_PRESENT := true
TARGET_USES_ION := true

# GPS
TARGET_NO_RPC := true
TARGET_USES_HARDWARE_QCOM_GPS := false
BOARD_VENDOR_QCOM_GPS_LOC_API_HARDWARE := default
BOARD_VENDOR_QCOM_LOC_PDK_FEATURE_SET := true

# RenderScript
OVERRIDE_RS_DRIVER := libRSDriver_adreno.so

# Sensors
TARGET_SUPPORT_DIRECT_REPORT := true

# CHRE
CHRE_DAEMON_ENABLED := true
CHRE_DAEMON_LPMA_ENABLED := true
CHRE_DAEMON_LOAD_INTO_SENSORSPD := true

# wlan
BOARD_WLAN_DEVICE := qcwcn
BOARD_WPA_SUPPLICANT_DRIVER := NL80211
BOARD_HOSTAPD_DRIVER := NL80211
WIFI_DRIVER_DEFAULT := qca_cld3
WPA_SUPPLICANT_VERSION := VER_0_8_X
BOARD_WPA_SUPPLICANT_PRIVATE_LIB := lib_driver_cmd_$(BOARD_WLAN_DEVICE)
BOARD_HOSTAPD_PRIVATE_LIB := lib_driver_cmd_$(BOARD_WLAN_DEVICE)
WIFI_HIDL_FEATURE_AWARE := true
WIFI_HIDL_FEATURE_DUAL_INTERFACE:= true
WIFI_FEATURE_WIFI_EXT_HAL := true
WIFI_FEATURE_IMU_DETECTION := true
WIFI_HIDL_UNIFIED_SUPPLICANT_SERVICE_RC_ENTRY := true

# Audio
BOARD_USES_ALSA_AUDIO := true
AUDIO_FEATURE_ENABLED_MULTI_VOICE_SESSIONS := true
AUDIO_FEATURE_ENABLED_SND_MONITOR := true
AUDIO_FEATURE_ENABLED_USB_TUNNEL := true
BOARD_SUPPORTS_SOUND_TRIGGER := true
AUDIO_FEATURE_FLICKER_SENSOR_INPUT := true
#SOUND_TRIGGER_FEATURE_LPMA_ENABLED := true
AUDIO_FEATURE_ENABLED_MAXX_AUDIO := true
AUDIO_FEATURE_ENABLED_AUDIO_THERMAL_LISTENER := true
AUDIO_FEATURE_ENABLED_24BITS_CAMCORDER := true
AUDIO_FEATURE_ENABLED_AUDIO_ZOOM := true
AUDIO_FEATURE_ENABLED_INSTANCE_ID := true
#Cirrus cs35l41 speaker amp
AUDIO_FEATURE_ENABLED_CS35L41 := true
AUDIO_FEATURE_ENABLED_CS35L41_CALIBRATION_TOOL := true
AUDIO_FEATURE_ENABLED_SVA_MULTI_STAGE := true
AUDIO_FEATURE_QSSI_COMPLIANCE := true

# Audio hal flag
TARGET_USES_HARDWARE_QCOM_AUDIO := true
TARGET_USES_HARDWARE_QCOM_AUDIO_PLATFORM_8974 := true
TARGET_USES_HARDWARE_QCOM_AUDIO_POSTPROC := true
TARGET_USES_HARDWARE_QCOM_AUDIO_VOLUME_LISTENER := true
TARGET_USES_HARDWARE_QCOM_AUDIO_GET_MMAP_DATA_FD := true
TARGET_USES_HARDWARE_QCOM_AUDIO_APP_TYPE_CFG := true
TARGET_USES_HARDWARE_QCOM_AUDIO_ACDB_INIT_V2_CVD := true
TARGET_USES_HARDWARE_QCOM_AUDIO_MAX_TARGET_SPECIFIC_CHANNEL_CNT := "4"
TARGET_USES_HARDWARE_QCOM_AUDIO_INCALL_MUSIC_ENABLED := true
TARGET_USES_HARDWARE_QCOM_AUDIO_MULTIPLE_HW_VARIANTS_ENABLED := true
TARGET_USES_HARDWARE_QCOM_AUDIO_INCALL_STEREO_CAPTURE_ENABLED := true

# Graphics
TARGET_USES_GRALLOC1 := true
TARGET_USES_HWC2 := true

# Display
TARGET_USES_DISPLAY_RENDER_INTENTS := true
TARGET_USES_COLOR_METADATA := true
TARGET_USES_DRM_PP := true
TARGET_HAS_WIDE_COLOR_DISPLAY := true
TARGET_HAS_HDR_DISPLAY := true

# Vendor Interface Manifest
DEVICE_MANIFEST_FILE := device/google/redbull/manifest.xml
ifeq (,$(filter %_64,$(TARGET_PRODUCT)))
# Omx is 32 bit only
DEVICE_MANIFEST_FILE += device/google/redbull/manifest_omx.xml
endif
DEVICE_MATRIX_FILE := device/google/redbull/compatibility_matrix.xml

# Use mke2fs to create ext4 images
TARGET_USES_MKE2FS := true

# dynamic partition
BOARD_SUPER_PARTITION_SIZE := 9755951104
BOARD_SUPER_PARTITION_GROUPS := google_dynamic_partitions
ifneq ($(PRODUCT_BUILD_SYSTEM_IMAGE),false)
BOARD_GOOGLE_DYNAMIC_PARTITIONS_PARTITION_LIST += system
endif
ifneq ($(PRODUCT_BUILD_PRODUCT_IMAGE),false)
BOARD_GOOGLE_DYNAMIC_PARTITIONS_PARTITION_LIST += product
endif
ifneq ($(PRODUCT_BUILD_SYSTEM_EXT_IMAGE),false)
BOARD_GOOGLE_DYNAMIC_PARTITIONS_PARTITION_LIST += system_ext
endif
ifneq ($(PRODUCT_BUILD_VENDOR_IMAGE),false)
BOARD_GOOGLE_DYNAMIC_PARTITIONS_PARTITION_LIST += vendor
endif

#BOARD_GOOGLE_DYNAMIC_PARTITIONS_SIZE is set to (5GB - 4MB)
BOARD_GOOGLE_DYNAMIC_PARTITIONS_SIZE := 5364514816

# Set error limit to BOARD_SUPER_PARTITON_SIZE - 500MB
BOARD_SUPER_PARTITION_ERROR_LIMIT := 9231663104

BUILD_BROKEN_USES_BUILD_COPY_HEADERS := true

-include device/google/redbull/soong/pixel_soong_config.mk

# List of modules that should not load automatically
PRODUCT_COPY_FILES += \
    device/google/redbull/modules.blocklist:$(TARGET_COPY_OUT_VENDOR)/lib/modules/modules.blocklist \
    device/google/redbull/init.insmod.charger.cfg:$(TARGET_COPY_OUT_VENDOR)/etc/init.insmod.charger.cfg \

# TARGET_BOOLOADER_BOARD_NAME sensitive common boilerplate

TARGET_BOARD_NAME_DIR := device/google/$(TARGET_BOOTLOADER_BOARD_NAME)
-include $(TARGET_BOARD_NAME_DIR:%/=%)-sepolicy/$(TARGET_BOOTLOADER_BOARD_NAME)-sepolicy.mk

TARGET_BOARD_INFO_FILE := $(TARGET_BOARD_NAME_DIR)/board-info.txt
TARGET_BOARD_COMMON_PATH := $(TARGET_BOARD_NAME_DIR)/sm7250

# Common kernel file handling
TARGET_KERNEL_DIR := $(TARGET_BOARD_NAME_DIR:%/=%)-kernel

# DTBO partition definitions
BOARD_PREBUILT_DTBOIMAGE := $(TARGET_KERNEL_DIR)/dtbo.img

TARGET_FS_CONFIG_GEN := $(TARGET_BOARD_NAME_DIR)/config.fs

# DTB
BOARD_PREBUILT_DTBIMAGE_DIR := $(TARGET_KERNEL_DIR)

BOARD_BUILD_VENDOR_RAMDISK_IMAGE := true

# Testing related defines
BOARD_PERFSETUP_SCRIPT := platform_testing/scripts/perf-setup/b5r3-setup.sh

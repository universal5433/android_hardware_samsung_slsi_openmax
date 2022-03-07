LOCAL_PATH := $(call my-dir)
include $(CLEAR_VARS)

LOCAL_MODULE_TAGS := optional

LOCAL_SRC_FILES := \
	Exynos_OMX_Basecomponent.c \
	Exynos_OMX_Baseport.c

LOCAL_MODULE := libExynosOMX_Basecomponent

LOCAL_CFLAGS := \
    -Wno-enum-conversion \
    -Wno-unused-label \
    -Wno-unused-parameter \
    -Wno-unused-variable \
    -Wno-parentheses-equality \
    -Wno-undefined-inline

LOCAL_STATIC_LIBRARIES := libExynosOMX_OSAL
LOCAL_SHARED_LIBRARIES := libcutils libutils liblog

LOCAL_C_INCLUDES := \
	$(TARGET_OUT_INTERMEDIATES)/KERNEL_OBJ/usr/include \
	$(EXYNOS_OMX_INC)/exynos \
	$(EXYNOS_OMX_TOP)/osal

LOCAL_ADDITIONAL_DEPENDENCIES := \
	$(TARGET_OUT_INTERMEDIATES)/KERNEL_OBJ/usr

ifeq ($(BOARD_USE_KHRONOS_OMX_HEADER), true)
LOCAL_CFLAGS += -DUSE_KHRONOS_OMX_HEADER
LOCAL_C_INCLUDES += $(EXYNOS_OMX_INC)/khronos
else
ifeq ($(BOARD_USE_ANDROID), true)
LOCAL_C_INCLUDES += $(ANDROID_MEDIA_INC)/openmax
endif
endif

ifeq ($(EXYNOS_OMX_SUPPORT_EGL_IMAGE), true)
LOCAL_CFLAGS += -DEGL_IMAGE_SUPPORT
endif

include $(BUILD_STATIC_LIBRARY)

include $(CLEAR_VARS)

LOCAL_MODULE_TAGS := optional

LOCAL_SRC_FILES := \
	Exynos_OMX_Resourcemanager.c

LOCAL_PRELINK_MODULE := false
LOCAL_MODULE := libExynosOMX_Resourcemanager
LOCAL_VENDOR_MODULE := true

LOCAL_CFLAGS := \
    -Wno-enum-conversion \
    -Wno-unused-label \
    -Wno-unused-parameter \
    -Wno-unused-variable \
    -Wno-parentheses-equality \
    -Wno-undefined-inline

LOCAL_STATIC_LIBRARIES := libExynosOMX_OSAL
LOCAL_SHARED_LIBRARIES := liblog libcutils libutils

LOCAL_C_INCLUDES := \
	$(TARGET_OUT_INTERMEDIATES)/KERNEL_OBJ/usr/include \
	$(EXYNOS_OMX_INC)/exynos \
	$(EXYNOS_OMX_TOP)/osal

LOCAL_ADDITIONAL_DEPENDENCIES := \
	$(TARGET_OUT_INTERMEDIATES)/KERNEL_OBJ/usr

ifeq ($(BOARD_USE_KHRONOS_OMX_HEADER), true)
LOCAL_CFLAGS += -DUSE_KHRONOS_OMX_HEADER
LOCAL_C_INCLUDES += $(EXYNOS_OMX_INC)/khronos
else
ifeq ($(BOARD_USE_ANDROID), true)
LOCAL_C_INCLUDES += $(ANDROID_MEDIA_INC)/openmax
endif
endif

ifeq ($(EXYNOS_OMX_SUPPORT_TUNNELING), true)
LOCAL_CFLAGS += -DTUNNELING_SUPPORT
endif

ifneq ($(BOARD_NOT_SUPPORT_DCPP), true)
LOCAL_CFLAGS += -DUSE_SECURE_WITH_NONSECURE
endif

ifeq ($(BOARD_USE_SINGLE_DRM), true)
LOCAL_CFLAGS += -DUSE_SINGLE_DRM
endif

include $(BUILD_SHARED_LIBRARY)

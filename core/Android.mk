LOCAL_PATH := $(call my-dir)
include $(CLEAR_VARS)

LOCAL_MODULE_TAGS := optional

LOCAL_SRC_FILES := \
	Exynos_OMX_Component_Register.c \
	Exynos_OMX_Core.c

LOCAL_PRELINK_MODULE := false
LOCAL_MODULE := libExynosOMX_Core

LOCAL_CFLAGS := \
    -Wno-enum-conversion \
    -Wno-unused-label \
    -Wno-unused-parameter \
    -Wno-unused-variable \
    -Wno-parentheses-equality \
    -Wno-undefined-inline

LOCAL_ARM_MODE := arm
LOCAL_VENDOR_MODULE := true

LOCAL_STATIC_LIBRARIES := libExynosOMX_OSAL libExynosOMX_Basecomponent
LOCAL_SHARED_LIBRARIES := libc libdl libcutils libutils liblog \
	libExynosOMX_Resourcemanager

LOCAL_C_INCLUDES := \
	$(TARGET_OUT_INTERMEDIATES)/KERNEL_OBJ/usr/include \
	$(EXYNOS_OMX_INC)/exynos \
	$(EXYNOS_OMX_TOP)/osal \
	$(EXYNOS_OMX_TOP)/component/common

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

ifeq ($(EXYNOS_OMX_SUPPORT_EGL_IMAGE), true)
LOCAL_CFLAGS += -DEGL_IMAGE_SUPPORT
endif

include $(BUILD_SHARED_LIBRARY)


# Copyright (C) 2008 The Android Open Source Project
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

LOCAL_PATH := $(call my-dir)

sourceFiles := \
	acquired_buffer.cpp \
	compositor.cpp \
	debug_hud_data.cpp \
	debug_hud_view.cpp \
	display_manager_service.cpp \
	display_service.cpp \
	display_surface.cpp \
	epoll_event_dispatcher.cpp \
	hardware_composer.cpp \
	screenshot_service.cpp \
	surface_channel.cpp \
	video_compositor.cpp \
	video_mesh_surface.cpp \
	vr_flinger.cpp \
	vsync_service.cpp

includeFiles := $(LOCAL_PATH)/include

staticLibraries := \
	libsurfaceflingerincludes \
	libhwcomposer-command-buffer \
	libbufferhub \
	libbufferhubqueue \
	libeds \
	libdisplay \
	libdvrcommon \
	libdvrgraphics \
	libperformance \
	libsensor \
	libpdx_default_transport \
	libvr_manager \

sharedLibraries := \
	android.dvr.composer@1.0 \
	android.hardware.graphics.allocator@2.0 \
	android.hardware.graphics.composer@2.1 \
	libbinder \
	libbase \
	libcutils \
	liblog \
	libhardware \
	libutils \
	libEGL \
	libGLESv1_CM \
	libGLESv2 \
	libvulkan \
	libui \
	libgui \
	libsync \
	libhidlbase \
	libhidltransport \
	libfmq \

include $(CLEAR_VARS)
LOCAL_SRC_FILES := $(sourceFiles)
LOCAL_C_INCLUDES := $(includeFiles)
LOCAL_EXPORT_C_INCLUDE_DIRS := $(includeFiles)

LOCAL_CFLAGS += -DLOG_TAG=\"vr_flinger\"
LOCAL_CFLAGS += -DTRACE=0
LOCAL_CFLAGS += -DATRACE_TAG=ATRACE_TAG_GRAPHICS
LOCAL_CFLAGS += -DGL_GLEXT_PROTOTYPES -DEGL_EGLEXT_PROTOTYPES
ifeq ($(TARGET_USES_QCOM_BSP), true)
    LOCAL_C_INCLUDES += hardware/qcom/display/libgralloc
    LOCAL_C_INCLUDES += hardware/qcom/display/libqdutils
    LOCAL_SHARED_LIBRARIES += libqdutils
endif
LOCAL_SHARED_LIBRARIES := $(sharedLibraries)
LOCAL_WHOLE_STATIC_LIBRARIES := $(staticLibraries)
LOCAL_MODULE := libvrflinger
include $(BUILD_STATIC_LIBRARY)
# Copyright (C) 2009 The Android Open Source Project
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


LOCAL_PATH := $(call my-dir)
#APP_PATH:= $(NDK)/$(call my-dir) 

include $(CLEAR_VARS) 

LOCAL_MODULE := libiconv 

LIBICONV := libiconv

LOCAL_CFLAGS := -I$(LOCAL_PATH)/$(LIBICONV)
LOCAL_SRC_FILES := $(LIBICONV)/iconv.c

include $(BUILD_STATIC_LIBRARY) 

#LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

LOCAL_MODULE    := zbar

MY_SOURCES_LIST := $(wildcard $(LOCAL_PATH)/*.c)
MY_SOURCES_LIST += $(wildcard $(LOCAL_PATH)/decoder/*.c)
MY_SOURCES_LIST += $(wildcard $(LOCAL_PATH)/libiconv/*.c)
MY_SOURCES_LIST += $(wildcard $(LOCAL_PATH)/processor/*.c)
MY_SOURCES_LIST += $(wildcard $(LOCAL_PATH)/qrcode/*.c)
MY_SOURCES_LIST += $(wildcard $(LOCAL_PATH)/video/*.c)
MY_SOURCES_LIST += $(wildcard $(LOCAL_PATH)/window/*.c)

#LOCAL_SRC_FILES := $(MY_SOURCES_LIST:$(LOCAL_PATH)/%=%)
LOCAL_SRC_FILES := convert.c decoder.c error.c image.c img_scanner.c \
	refcnt.c scanner.c symbol.c video.c window.c \
	\
	qrcode/bch15_5.c qrcode/binarize.c qrcode/isaac.c qrcode/qrdec.c qrcode/qrdectxt.c \
	qrcode/rs.c qrcode/util.c \
	\
	processor/null.c video/null.c window/null.c decoder/qr_finder.c \
	\
	decoder/code128.c decoder/code39.c decoder/code93.c decoder/codabar.c \
	\
	decoder/ean.c decoder/databar.c decoder/i25.c \
	android_zbar.c
	
LOCAL_CFLAGS := -I$(LOCAL_PATH) -I$(LOCAL_PATH)/$(LIBICONV)
LOCAL_LDLIBS := -llog

LOCAL_STATIC_LIBRARIES := libiconv

include $(BUILD_SHARED_LIBRARY)


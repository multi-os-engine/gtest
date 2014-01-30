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
#

# Gtest builds 2 libraries: libgtest and libgtest_main. libgtest
# contains most of the code (assertions...) and libgtest_main just
# provide a common main to run the test (ie if you link against
# libgtest_main you won't/should not provide a main() entry point.
#
# We build these 2 libraries for the target device and for the host if
# it is running linux and using ASTL.
#

# TODO: The targets below have some redundancy. Check if we cannot
# condense them using function(s) for the common code.

LOCAL_PATH := $(call my-dir)

libgtest_target_includes := \
    $(LOCAL_PATH)/.. \
    $(LOCAL_PATH)/../include

libgtest_host_includes := \
  $(LOCAL_PATH)/.. \
  $(LOCAL_PATH)/../include

libgtest_cflags := \
  -Wno-missing-field-initializers \

#######################################################################
# gtest lib host

include $(CLEAR_VARS)

LOCAL_CPP_EXTENSION := .cc
LOCAL_SRC_FILES := gtest-all.cc
LOCAL_C_INCLUDES := $(libgtest_host_includes)
LOCAL_CFLAGS += $(libgtest_cflags)
LOCAL_MODULE := libgtest_host

include $(BUILD_HOST_STATIC_LIBRARY)

#######################################################################
# gtest_main lib host

include $(CLEAR_VARS)

LOCAL_CPP_EXTENSION := .cc
LOCAL_SRC_FILES := gtest_main.cc
LOCAL_C_INCLUDES := $(libgtest_host_includes)
LOCAL_CFLAGS += $(libgtest_cflags)
LOCAL_MODULE := libgtest_main_host

include $(BUILD_HOST_STATIC_LIBRARY)

#######################################################################
# gtest lib target

include $(CLEAR_VARS)

LOCAL_SDK_VERSION := 19
LOCAL_NDK_STL_VARIANT := stlport_static

LOCAL_CPP_EXTENSION := .cc
LOCAL_SRC_FILES := gtest-all.cc
LOCAL_C_INCLUDES := $(libgtest_target_includes)
LOCAL_CFLAGS += $(libgtest_cflags)
LOCAL_MODULE := libgtest

include $(BUILD_STATIC_LIBRARY)

#######################################################################
# gtest_main lib target

include $(CLEAR_VARS)

LOCAL_SDK_VERSION := 19
LOCAL_NDK_STL_VARIANT := stlport_static

LOCAL_CPP_EXTENSION := .cc
LOCAL_SRC_FILES := gtest_main.cc
LOCAL_C_INCLUDES := $(libgtest_target_includes)
LOCAL_CFLAGS += $(libgtest_cflags)
LOCAL_MODULE := libgtest_main

include $(BUILD_STATIC_LIBRARY)

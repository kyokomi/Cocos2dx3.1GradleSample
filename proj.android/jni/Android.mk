LOCAL_PATH := $(call my-dir)
COCOS2DX_ROOT := $(LOCAL_PATH)/../../cocos2d

include $(CLEAR_VARS)

LOCAL_MODULE := cocos2dcpp_shared

LOCAL_MODULE_FILENAME := libcocos2dcpp

#cppファイルの自動検索設定
ifeq ($(HOST_OS),windows)
	CPP_FILES := $(shell dir $(LOCAL_PATH)/../../Classes/*.cpp /b/a-d/s)                   
else
	CPP_FILES := $(shell find $(LOCAL_PATH)/../../Classes -name *.cpp)                   
endif

LOCAL_SRC_FILES := hellocpp/main.cpp
LOCAL_SRC_FILES += $(CPP_FILES:$(LOCAL_PATH)/%=%)

#LOCAL_C_INCLUDES := $(LOCAL_PATH)/../../Classes

#headerフォルダの自動検索設定
ifeq ($(HOST_OS),windows)
	LOCAL_C_INCLUDES := $(shell dir $(LOCAL_PATH)/../../Classes /b/ad/s)                   
else
	LOCAL_C_INCLUDES := $(shell find $(LOCAL_PATH)/../../Classes -type d)                   
endif

ifeq ($(APP_OPTIM),debug)
	LOCAL_CFLAGS := -w -g
endif

LOCAL_WHOLE_STATIC_LIBRARIES := cocos2dx_static
LOCAL_WHOLE_STATIC_LIBRARIES += cocos2dxandroid_static
LOCAL_WHOLE_STATIC_LIBRARIES += cocosdenshion_static
LOCAL_WHOLE_STATIC_LIBRARIES += cocostudio_static
LOCAL_WHOLE_STATIC_LIBRARIES += spine_static

include $(BUILD_SHARED_LIBRARY)

$(call import-add-path,$(COCOS2DX_ROOT))
$(call import-add-path,$(COCOS2DX_ROOT)/cocos)
$(call import-add-path,$(COCOS2DX_ROOT)/external)
$(call import-add-path,$(COCOS2DX_ROOT)/cocos/platform/android)

$(call import-module,.)
$(call import-module,audio/android)
$(call import-module,platform/android)

# この辺はお好みで
# $(call import-module,Box2D)
# $(call import-module,editor-support/cocostudio)
# $(call import-module,editor-support/spine)
# $(call import-module,editor-support/cocosbuilder)
# $(call import-module,network)
# $(call import-module,extensions)


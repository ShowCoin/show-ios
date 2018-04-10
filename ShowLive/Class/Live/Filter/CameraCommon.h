//
//  CameraCommon.h
//  hulucamera
//
//  Created by zhang on 16/1/27.
//  Copyright © 2016年 hulu. All rights reserved.
//

#ifndef CameraCommon_h
#define CameraCommon_h

/**
 * 最大录制时长
 */
#if DEBUG
#define QC_MAX_RECORD_DURATION (10.0)
#else
#define QC_MAX_RECORD_DURATION (10.0)
#endif

#define WSELF_DEFINE __weak typeof(self) wself = self;
#define kScreenRect ([UIScreen mainScreen].bounds)

#ifndef dispatch_main_sync_safe
#define dispatch_main_sync_safe(block)\
if ([NSThread isMainThread]) {\
block();\
}\
else {\
dispatch_sync(dispatch_get_main_queue(), block);\
}
#endif


typedef enum : int {
    QCCameraRecordStatusUnknown = 0,
    QCCameraRecordStatusNormal,
    QCCameraRecordStatusPreparing,
    QCCameraRecordStatusRecording,
    QCCameraRecordStatusEnding,
} /** 录制状态 */ QCCameraRecordStatus;


/**
 * 采集分辨率
 */
#define QC_CAPTURE_SESSION_PRESET_DEFAULT AVCaptureSessionPreset1280x720

/**
 * 压制视频宽
 */
#define QC_VIDEO_ENCODE_WIDTH (540)

/**
 * 压制视频高
 */
#define QC_VIDEO_ENCODE_HEIGHT (960)

/**
 * 帧率
 */
#define QC_VIDEO_FRAMERATE (24.0)

/**
 * 码率
 */
#define QC_VIDEO_BITRATE (QC_VIDEO_ENCODE_WIDTH * QC_VIDEO_ENCODE_HEIGHT * 8/4) // (480*640*8* 1.0)


#endif /* CameraCommon_h */

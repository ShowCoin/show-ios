//
//  ShowPreviewViewController.h
//  ShowLive
//
//  Created by Mac on 2018/4/7.
//  Copyright © 2018年 VNing. All rights reserved.
//

#import "BaseViewController.h"
#import "ShowStream.h"
#import "IosVideoView.h"
#import "GPUImage.h"

#define kSize720p  CGSizeMake(720, 1280)
#define kSize1080p CGSizeMake(1080, 1920)
#define kSize480p  CGSizeMake(368, 640)

@interface ShowPreviewViewController : BaseViewController
{
    GPUImageVideoCamera *videoCamera;
    UIView *faceView;
    
    CIDetector *faceDetector;
    BOOL _faceThinking;

}
@property (nonatomic, weak) BaseViewController *parentVC;
@property(nonatomic, strong, readonly) VideoView *videoView;

@property (nonatomic, assign) BOOL enableWatermask;
@property (nonatomic, assign) BOOL enableBeautyFilter;
@property (nonatomic, assign) BOOL enableTouch;
@property (nonatomic, readonly) BOOL isFrontCamera;
@property (nonatomic, assign) BOOL mute;
@property (nonatomic, assign) ShowLiveRole role;
@property (nonatomic, assign) BOOL manualMode;

@property(nonatomic, assign)  BOOL liveEnded;


//用于回放显示
@property(nonatomic, assign) NSUInteger duration;
@property(nonatomic, assign) uint32_t size;

@property (nonatomic, assign) BOOL hasEnterRoom;

@property (nonatomic, assign)  BOOL isFullScreen;

//开播延迟
@property(nonatomic, assign) uint64_t enterRoomTime;//进入房间时间
@property(nonatomic, assign) uint64_t enterRoomTimeOK;//进入房间时间结束
@property(nonatomic, assign) uint64_t prepareTime;//开始推流时间
@property(nonatomic, assign) uint64_t streamTime;//推流成功时间

@property (nonatomic, strong) void (^close_block)(void);

@property(nonatomic, readonly) UIView *previewView;

- (id)initWithRole:(ShowLiveRole)role;

- (void)initStream;
- (void)swapFrontAndBackCameras;
- (void)pauseStream;
- (void)resumeStream;
- (void)stopStream:(void (^)(void))block;
- (void)stopStream;
- (void)stopStreamWithoutStopGPUImage;

- (void)setCaptureSessionPreset:(NSString *)preset;
- (void)resetCaptureSessionPreset;
- (void)setCaptureSessionPresetForShortVideo;

- (void)setPause:(BOOL)paused;

- (void)seek:(CGFloat)percent;

- (BOOL)isPublisher;
- (void)becomeActive:(BOOL)active;

- (void)openRtmp:(NSString *)rtmp streamID:(int)streamid;

- (void)setBackgroundImage: (UIImage *)image;
- (void)setBackgroundImageWithURL:(NSString *)imageURL;
- (void)lapse:(void (^)(VersRec))completion;

- (void)startLoading;
- (void)stopLoading;

- (void)disposeError:(int)code;

- (void)disposeState:(ShowStreamState)state;

- (void)clearVideoView:(BOOL)animated;
- (void)resetVideoView:(BOOL)animated;

- (unsigned long)milliSecsOfDay;

- (BOOL)openBackgroundMusic:(NSString*)musicFile
                      cycle:(BOOL)cycle;
- (void)mirrorVideo;

//高清与普通切换（高清支持横屏）
- (void)changeHDMode:(NSString *)isHD;
@end

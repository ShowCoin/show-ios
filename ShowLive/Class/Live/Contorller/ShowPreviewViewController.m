//
//  ShowPreviewViewController.m
//  ShowLive
//
//  Created by 周华 on 2018/4/7.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "ShowPreviewViewController.h"
#import "ios/IosVideoView.h"
#import "ShowStream.h"
#import "UIImage+Effects.h"
#import "SDWebImageManager.h"
#import "SDWebImageOperation.h"
#import <sys/time.h>
#import <sys/utsname.h>
#import "GPU_rgb2yuv.h"
#import "GPUImageTextureResizeFilter.h"
#define  GPU_RGB2YUV
 
//#ifdef USE_V2
#import "ZZBeautyFilter_v2.h"
//#else
//#import "ZZBeautyFilter_v3.h"
//#endif

@import CoreTelephony;

static BOOL warnedWWAN = NO;

@interface ShowPreviewViewController (){
    
    GPUImageView *_filterView;
    
//#if defined(USE_V2)
    ZZBeautyFilter_v2 *_beautyFilter;
//#else
//    ZZBeautyFilter_v3 *_beautyFilter;
//#endif
    
    GPUImageTransformFilter  *_transformFilter;
    GPUImageRawDataOutput *_rawDataOutput;
    GPUImageTextureResizeFilter * _resizeFilter;
    GPURGB2YUV            *_rgb2yuvFilter;
    
    CGFloat _beautyLevel;
    
    BOOL _cpuResize; // if ture, GPUImage doesn't resize the output, SDK will do it on CPU, 10% CPU taken
    BOOL _isFrontCamera;
    BOOL _isInit;
    BOOL _isMirror;
    
    ShowStream *stream;
    
    BOOL backgroundSetted;
    id<SDWebImageOperation> _operation;
    
    id _observer0;
    id _observer1;
    NSString *liveUrl;
    
    
    BOOL _connected;
    
    CTCallCenter *_callCenter;
}

@property (nonatomic) CGSize outputSize;
@property(nonatomic, strong) VideoView *videoView;
@property (nonatomic, strong) UIButton *fullScreenButton;
@property(nonatomic, assign) BOOL lapsing;

@property(nonatomic, strong) UIAlertController *alertController;



@end

@implementation ShowPreviewViewController

@synthesize isFrontCamera = _isFrontCamera;

@synthesize previewView =_filterView;

#pragma mark -
#pragma mark Initialization and teardown

- (id)initWithRole:(ShowLiveRole)role{
    
    if (self = [super init]){
        _role = role;
        NSLog(@"Preview init");
        
        stream = [ShowStream sharedInstance];
        liveUrl = nil;
        
        if (![self isPublisher]){
            _videoView = [[VideoView alloc] initWithFrame:self.view.bounds];
            _videoView.alpha = 0;
            _videoView.mode = ViewScaleModeClipToBounds;
            [self.view insertSubview:_videoView atIndex:0];
        }
        
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)dealloc{
    NSLog(@"Preview dealloc");
    [_operation cancel];
    [self resetVideoView];
    if(_observer0!=nil) [[NSNotificationCenter defaultCenter] removeObserver:_observer0];
    if(_observer1!=nil) [[NSNotificationCenter defaultCenter] removeObserver:_observer1];
}

- (void)controllerDidPopped {
    
}

- (void)back{
    if(self.close_block){
        self.close_block();
    }else{
        [self popAnimated:YES];
    }
}
- (BOOL)applicationIdleTimer{
    return YES;
}

#pragma mark - View lifecycle

- (void)popAnimated:(BOOL)animated {
//    [super popAnimated:animated];
    [self stopStream:nil];
}

- (void)viewDidLoad{
    [super viewDidLoad];
    
//    self.disconnectView.blackMode = YES;
//    self.view.backgroundColor = UIColorFromRGB(0x000000);
//    self.enableSwipeGesture = YES;
//    self.enableDisconnectAnimation = !self.isPublisher;
//    self.enableNetworkDetector = YES;
    
    if (!self.manualMode)
        [self setupOutput];
    
    
    if ([self isPublisher]){
        @weakify(self)
        
        if ([self isResignVersion]){
            NSNotificationCenter* nc = [NSNotificationCenter defaultCenter];
            _observer0 = [nc addObserverForName:UIApplicationDidBecomeActiveNotification object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note)
                          {
                              @strongify(self)
                              [self becomeActive:YES];
                          }];
            _observer1 = [nc addObserverForName:UIApplicationWillResignActiveNotification object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note)
                          {
                              @strongify(self)
                              [self becomeActive:NO];
                          }];
        }else{
            NSNotificationCenter* nc = [NSNotificationCenter defaultCenter];
            _observer0 = [nc addObserverForName:UIApplicationWillEnterForegroundNotification object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note)
                          {
                              @strongify(self)
                              [self becomeActive:YES];
                          }];
            _observer1 = [nc addObserverForName:UIApplicationDidEnterBackgroundNotification object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note)
                          {
                              @strongify(self)
                              [self becomeActive:NO];
                          }];
            
            _callCenter = [[CTCallCenter alloc] init];
            _callCenter.callEventHandler = ^(CTCall *call) {
                NSLog(@"call:%@", [call description]);
                if(call.callState == CTCallStateIncoming){
                    @strongify(self)
                    [self becomeActive:NO];
                }else if(call.callState == CTCallStateConnected){
                    @strongify(self)
                    [self becomeActive:NO];
                }else if(call.callState == CTCallStateDisconnected){
                    @strongify(self)
                    [self becomeActive:YES];
                }
            };
        }
        
    }
    
    _isInit = NO;
}

- (BOOL)isResignVersion{
    return YES;
}

- (void)becomeActive:(BOOL)active{
    if (!active){
        if(videoCamera!=nil) [videoCamera pauseCameraCapture];
        if(_filterView!=nil) [_filterView syncActive:NO];
        
    }else{
        if(videoCamera!=nil) [videoCamera resumeCameraCapture];
        if(_filterView!=nil) [_filterView syncActive:YES];
    }
}

- (BOOL)isPublisher{
    return self.role == kShowLiveRolePublisher || self.role == kShowLiveRoleShortVideo;
}

- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    _videoView.frame = self.view.bounds;
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    // Note: I needed to stop camera capture before the view went off the screen in order to prevent a crash from the camera still sending frames
    //    if(self.role == kShowLiveRolePublisher)
    //        [self.output setEnabled:NO];
    
}
- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    // Note: I needed to start camera capture after the view went on the screen, when a partially transition of navigation view controller stopped capturing via viewWilDisappear.
    //    if(self.role == kShowLiveRolePublisher && !self.liveEnded)
    //        [self.output setEnabled:YES];
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)setupOutput{
    
    
    @weakify(self)
    stream.block = ^(ShowStreamState state){
        @strongify(self);
        [self disposeState:state];
    };
    
    stream.error_block = ^(int code){
        @strongify(self)
        
        [self disposeError:code];
    };
    
    if (self.isPublisher){//broadcast
        
        _filterView = [[GPUImageView alloc] initWithFrame:self.view.bounds];
        _filterView.autoresizingMask = ~UIViewAutoresizingNone;
        _filterView.fillMode = kGPUImageFillModePreserveAspectRatioAndFill;
        [self.view insertSubview:_filterView atIndex:0];
        
        [self setupFilter];
    }
}

- (void)setupDataOutput {
    if (_isInit)
        return;
    
    _isInit = YES;
    _isInit = YES;
    [videoCamera setCaptureSessionPreset:videoCamera.captureSessionPreset];
    
    if (_resizeFilter != NULL) {
        [self.output addTarget:_resizeFilter];
    }
    
    [self mirrorVideo];
    
    if (_resizeFilter != NULL) {
        [_resizeFilter addTarget:_transformFilter];
    }
    else {
        [self.output addTarget:_transformFilter];
    }
    
    if (_rgb2yuvFilter != NULL) {
        [_transformFilter addTarget:_rgb2yuvFilter];
        [_rgb2yuvFilter addTarget:_rawDataOutput];
    }
    else {
        [_transformFilter addTarget:_rawDataOutput];
    }
    
    int yuvOutput = _cpuResize ? 0 : 1;
    
    @weakify(_rawDataOutput)
    @weakify(stream)
    @weakify(self)
    [_rawDataOutput setNewFrameAvailableBlock:^{
        @strongify(_rawDataOutput)
        @strongify(stream)
        @strongify(self)
        
        [_rawDataOutput lockFramebufferForReading];
        
        GLubyte *byte = [_rawDataOutput rawBytesForImage];
        NSInteger bytesPerRow = [_rawDataOutput bytesPerRowInOutput];
        [stream push:(void*)byte size:self.outputSize bytePerRow:bytesPerRow pictureFormat:yuvOutput];
        [_rawDataOutput unlockFramebufferAfterReading];
    }];
}

- (void)setBackgroundImageWithURL:(NSString *)imageURL {
    if (!imageURL){
        [self setBackgroundImage:nil];
        return;
    }
    
    @synchronized (self) {
        if(backgroundSetted){
            return;
        }
    }
    
    
}
- (void)setBackgroundImage: (UIImage *)image{
    
    @synchronized (self) {
        if(backgroundSetted){
            return;
        }
        
        backgroundSetted = YES;
    }
    
    image = [image imageByApplyingTintEffectWithColor:[UIColor clearColor]
                                               radius:10];
    
    self.view.contentMode = UIViewContentModeScaleAspectFill;
    self.view.clipsToBounds = YES;
    [self.view.layer setContents:(id)image.CGImage];
}

- (void)setCaptureSessionPreset:(NSString *)preset{
    videoCamera.captureSessionPreset = preset;
}
- (void)resetCaptureSessionPreset{
    
//    if (![UIDevice beforePlatform:4])
        videoCamera.captureSessionPreset = AVCaptureSessionPreset1280x720;
//    else
//        videoCamera.captureSessionPreset = AVCaptureSessionPresetHigh;
}
- (void)setCaptureSessionPresetForShortVideo{
    videoCamera.captureSessionPreset = AVCaptureSessionPreset640x480;
}
- (void)setPause:(BOOL)paused{
    [_filterView syncActive:!paused];
}

- (void)setupFilter
{
    _beautyLevel = 1.f;
    _faceThinking = YES;
    _isFrontCamera = YES;
    _isMirror = NO;
    
    // daiyue:
    // cpuResize is 1: SDK doing the job of resizing the image size,
    // and SDK accept RGBA as input also
    // otherwise: PreviewView doing resize, and output YUV to SDK
    int cpuResize = [ShowStream cloudConfigInt:"ios.push.camera.resize.cpu" def:0];
    _cpuResize = cpuResize == 1 ? YES : NO;
    NSLog(@"Camera cpu resize = %d", _cpuResize);
    
    struct PushStreamConfiguration stmConfiguration = { 0 };
    if (self.role == kShowLiveRolePublisher) {
        // daiyue: move the video configuration to media sdk, only for alive stream pushing
        [ShowStream getPushStreamConfiguration: &stmConfiguration levelTip: 0];
    }
    else {
        bool isLow = false;
        struct utsname systemInfo;
        uname(&systemInfo);
        NSString* machine = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
        if([machine isEqualToString:@"iPhone1,1"])
            isLow = true;
        else if([machine isEqualToString:@"iPhone1,2"])
            isLow = true;
        else if([machine isEqualToString:@"iPhone2,1"])
            isLow = true;
        else if([machine isEqualToString:@"iPhone3,1"])
            isLow = true;
        else if([machine isEqualToString:@"iPhone3,2"])
            isLow = true;
        else if([machine isEqualToString:@"iPhone3,3"])
            isLow = true;
        else if([machine isEqualToString:@"iPhone4,1"])
            isLow = true;
        else if([machine isEqualToString:@"iPhone5,3"])
            isLow = true;
        else if([machine isEqualToString:@"iPhone5,4"])
            isLow = true;
        else if(CGRectGetHeight(self.view.bounds) <= 480.0f)
            isLow = true;
        
        stmConfiguration.width = 368;
        stmConfiguration.height = 640;
        const char* preset = "Preset1280x720";
        
        if (isLow) {
            preset = [ShowStream cloudConfigStr:"ios.push.camera.preset.low" def:"Preset640x480"];
            stmConfiguration.width = [ShowStream cloudConfigInt:"ios.push.camera.width.low" def:480];
            stmConfiguration.height = [ShowStream cloudConfigInt:"ios.push.camera.height.low" def:640];
            stmConfiguration.framerate = [ShowStream cloudConfigInt:"ios.push.camera.framerate" def:20];
        }
        else {
            preset = [ShowStream cloudConfigStr:"ios.push.camera.preset.normal" def:"Preset1280x720"];
            stmConfiguration.width = [ShowStream cloudConfigInt:"ios.push.camera.width.normal" def:368];
            stmConfiguration.height = [ShowStream cloudConfigInt:"ios.push.camera.height.normal" def:640];
            stmConfiguration.framerate = [ShowStream cloudConfigInt:"ios.push.camera.framerate" def:20];
        }
        
        strcpy(stmConfiguration.preset, preset);
    }
    
    _outputSize = CGSizeMake(stmConfiguration.width, stmConfiguration.height);
    NSString* sessionPreset = AVCaptureSessionPreset1280x720;
    
    if (strcmp(stmConfiguration.preset,"Preset640x480") == 0) {
        sessionPreset = AVCaptureSessionPreset640x480;
        if (_cpuResize) {
            _outputSize = CGSizeMake(480, 640);
        }
    }
    else if (strcmp(stmConfiguration.preset,"Preset1280x720") == 0) {
        sessionPreset = AVCaptureSessionPreset1280x720;
        if (_cpuResize) {
            _outputSize = CGSizeMake(720, 1280);
        }
    }
    else if (strcmp(stmConfiguration.preset,"Preset1920x1080") == 0) {
        sessionPreset = AVCaptureSessionPreset1920x1080;
        if (_cpuResize) {
            _outputSize = CGSizeMake(1080, 1920);
        }
    }
    
    NSLog(@"cloudconf camera setting: preset=%s, width=%d, height=%d, framerate=%d, outputw=%f, outputh=%f",
          sessionPreset.UTF8String, stmConfiguration.width, stmConfiguration.height, stmConfiguration.framerate,
          _outputSize.width, _outputSize.height);
    
    //camera
    videoCamera = [[GPUImageVideoCamera alloc] initWithSessionPreset:sessionPreset cameraPosition:AVCaptureDevicePositionFront];
    videoCamera.outputImageOrientation = UIInterfaceOrientationPortrait;
    [videoCamera setFrameRate: stmConfiguration.framerate];
    
    // beaytyFilter
//#ifdef USE_V2
    _beautyFilter = [[ZZBeautyFilter_v2 alloc] init];
//#else
//    _beautyFilter = [[ZZBeautyFilter_v3 alloc] init];
//#endif
    
    // resizeFilter
    if (!_cpuResize) {
        _resizeFilter = [[GPUImageTextureResizeFilter alloc] init];
        [_resizeFilter forceProcessingAtSize:_outputSize];
#if defined(GPU_RGB2YUV)
        //_rawDataOutput and _rgb2yuvFilter
        _rawDataOutput = [[GPUImageRawDataOutput alloc] initWithImageSize:_outputSize
                                                      resultsInBGRAFormat:NO];
        _rgb2yuvFilter = [[GPURGB2YUV alloc] init];
#else
        //_rawDataOutput
        _rawDataOutput = [[GPUImageRawDataOutput alloc] initWithImageSize:_outputSize
                                                      resultsInBGRAFormat:YES];
#endif
    }
    else {
        _rawDataOutput = [[GPUImageRawDataOutput alloc] initWithImageSize:_outputSize
                                                      resultsInBGRAFormat:YES];
    }
    
    // transformFilter
    _transformFilter = [[GPUImageTransformFilter alloc] init];
    
    [self setEnableBeautyFilter:YES withoutTip:YES];
    
    [videoCamera startCameraCapture];
    
    [self updateFilterView];
}
- (void)updateFilterView{
    
    [UIView animateWithDuration:.5f
                          delay:0
         usingSpringWithDamping:.6f
          initialSpringVelocity:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         CATransform3D perspectiveTransform = CATransform3DIdentity;
                         
                         
                         if(_isFrontCamera){
                             perspectiveTransform = CATransform3DRotate(perspectiveTransform, 3.1415926, 0.0, 1.0, 0.0);
                             _filterView.transform = CGAffineTransformMakeScale(-1, 1);
                             
                         }else{
                             perspectiveTransform = CATransform3DRotate(perspectiveTransform, 0.0, 0.0, 1.0, 0.0);
                             _filterView.transform = CGAffineTransformIdentity;
                         }
                         [(GPUImageTransformFilter *)_transformFilter setTransform3D:perspectiveTransform];
                         
                     } completion:^(BOOL finished) {
                         NSLog(@"Camera has changed!!");
                     }];
    
}
#pragma mark --实用
- (GPUImageOutput *)output{
    return _enableBeautyFilter?_beautyFilter:videoCamera;
}

- (void)setMute:(BOOL)mute{
    if(self.role == kShowLiveRolePublisher)
        stream.enableMic = mute;
    else
        stream.mute = mute;
}

- (BOOL)mute{
    if(self.role == kShowLiveRolePublisher)
        return stream.enableMic;
    else
        return stream.mute;
}

- (BOOL)enableTouch{
    NSError *error = nil;
    
    if ([videoCamera.inputCamera lockForConfiguration:&error]) {
        if ([videoCamera.inputCamera isTorchModeSupported:AVCaptureTorchModeOn]) {
            return videoCamera.inputCamera.torchMode == AVCaptureTorchModeOn;
        }
        [videoCamera.inputCamera unlockForConfiguration];
    }
    return NO;
}

- (void)setEnableTouch:(BOOL)enableTouch {
    if (enableTouch) { // 打开闪光灯
        if (_isFrontCamera) { // 打开前置闪光灯
            
        } else { // 打开后置闪光灯
            NSError *error = nil;
            if ([videoCamera.inputCamera lockForConfiguration:&error]) {
                if ([videoCamera.inputCamera isTorchModeSupported:AVCaptureTorchModeOn]) {
                    videoCamera.inputCamera.torchMode = AVCaptureTorchModeOn;
                }
                [videoCamera.inputCamera unlockForConfiguration];
            } else {
                // TODO: error
            }
        }
    } else { // 关闭闪光灯
        if (_isFrontCamera) { // 关闭前置闪光灯
            
        } else { // 关闭后置闪光灯
            NSError *error = nil;
            if ([videoCamera.inputCamera lockForConfiguration:&error]) {
                if ([videoCamera.inputCamera isTorchModeSupported:AVCaptureTorchModeOff]) {
                    videoCamera.inputCamera.torchMode = AVCaptureTorchModeOff;
                }
                [videoCamera.inputCamera unlockForConfiguration];
            } else {
                // TODO: error
            }
        }
    }
}


- (void)setEnableBeautyFilter:(BOOL)enableBeautyFilter withoutTip:(BOOL)without{
    
    if (!without) {
//        [LBProgressView showMessage:enableBeautyFilter ? @"美颜已开启" : @"美颜已关闭"
//                              image:enableBeautyFilter ? ImageNamed(@"r_ios_prompt_beauty") : ImageNamed(@"r_ios_prompt_beauty_close")];
    }
    
    if (!(_enableBeautyFilter = enableBeautyFilter)) {
        [_beautyFilter removeTarget:_filterView];
        [videoCamera addTarget:_filterView];
        
        if (_resizeFilter != NULL) {
            [_beautyFilter removeTarget:_resizeFilter];
            [videoCamera addTarget:_resizeFilter];
        }
        else {
            [_beautyFilter removeTarget:_transformFilter];
            [videoCamera addTarget:_transformFilter];
        }
    }
    else {
        [videoCamera removeTarget:_filterView];
        [videoCamera addTarget:_beautyFilter];
        [_beautyFilter addTarget:_filterView];
        
        if (_resizeFilter != NULL) {
            [videoCamera removeTarget:_resizeFilter];
            [_beautyFilter addTarget:_resizeFilter];
        }
        else {
            [videoCamera removeTarget:_transformFilter];
            [_beautyFilter addTarget:_transformFilter];
        }
    }
    
    [self.output setEnabled:YES];
}

- (void)mirrorVideo {
    _isMirror = !_isMirror;
    
    CATransform3D perspectiveTransform = CATransform3DIdentity;
    if(_isFrontCamera && _isMirror)
        perspectiveTransform = CATransform3DRotate(perspectiveTransform, M_PI, 0.0, 1.0, 0.0);
    else
        perspectiveTransform = CATransform3DRotate(perspectiveTransform, 0.0, 0.0, 1.0, 0.0);
    
    [(GPUImageTransformFilter *)_transformFilter setTransform3D:perspectiveTransform];
}

- (void)setEnableBeautyFilter:(BOOL)enableBeautyFilter {
    [self setEnableBeautyFilter:enableBeautyFilter withoutTip:NO];
}



- (void)swapFrontAndBackCameras {
    // Assume the session is already running
    [videoCamera rotateCamera];
    _isFrontCamera = !_isFrontCamera;
    
//    [LBProgressView showMessage:@"切换摄像头" image:ImageNamed(@"r_ios_prompt_camera_change")];
    
    [self updateFilterView];
}
- (void)initStream{
    
    [self performSelectorOnMainThread:@selector(setupOutput) withObject:nil waitUntilDone:YES];
}
- (void)pauseStream{
    [stream pause];
}
- (void)resumeStream{
    [stream resume];
}

- (void)stopStream{
    [self stopStream:nil];
    
}
- (void)stopStreamWithoutStopGPUImage{
    [stream close:liveUrl block:nil];
    [self.videoView setStreamId:-1];
}
- (void)seek:(CGFloat)percent{
    [stream seek:percent];
}

- (void)resetVideoView{
    
    if(_videoView != nil) {
        NSLog(@"VideoView Remove");
        [_videoView removeFromSuperview];
        _videoView = nil;
    }
}

- (void)stopStream:(void (^)(void))block{
    [self stopLoading];
    
    stream.block = nil;
    stream.error_block = nil;
    
    [stream close:liveUrl block:block];
    if (videoCamera != nil) {
        [videoCamera stopCameraCapture];
        videoCamera = nil;
    }
    [self.videoView setStreamId:-1];
}
#pragma mark - ————————————直播 开始拉流————————————
- (void)openRtmp:(NSString *)rtmp streamID:(int)streamid{
    NSLog(@"openRtmp streamid = %d, %@",streamid, _videoView);
    
    if(self.prepareTime == 0)
        self.prepareTime = [self milliSecsOfDay];
    
    if (![rtmp isKindOfClass:[NSString class]]
        || rtmp.length <= 0){
        //"主播失踪了，视频也跟着主播跑了
        return;
    }
    
    
    liveUrl =  [[NSString alloc] initWithString:rtmp];
    
    if(self.isPublisher){
        [self setupDataOutput];
    }
    
    
    [self.videoView setStreamId:streamid];
    [stream open:rtmp role:self.role streamID:streamid completion:^{

    }];
    
}

- (void)show4GWarning: (NSString *)rtmp stream:(int)streamid {
    
    if (_alertController) return;
    
    _alertController = [UIAlertController alertControllerWithTitle:nil
                                                           message:@"非WIFI环境下会消耗流量,是否继续"
                                                    preferredStyle:UIAlertControllerStyleAlert];
    
    
    @weakify(self)
    [_alertController addAction:[UIAlertAction actionWithTitle:@"取消"
                                                         style:UIAlertActionStyleCancel
                                                       handler:^(UIAlertAction *action) {
                                                           @strongify(self);
                                                           [self.alertController dismissViewControllerAnimated:NO completion:nil];
                                                           
                                                           self.alertController = nil;
                                                           
                                                           [self back];
                                                           
                                                       }]];
    
    @weakify(stream)
    [_alertController addAction:[UIAlertAction actionWithTitle:@"继续"
                                                         style:UIAlertActionStyleDefault
                                                       handler:^(UIAlertAction *action) {
                                                           @strongify(stream);
                                                           [self.alertController dismissViewControllerAnimated:NO completion:nil];
                                                           self.alertController = nil;
                                                           
                                                           self.videoView.streamId = streamid;
                                                           [stream open:rtmp role:self.role streamID:streamid completion:^{

                                                           }];
                                                           
                                                           @synchronized (self) {
                                                               warnedWWAN = YES;
                                                           }
                                                       }]];
    
    [self.parentVC presentViewController:self.alertController animated:YES completion:nil];
}

#pragma mark --
#pragma mark -- 直播间动画

- (void)stopLoading{

}
- (void)startLoading{

}

- (void)clearVideoView:(BOOL)animated{
    [UIView animateWithDuration:animated?0.1f:0
                     animations:^{
                         self.videoView.alpha = 0;
                         self.fullScreenButton.alpha = 0;
                     } completion:^(BOOL finished) {

                     }];
}

- (void)resetVideoView:(BOOL)animated{
    [UIView animateWithDuration:animated?0.1f:0
                     animations:^{
                         self.videoView.alpha = 1;
                         self.fullScreenButton.alpha = 1;
                     } completion:^(BOOL finished) {
                         
                     }];
    if (self.fullScreenButton) {
        //确保显示正确
        _videoView.mode = ViewScaleModeAspectFit;
        _videoView.rotation = ViewRotation0;
    }
}

- (void)networkStatusChanged:(AFNetworkReachabilityStatus)status{

    _videoView.hidden = (status == AFNetworkReachabilityStatusNotReachable);
    

    if (status == AFNetworkReachabilityStatusNotReachable) {
        if (self.isFullScreen) {

        }
    }
}

- (void)disposeError:(int)code {
    
}
- (void)disposeState:(ShowStreamState)state {
    dispatch_async(dispatch_get_main_queue(), ^{
        
        switch (state){
            case kShowStreamStateUninit:
            case kShowStreamStateClosed:
            {
                //                [[UIApplication sharedApplication] setIdleTimerDisabled:NO];
                //   [strong_self hasLoading];
                if (self.hasEnterRoom)
                    return;
                
                [self clearVideoView:YES];
            }
                break;
            case kShowStreamStateCacheOrPause:{
                //                //TODO: 待测
                //                if (!self.isPublisher)
                //                    [strong_self startLoading];
            }
                break;
            case kShowStreamStateConnect:
            {
                if (!self.isPublisher && !_connected)
                    [self startLoading];
                
                _connected = YES;
            }
                break;
            case kShowStreamStateLive:
            {
                [self stopLoading];
                [[UIApplication sharedApplication] setIdleTimerDisabled:YES];
            }
                break;
            case kShowStreamStateBeginLive:
            {
                self.streamTime = [self milliSecsOfDay];
                
                if (!self.isPublisher){
                    [self resetVideoView:YES];
                    [self stopLoading];
                    
                }
                [[UIApplication sharedApplication] setIdleTimerDisabled:YES];
            }
                break;
            case kShowStreamStateBitrateLow:
            {
                if(self.isPublisher){

                }else{

                    if (self.isFullScreen) {
                        
                    }
                }
            }
                break;
            default:
                break;
        }
        
    });
}

static  inline unsigned long miliSecsOfDay(){
    struct timeval tv ;
    gettimeofday(&tv, NULL);
    
    return (unsigned long) (tv.tv_sec * 1000 + tv.tv_usec / 1000);
};

- (unsigned long)milliSecsOfDay {
    return miliSecsOfDay();
}

- (BOOL)openBackgroundMusic:(NSString*)musicFile
                      cycle:(BOOL)cycle{
    return [stream openBackgroundMusic:musicFile cycle:cycle];
}


#pragma mark - 高清-横屏
- (void)changeHDMode:(NSString *)isHD {
    if ([isHD isEqualToString:@"Y"]) {
        NSLog(@"================高清");
        _videoView.mode = ViewScaleModeAspectFit;
        _videoView.rotation = ViewRotation0;
        [self showFullScreenButton];
    }
    else {
        NSLog(@"================普通");
        _videoView.mode = ViewScaleModeClipToBounds;
        _videoView.rotation = ViewRotationAuto;
        if (_fullScreenButton) {
            [_fullScreenButton removeFromSuperview];
            _fullScreenButton = nil;
        }
    }
}

- (void)showFullScreenButton {
    if (_fullScreenButton == nil) {
        UIImage *fullImage = [UIImage imageNamed:@"r_ios_live_full"];
        CGFloat buttonY = self.videoView.center.y - CGRectGetWidth(self.videoView.frame) * 9 / 16.0 / 2.0 + 5;
        _fullScreenButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _fullScreenButton.frame = CGRectMake(CGRectGetWidth(self.videoView.frame) - fullImage.size.width - 10, buttonY, fullImage.size.width, fullImage.size.height);
        [_fullScreenButton setImage:fullImage forState:UIControlStateNormal];
        [_fullScreenButton addTarget:self action:@selector(fullScreenModel) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:_fullScreenButton];
    }
    _fullScreenButton.alpha = self.videoView.alpha;
}

- (void)fullScreenModel{
    
    self.isFullScreen = YES;
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
    [self switchLandscapeMode];
}

- (void)recoverNormalMode {
    self.isFullScreen = NO;
    self.videoView.frame = self.view.bounds;
    
    [self switchLandscapeMode];
    [self.view insertSubview:self.videoView atIndex:0];
}

- (void)switchLandscapeMode {
    if (_videoView.mode == ViewScaleModeAspectFit) {
        _videoView.mode = ViewScaleModeClipToBounds;
        _videoView.rotation = ViewRotationAuto;
    }
    else {
        _videoView.mode = ViewScaleModeAspectFit;
        _videoView.rotation = ViewRotation0;
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

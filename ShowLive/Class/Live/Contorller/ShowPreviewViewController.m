//
//  ShowPreviewViewController.m
//  ShowLive
//
//  Created by Mac on 2018/4/7.
//  Copyright © 2018年 VNing. All rights reserved.
//

#import "ShowPreviewViewController.h"
#import "ios/IosVideoView.h"
#import "UIImage+Effects.h"
#import "SDWebImageManager.h"
#import "SDWebImageOperation.h"
#import <sys/time.h>
#import <sys/utsname.h>
#import <GLKit/GLKit.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <Photos/PhotosDefines.h>
#import <AVFoundation/AVFoundation.h>
#import <Photos/Photos.h>
@import CoreTelephony;

@interface ShowPreviewViewController ()<AVCaptureVideoDataOutputSampleBufferDelegate, AVCaptureAudioDataOutputSampleBufferDelegate,AVAudioPlayerDelegate>{
    BOOL    _cpuResize; // if ture, GPUImage doesn't resize the output, SDK will do it on CPU, 10% CPU taken
    BOOL    _isInit;
    ShowStream *stream;
    BOOL    backgroundSetted;
    id _observer0;
    id _observer1;
    NSString *liveUrl;
    BOOL _connected;
    BOOL _openPush;
    CTCallCenter *_callCenter;
    BOOL capturePaused;
}

@property (nonatomic) CGSize outputSize;
@property(nonatomic, strong) VideoView *videoView;
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
        
        if (![self isPublisher])//如果不是主播添加播放器
        {
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
    [self stopStream:nil];
}

- (void)viewDidLoad{
    [super viewDidLoad];
    
    if (!self.manualMode)
        [self setupOutput];
    if ([self isPublisher]){
        self.view.frame = [UIScreen mainScreen].bounds;
        self.view.backgroundColor = [UIColor clearColor];
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
//网络监测
- (void)networkStatusChanged:(AFNetworkReachabilityStatus)status{
    _videoView.hidden = (status == AFNetworkReachabilityStatusNotReachable);
    if (status == AFNetworkReachabilityStatusNotReachable) {
        
    }
}
//背景图片.在没有显示视频前显示
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
    image = [image imageByApplyingTintEffectWithColor:[UIColor clearColor] radius:10];
    self.view.contentMode = UIViewContentModeScaleAspectFill;
    self.view.clipsToBounds = YES;
    [self.view.layer setContents:(id)image.CGImage];
}

- (BOOL)isResignVersion{
    return YES;
}
//切换后台
- (void)becomeActive:(BOOL)active{
    if (!active){
        capturePaused =YES;
    }else{
        capturePaused =NO;
    }
}
- (BOOL)isPublisher{
    return self.role == kShowLiveRolePublisher;
}

- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    _videoView.frame = self.view.bounds;
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}
- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
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
    if (self.isPublisher){//如果是主播,创建相机开始采集
        [self initCamera];
    }
}
#pragma mark - ————————————直播 开始推流————————————
- (void)setupDataOutput:(CMSampleBufferRef)bytes {
    if (_isInit)
        return;
    //将buffer转化为char * 进行推流
    CVImageBufferRef imageBuffer = NULL;
    UInt8 *bufferPtr =nil;
    imageBuffer = CMSampleBufferGetImageBuffer(bytes);
    if(imageBuffer && CVPixelBufferLockBaseAddress(imageBuffer, 0) == kCVReturnSuccess)
    {
        bufferPtr= (UInt8*)CVPixelBufferGetBaseAddress(imageBuffer);
    }
    _isInit = YES;
    int yuvOutput = _cpuResize ? 0 : 1;
    
    [stream push:(void*)bufferPtr size:self.outputSize bytePerRow:CVPixelBufferGetBytesPerRow(imageBuffer) pictureFormat:yuvOutput];
}
#pragma mark --实用
//静音
- (BOOL)mute{
    if(self.role == kShowLiveRolePublisher)
        return stream.enableMic;
    else
        return stream.mute;
}
- (void)setMute:(BOOL)mute{
    if(self.role == kShowLiveRolePublisher)
        stream.enableMic = mute;
    else
        stream.mute = mute;
}

- (BOOL)enableTouch{
    return NO;
}
//闪光灯
- (void)setEnableTouch:(BOOL)enableTouch {
    if (enableTouch) { // 打开闪光灯
        if (_isFrontCamera) { // 打开前置闪光灯
            
        } else { // 打开后置闪光灯
        }
    } else { // 关闭闪光灯
        if (_isFrontCamera) { // 关闭前置闪光灯
            
        } else { // 关闭后置闪光灯
            
        }
    }
}

//初始化直播sdk
- (void)initStream{
    [self performSelectorOnMainThread:@selector(setupOutput) withObject:nil waitUntilDone:YES];
}
//直播暂停
- (void)setPause:(BOOL)paused{
    [stream pause];
}
- (void)pauseStream{
    [stream pause];
}
//重置
- (void)resumeStream{
    [stream resume];
}
//停止推拉流
- (void)stopStream{
    [self stopStream:nil];
}
- (void)stopStream:(void (^)(void))block{
    stream.block = nil;
    stream.error_block = nil;
    [stream close:liveUrl block:block];
    [self.videoView setStreamId:-1];
}
//停止sdk 关闭相机
- (void)stopStreamWithoutStopCamera{
    [stream close:liveUrl block:nil];
    [self.videoView setStreamId:-1];
}
- (void)seek:(CGFloat)percent{
    [stream seek:percent];
}
//重置播放器
- (void)resetVideoView{
    if(_videoView != nil) {
        NSLog(@"VideoView Remove");
        [_videoView removeFromSuperview];
        _videoView = nil;
    }
}
- (void)clearVideoView:(BOOL)animated{
    [UIView animateWithDuration:animated?0.1f:0
                     animations:^{
                         self.videoView.alpha = 0;
                     } completion:^(BOOL finished) {
                         
                     }];
}

- (void)resetVideoView:(BOOL)animated{
    [UIView animateWithDuration:animated?0.1f:0
                     animations:^{
                         self.videoView.alpha = 1;
                     } completion:^(BOOL finished) {
                         
                     }];
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
        _openPush = YES;
    }
    [self.videoView setStreamId:streamid];
    [stream open:rtmp role:self.role streamID:streamid completion:^{
        
    }];
    
}
//直播流状态监测
- (void)disposeError:(int)code {
    //失败
}
- (void)disposeState:(ShowStreamState)state {
    dispatch_async(dispatch_get_main_queue(), ^{
        
        switch (state){
            case kShowStreamStateUninit:
            case kShowStreamStateClosed:
            {
                if (self.hasEnterRoom)
                    return;
                
                [self clearVideoView:YES];
            }
                break;
            case kShowStreamStateCacheOrPause:{
            }
                break;
            case kShowStreamStateConnect:
            {
                if (!self.isPublisher && !_connected)
                    
                    _connected = YES;
            }
                break;
            case kShowStreamStateLive:
            {
                [[UIApplication sharedApplication] setIdleTimerDisabled:YES];
            }
                break;
            case kShowStreamStateBeginLive:
            {
                self.streamTime = [self milliSecsOfDay];
                
                if (!self.isPublisher){
                    [self resetVideoView:YES];
                }
                [[UIApplication sharedApplication] setIdleTimerDisabled:YES];
            }
                break;
            case kShowStreamStateBitrateLow:
            {
                if(self.isPublisher){
                    
                }else{
                    
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
    }
    else {
        NSLog(@"================普通");
        _videoView.mode = ViewScaleModeClipToBounds;
        _videoView.rotation = ViewRotationAuto;
    }
}

#pragma mark - 相机采集
- (void)initCamera{
    
    
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


//
//  SLPushManager.m
//  ShowLive
//
//  Created by WorkNew on 2018/4/16.
//  Copyright © 2018年 VNing. All rights reserved.
//


#import "SLPushManager.h"

#import <GLKit/GLKit.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <Photos/PhotosDefines.h>
#import <AVFoundation/AVFoundation.h>
#import <Photos/Photos.h>
#import <MKEngine/FM2.h>
@interface SLPushManager()<AVCaptureVideoDataOutputSampleBufferDelegate, AVCaptureAudioDataOutputSampleBufferDelegate,AVAudioPlayerDelegate,GLKViewDelegate>
{
    
    
    CGFloat screen_w_;
    CGFloat screen_h_;
    BOOL is_enter_back_ground;//进入后台
    
    //实时速率
    unsigned int _speed;
    //提示信息
    NSString *_tips;
    //开始推流时间
    double _startTime;
    AVCaptureDevicePosition camera_position;
    CNCRecordVideoType store_type;
    BOOL is_long_store;
    BOOL has_show_in_front_view;
    NSInteger sei_question_index;
    
    FM2 *m_pFM2;
    int                   videoWidth;
    int                   videoHeight;
    
}
// UI上的一些操作控件或视图
@property (nonatomic, retain) CNCVideoSourceInput *src_input;
@property(nonatomic) BOOL is_pushing;


@property (nonatomic, retain) NSLock *lock_oprt;
@property(nonatomic, strong) AVCaptureDevice *backCameraDevice;
@property(nonatomic, strong) AVCaptureDevice *frontCameraDevcie;
@property(nonatomic, strong) AVCaptureDevice *currentCameraDevcie;
@property(nonatomic, strong) AVCaptureSession *captureSession;
@property(nonatomic, strong) GLKView *displayView;//显示glkview
@property(nonatomic, strong) AVCaptureVideoDataOutput *videoOutput;
@property(nonatomic, strong) dispatch_queue_t videoQueue;
@property(nonatomic, strong) AVCaptureDeviceInput *currentCameraInput;
@property (nonatomic,assign)int isMirrored;
@property(nonatomic,assign)BOOL isBeautify;



@end
static SLPushManager *instance = nil;

#define SCENENAME @"fm2"

@implementation SLPushManager


+ (instancetype)shareInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        instance = [[SLPushManager alloc]init];
        
    });
    
    return instance;
}


- (instancetype)init
{
    if (self = [super init]) {
        
        [self register_sdk];
        
        _isBeautify = YES;
        _isMirrored = YES;
        
        screen_w_ = 540;
        screen_h_ = 960;
    }
    return self;
}



//网宿推流注册
-(void)register_sdk
{
    NSString *app_id = @"souyu";
    NSString *auth_key = @"871D27E7EB9C4C01912903B732F27303";
    [CNCMobStreamSDK regist_app:app_id auth_key:auth_key];
}
//设置配置

-(void)setupConfig:(NSString*)rtmp;
{
    NSInteger bit = (IsStrEmpty([SLSystemConfigModel shared].bitrate))?800:[[SLSystemConfigModel shared].bitrate integerValue];
    NSInteger fps = (IsStrEmpty([SLSystemConfigModel shared].frame))?20:[[SLSystemConfigModel shared].frame integerValue];
    
    CNCVideoSourceCfg *para = [[CNCVideoSourceCfg alloc] init];
    para.rtmp_url = rtmp;
    para.encoder_type = CNC_ENM_Encoder_HW; //硬编
    para.video_bit_rate = bit;        //码率
    para.video_fps = fps;              //帧率
    para.is_adaptive_bit_rate = NO; //码率自适应
    para.video_height = screen_h_;
    para.video_width =screen_w_;
    
    self.lock_oprt = [[NSLock alloc] init];
    
    CNCVideoSourceInput *src = [[CNCVideoSourceInput alloc] init];
    [src preset_para:para];
    
    self.src_input = src;
    [self.src_input start_audio_by_collect_type:YES];
    [self.src_input set_whether_continue_push_inBk:YES];
    
}

#pragma mark 采集源处理
-(void)startCarema
{
    self.videoQueue = dispatch_queue_create("sample buffer delegate", DISPATCH_QUEUE_SERIAL);
    NSError *error;
    self.captureSession = [[AVCaptureSession alloc] init];
    
    for(AVCaptureDevice *device in [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo]) {
        if(device.position == AVCaptureDevicePositionBack) {
            self.backCameraDevice = device;
        } else if(device.position == AVCaptureDevicePositionFront) {
            self.frontCameraDevcie = device;
        }
        
        [device lockForConfiguration:&error];
        device.exposureMode = AVCaptureExposureModeContinuousAutoExposure;
        [device unlockForConfiguration];
    }
    //添加摄像头
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:self.frontCameraDevcie error:&error];
    self.currentCameraInput = input;
    if([self.captureSession canAddInput:input]) {
        [self.captureSession addInput:input];
    }
    self.currentCameraDevcie = self.frontCameraDevcie;
    //添加摄像头输出
    self.videoOutput = [[AVCaptureVideoDataOutput alloc] init];
    
    
    ////////  kCVPixelFormatType_32BGRA ; kCVPixelFormatType_420YpCbCr8BiPlanarFullRange
    self.videoOutput.videoSettings =[NSDictionary dictionaryWithObject:@(kCVPixelFormatType_32BGRA)
                                                                forKey:(id)kCVPixelBufferPixelFormatTypeKey];
    
    
    
    [self.videoOutput setSampleBufferDelegate:self queue:self.videoQueue];
    if([self.captureSession canAddOutput:self.videoOutput]) {
        [self.captureSession addOutput:self.videoOutput];
    }
    
    self.captureSession.sessionPreset = AVCaptureSessionPresetiFrame960x540;
    //视频连接
    AVCaptureConnection *captureConnection = [self.videoOutput connectionWithMediaType:AVMediaTypeVideo];
    if ([captureConnection isVideoOrientationSupported])
    {
        AVCaptureVideoOrientation orientation = AVCaptureVideoOrientationPortrait;
        [captureConnection setVideoOrientation:orientation];
        [captureConnection setVideoMirrored:YES];
    }
    [self setFrameRate:30];
    [self.captureSession commitConfiguration];
    
    [self.lock_oprt lock];
    
    dispatch_queue_t sessionQueue = self.videoQueue;
    dispatch_async(sessionQueue, ^(void) {
        [self.captureSession startRunning];
    });
    
    [self.lock_oprt unlock];
    
    //创建场景
    [self initializeMKEngine];
    
    
    
}
-(void) setFrameRate:(int)rate;
{
    if ([self.currentCameraDevcie respondsToSelector:@selector(activeVideoMinFrameDuration)]) {
        [self.currentCameraDevcie lockForConfiguration:nil];
        self.currentCameraDevcie.activeVideoMinFrameDuration = CMTimeMake(1, rate);
        self.currentCameraDevcie.activeVideoMaxFrameDuration = CMTimeMake(1, rate);
        [self.currentCameraDevcie unlockForConfiguration];
        
    }else{
        AVCaptureConnection *conn = [[_captureSession.outputs lastObject] connectionWithMediaType:AVMediaTypeVideo];
        if (conn.supportsVideoMinFrameDuration)
            conn.videoMinFrameDuration = CMTimeMake(1,rate);
        if (conn.supportsVideoMaxFrameDuration)
            conn.videoMaxFrameDuration = CMTimeMake(1,rate);
        
    }
}

-(void)startBeautify
{
    _isBeautify = YES;
    NSString * path = [[NSBundle mainBundle] pathForResource:@"faceBeautify" ofType:@"bundle"];
    [m_pFM2 setEffect:path Name:SCENENAME resID:1 resType:1];
}

-(void)clearBeautify
{
    _isBeautify = NO;
    [m_pFM2 clearEffectName:SCENENAME resID:1];
}
-(BOOL)beautifyOpen
{
    return _isBeautify;
}

-(void)stopCarema
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self stop_capture];
        
    });
}


//初始化preview
-(void)startPreview:(UIView*)view
{
    EAGLContext *t_mkContext = [m_pFM2 getContext];
    [EAGLContext setCurrentContext:t_mkContext];
    self.displayView = [[GLKView alloc] initWithFrame:[UIScreen mainScreen].bounds context:t_mkContext];
    [self.displayView setDelegate:self];
    [self.displayView setDrawableColorFormat:GLKViewDrawableColorFormatRGBA8888];
    [self.displayView setEnableSetNeedsDisplay:NO];
    [self.displayView setBackgroundColor:[UIColor clearColor]];
    [view insertSubview:self.displayView atIndex:0];
    
}

//开始推流
-(void)startPush
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        [self addObservers];
        [self.src_input start_push];
        self.is_pushing = YES;
    });
}

// 停止推流
-(void)stopPush
{
    
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        
        [self.src_input stop_push];
        self.is_pushing = NO;
        [self removeObservers];
        
    });
    
}


// 暂停推流，退到后台时调用
-(void)pause
{
    is_enter_back_ground = YES;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self stop_capture];
    });
}
// 恢复推流，回到前台时调用
-(void)resume
{
    is_enter_back_ground = NO;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self re_start_capture];
    });
}

-(void)switchCamera
{
    if(self.currentCameraDevcie == self.frontCameraDevcie) {
        
        NSError *error;
        AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:self.backCameraDevice error:&error];
        [self.captureSession removeInput:self.currentCameraInput];
        
        if([self.captureSession canAddInput:input]) {
            [self.captureSession addInput:input];
            self.currentCameraInput = input;
            
            self.currentCameraDevcie = self.backCameraDevice;
        }
        self.isMirrored = NO;
        
    } else {
        NSError *error;
        AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:self.frontCameraDevcie error:&error];
        [self.captureSession removeInput:self.currentCameraInput];
        
        if([self.captureSession canAddInput:input]) {
            [self.captureSession addInput:input];
            self.currentCameraInput = input;
            
            self.currentCameraDevcie = self.frontCameraDevcie;
        }
        
        self.isMirrored = YES;
    }
    
    AVCaptureConnection *captureConnection = [self.videoOutput connectionWithMediaType:AVMediaTypeVideo];
    if ([captureConnection isVideoOrientationSupported])
    {
        AVCaptureVideoOrientation orientation = AVCaptureVideoOrientationPortrait;
        [captureConnection setVideoOrientation:orientation];
        [captureConnection setVideoMirrored:self.isMirrored];
    }
    
    
}
//切换镜像
-(void)switchMirror
{
    
    if(self.currentCameraDevcie == self.backCameraDevice) {
        [self switchCamera];
    }else
    {
        self.isMirrored = !self.isMirrored;
        [m_pFM2 setSceneMirror:SCENENAME Mirror:self.isMirrored];
        
    }
}


- (void)stop_capture {
    
    [self.lock_oprt lock];
    
    BOOL isRunning = self.captureSession.isRunning;
    
    if (isRunning) {
        [self.captureSession stopRunning];
    }
    
    [self.lock_oprt unlock];
    
}

- (void)re_start_capture {
    [self.lock_oprt lock];
    
    BOOL isRunning = self.captureSession.isRunning;
    
    if (!isRunning) {
        [self.captureSession startRunning];
    }
    [self.lock_oprt unlock];
}

- (void)initializeMKEngine {
    
    //创建fm2对象
    m_pFM2 = [FM2 new];
    //初始化引擎
    [m_pFM2 fm2Init:NULL Version:2];
    //设置资源路径
    NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"res" ofType:@"bundle"];
    bundlePath = [NSString stringWithFormat:@"%@/",bundlePath];
    [m_pFM2 addSearchPath:bundlePath];
    //开启引擎
    [m_pFM2 startEngine:FMDetectTypeFP];
    //开启直接绘制模式 主要用于测试 便于观察
    [m_pFM2 enableDDrawMode:true];
    
    //
    [m_pFM2 enablePixelBuffer];
    //
    
    //创建一个场景
    float t_scale = [UIScreen mainScreen].nativeScale;
    
    //  float t_sceneWidth = [UIScreen mainScreen].bounds.size.width*t_scale;
    float t_sceneHeight = [UIScreen mainScreen].bounds.size.height*t_scale;
    [m_pFM2 createScene:SCENENAME outInputTex:0 sceneWidth:t_sceneHeight*0.5625 sceneHeight:t_sceneHeight texWidth:screen_w_ texHeight:screen_h_ mirrored:self.isMirrored];
    
    //开启美颜
    [self startBeautify];
    
    //设置输出流格式
    [m_pFM2 setInputFormat:FMPixelFormatBGRA Width:screen_w_ Height:screen_h_ Angle:0 Name:SCENENAME];
    //
    [m_pFM2 drawTestPt:SCENENAME];
    
}

#pragma mark glkview delegate
- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect{
    EAGLContext *t_mkContext = [m_pFM2 getContext];
    if (t_mkContext) {
        float t_scale = [UIScreen mainScreen].nativeScale;
        int t_sceneWidth = [UIScreen mainScreen].bounds.size.width*t_scale;
        int t_sceneHeight = [UIScreen mainScreen].bounds.size.height*t_scale;
        [m_pFM2 drawTestWidth:t_sceneWidth Height:t_sceneHeight Name:SCENENAME];
    }
}
#pragma mark capture delegate
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection
{
    if (!self.captureSession.isRunning)
    {
        return;
    }
    
    [self.lock_oprt lock];
    BOOL isVideo = YES;
    if (captureOutput != self.videoOutput) {
        isVideo = NO;
    }
    if (captureOutput == self.videoOutput) {
        
        [self processMKEngine:sampleBuffer];
        
    }
    
    [self.lock_oprt unlock];
    
}

- (void)processMKEngine:(CMSampleBufferRef)sampleBuffer{
    CVPixelBufferRef imageBuffer = NULL;
    imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer);
    if(CVPixelBufferLockBaseAddress(imageBuffer, 0) == kCVReturnSuccess)
    {
        GASYUVFrame yuvFrame;
        yuvFrame.param = imageBuffer;
        size_t width = CVPixelBufferGetWidth(imageBuffer);
        size_t height = CVPixelBufferGetHeight(imageBuffer);
        int pixelFormat = CVPixelBufferGetPixelFormatType(imageBuffer);
        if (pixelFormat == kCVPixelFormatType_32BGRA) {
            UInt8 *bufferPtr = (UInt8*)CVPixelBufferGetBaseAddress(imageBuffer);
            yuvFrame.plane[0] = bufferPtr;
            yuvFrame.width = (int32_t)width;
            yuvFrame.height = (int32_t)height;
            yuvFrame.format = FMPixelFormatBGRA;
            yuvFrame.bytesPerRow = CVPixelBufferGetBytesPerRow(imageBuffer);
        }else if(pixelFormat == kCVPixelFormatType_420YpCbCr8BiPlanarFullRange){
            
            UInt8 *bufferPtr = (UInt8 *)CVPixelBufferGetBaseAddressOfPlane(imageBuffer,0);
            UInt8 *bufferPtr1 = (UInt8 *)CVPixelBufferGetBaseAddressOfPlane(imageBuffer,1);
            yuvFrame.plane[0] = bufferPtr;
            yuvFrame.plane[1] = bufferPtr1;
            yuvFrame.width = (int32_t)width;
            yuvFrame.height = (int32_t)height;
            yuvFrame.format = FMPixelFormatYUV420V;
            yuvFrame.bytesPerRow = CVPixelBufferGetBytesPerRow(imageBuffer);
        }
        
        //推送相机图片
        NSInteger pushCameraTime = [[NSNumber numberWithDouble:[[NSDate date] timeIntervalSince1970]*1000] integerValue];
        
        [self->m_pFM2 pushCameraPixelBuffer:imageBuffer Name:SCENENAME Length:(int)(width*height*4)  WithHandle:nil];
        
//
//        NSInteger handleBufferTime = [[NSNumber numberWithDouble:[[NSDate date] timeIntervalSince1970]*1000] integerValue];
//
//        //处理imageBuffer time
//        NSInteger time_handle_disparity_Buffer = handleBufferTime - pushCameraTime;
//
//        NSLog(@"[gx] time_handle_disparity_Buffer %ld",time_handle_disparity_Buffer);
//
        //1 I420  2 NV12 3 NV21 4 RGBA
        [self.src_input send_frame_pixelBufferRef:[m_pFM2 getPixelBuffer] format:CNCENM_buf_format_BGRA time_stamp:[[NSDate date] timeIntervalSince1970]];
        
//        NSInteger send_bufferRefTime= [[NSNumber numberWithDouble:[[NSDate date] timeIntervalSince1970]*1000] integerValue];
//
//        NSInteger time_send_Buffer = send_bufferRefTime - handleBufferTime;
//
//        NSLog(@"[gx] time_send_Buffer %ld",time_send_Buffer);
//
        if (self.displayView) {
            [self.displayView display];
        }

        CVPixelBufferUnlockBaseAddress(imageBuffer, 0);
    }
    
}



- (void)sdk_return_code_center_deal:(NSNotification *)notification {
    NSDictionary* dic = notification.object;
    CNC_Ret_Code code = (CNC_Ret_Code)[[dic objectForKey:@"code"] integerValue];
  
     NSLog(@"[gx] 推流状态吗 %lu",(unsigned long)code);
    
    switch (code) {
            
        case CNC_Record_Realtime_Encode_Frame_Rate:
        {
            NSLog(@"[gx] 本地编码帧率%@",[NSString stringWithFormat:@"%@",[dic valueForKey:@"message"]]);
            
        }
            break;
        case CNC_Record_Realtime_Transfer_Frame_Rate:
        {
             NSLog(@"[gx] 推流帧率%@",[NSString stringWithFormat:@"%@",[dic valueForKey:@"message"]]);
        }
            break;
        default:
            break;
    }
    
    if (self.protocol&&[self.protocol respondsToSelector:@selector(pushEvent:)]) {
        [self.protocol pushEvent:code];
    }
    
}

- (void)addObservers {
    
    
    //添加错误码通知消息处理
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(sdk_return_code_center_deal:)
                                                 name:kMobStreamSDKReturnCodeNotification
                                               object:nil];
    
}

-(void)removeObservers
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end


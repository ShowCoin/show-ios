//
//  ShowStream.m
//  ShowLive
//
//  Created by 周华 on 2018/4/7.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "ShowStream.h"
#import "sdk/Sdk.h"
#import "sdk/SdkUtils.h"
#import "core/CoreLog.h"
#import "core/CoreUtils.h"
#import "stream/StreamFmt.h"
#import <string>
#import "GCDTimer.h"
class ShowStreamListener: public SdkListener
{
public:
    ShowStream *stream;
    std::string statInfoString = "";
public:
    virtual void onStateChanged(const char* url, SdkState fr, SdkState to, SdkErrorCode code)
    {
        [stream onStateChangedFrom:fr to:to error:code];
    }
    
    virtual void onPushStatistics(const char* statistics)
    {
        NSString *info = [NSString stringWithCString:statistics encoding:NSUTF8StringEncoding];
        [stream onPushStatistic:info];
    }
    
    virtual void onUploadStatistics(const char* key, const char* value)
    {
        
    }
    
    virtual void onPlaybackProgress(int totalSize, int totalMS, float precent)
    {
        [stream updateProgress:precent duration:totalMS];
    }
    
    virtual void onFileProgress(media::sdk::FileState state, int totalSize, int totalMs, float precent)
    {
        
        [stream mp3StateChanged:(ShowMp3State)state duration:totalMs/1000 progress:precent/100];
        
    }
    
    virtual void onTakeOnePictureOk(const char* fileName)
    {
        
    }
    
    virtual void onMp4WriteProgress(int durationMs)
    {
        
    }
    
    virtual void onRawFileRWProgress(int durationOrPercent)
    {
        
    }
};

static dispatch_queue_t streamQueue = dispatch_queue_create("stream", DISPATCH_QUEUE_SERIAL);
@interface ShowStream()
{
    ShowStreamListener _listener;
    __block BOOL initialize;
    NSRecursiveLock *_locker;
    int _number;
    BOOL _isClosed;
    GCDTimer *timer;
}

@property(nonatomic, copy) mp3_play_progress mp3_progress_block;

@end
@implementation ShowStream
+ (ShowStream *)sharedInstance
{
    static ShowStream *ShowStreamInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        ShowStreamInstance = [[self alloc] init];
    });
    return ShowStreamInstance;
}

- (void)dealloc{
    
}

- (id)init
{
    if(self=[super init])
    {
        [self SDKInit];
        
        _locker  = [[NSRecursiveLock alloc] init];
        
        _number = arc4random();
        
    }
    return self;
}

- (void)SDKInit
{
    if(initialize)
        return ;
    
    _listener.stream = self;
    
    Sdk::Instance()->Init();
    Sdk::Instance()->SetListener(&_listener);
    
    
    [_locker lock];
    initialize = YES;
    [_locker unlock];
}

- (void)SDKClose
{
    
    
}

+ (void)globalInit
{
    Sdk::Instance()->Init();
}

+ (void)cloudConfigUpdate
{
    int uid = 12345678;
    NSString* token = [KMUtils device_uuid];
    NSString* appverstr  = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    int appvercode = CoreUtils::VerStringToVerCode(appverstr.UTF8String);
    const char* deviceToken = token.UTF8String;
    if(uid>0){
        Sdk::Instance()->PropsUpdate(uid, appvercode, deviceToken);
    }
}

+ (const char*)cloudConfigStr:(const char*)name def:(const char*)def
{
    CoreProps* props = Sdk::Instance()->PropsGet();
    return props->GetStr(name, def);
}

+ (int)cloudConfigInt:(const char*)name def:(int)def
{
    CoreProps* props = Sdk::Instance()->PropsGet();
    return props->GetInt(name, def);
}

+ (void)getPushStreamConfiguration: (struct PushStreamConfiguration*)configuration levelTip: (int)lvltip
{
    Sdk::StreamPushConfiguration sdkconfig;
    Sdk::Instance()->GetPreferredConfigurationForPushStream(lvltip, sdkconfig);
    
    configuration->width = sdkconfig.width;
    configuration->height = sdkconfig.height;
    configuration->framerate = sdkconfig.framerate;
    strcpy(configuration->preset, sdkconfig.preset);
}

- (void)open:(NSString *)rtmp role:(ShowLiveRole)role streamID:(int)streamid completion:(void (^)())completion
{

    dispatch_async(streamQueue, ^{
        NSLog(@"media %s connecting to %s", (kShowLiveRoleWatcher == role ? "pull" : "push"), rtmp.UTF8String);
        @try {
            [_locker lock];

            if(completion)
                completion();
            SdkOpenType optType = SdkOpenNone;
            SdkConfig config;
            config.type = media::sdk::SdkConfig::ServiceType_unknown;
            switch (role) {
                case kShowLiveRoleWatcher:
                    optType = SdkOpenPull;
                    config.type = media::sdk::SdkConfig::ServiceType_pull;
                    break;
                case kShowLiveRolePublisher:
                    optType = SdkOpenPush;
                    config.type = media::sdk::SdkConfig::ServiceType_push;
                    break;
                case kShowLiveRoleReplay:
                    optType = SdkOpenPlayback;
                    config.type = media::sdk::SdkConfig::ServiceType_backplay;
                    config.file.totalSize = _size;
                    config.file.totalTime = _duration;
                    break;

                default:
                    break;
            }

            if(SdkOpenNone != optType){
                {
                    config.backgroudUrl.clear();
                    config.cycle = false;

                    //                    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDesktopDirectory, NSUserDomainMask, YES);
                    //                    NSString* thepath = [paths lastObject];
                    //                    thepath = [thepath stringByAppendingPathComponent:@"a0.mp3"];
                    //
                    //                    // 沙盒Documents目录
                    //                    NSString * appDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
                    //
                    //                    NSFileManager *fileManager = [NSFileManager defaultManager];
                    //                    NSString *filePath = [appDir stringByAppendingPathComponent:@"a0.mp3"];
                    //                    if(![fileManager fileExistsAtPath:filePath]){
                    //                        NSError *error;
                    //                        BOOL filesPresent = [fileManager copyItemAtPath:thepath toPath:appDir  error:&error];
                    //                        //BOOL filesPresent = [self copyFile:thepath toPath:appDir];
                    //                        if (filesPresent) {
                    //                            NSLog(@"Copy Success");
                    //                        }else{
                    //                            NSLog(@"Copy Fail");
                    //                        }
                    //                    }else{
                    //                        NSLog(@"文件已存在");
                    //                    }
                    //                    config.backgroudUrl = [filePath cStringUsingEncoding:NSASCIIStringEncoding];
                    //                    config.cycle = true;
                }
                Sdk::Instance()->Open(optType, rtmp.UTF8String, streamid, &config);
            }

            [_locker unlock];

        }@catch (...){

        }
        NSLog(@"media open %s complete", rtmp.UTF8String);
    });
}

- (void)close:(NSString *)rtmp block:(void (^)())block;
{
    [self stopStateTimer];
    
    dispatch_async(streamQueue, ^{
        [_locker lock];
        
        @try {
            if(rtmp == nil){
                Sdk::Instance()->Close("");
            }else {
                Sdk::Instance()->Close(rtmp.UTF8String);
            }
        }@catch (...){
            
        }
        if (block){
            block();
        }
        [_locker unlock];
    });
    
    
}


- (void)pause
{
    dispatch_async(streamQueue, ^{
        Sdk::Instance()->Pause();
    });
}

- (void)resume
{
    dispatch_async(streamQueue, ^{
        Sdk::Instance()->Resume();
    });
}

- (void)seek:(CGFloat)percent{
    Sdk::Instance()->Seek(percent);
}


- (void)setMute:(BOOL)mute{
    Sdk::Instance()->SetMute(mute);
}
- (BOOL)mute{
    return Sdk::Instance()->GetMute();
}

- (void)setEnableMic:(BOOL)enableMic{
    Sdk::Instance()->SetMicMute(enableMic);
}
- (BOOL)enableMic{
    return Sdk::Instance()->GetMicMute();
}

- (void)enterBackground
{
    //  SDK::notifyFrontBackSwitch(BackGround);
}

- (void)becomeActive
{
    // SDK::notifyFrontBackSwitch(FrontGround);
}

- (BOOL)isClosed{
    @synchronized (self) {
        return _isClosed;
    }
}

- (bool)push:(const char *)bytes size:(CGSize)size bytePerRow:(NSInteger)bytePerRow pictureFormat:(NSInteger)pictureFormat
{
    static unsigned int _lastTimeStamp = 0;
    if(bytePerRow!=size.width*4){
        CoreLogError("ShowStream.mm", "bytePerRow!=size.width*4");
        return false;
    }
    
    int len = 0;
    std::shared_ptr<StreamFmt> fmt = std::make_shared<StreamFmt>();
    if(0 == pictureFormat){
        //kPictureFmtRGBA
        len = (int)size.width * (int)size.height * 4;
        StreamFmtVideoFrameRgba(fmt.get(), (int)size.width, (int)size.height, (int)bytePerRow, 20, ByteSeqBGRA);
    }else{
        //yuv
        len = (int)size.width * (int)size.height * 3/2;
        StreamFmtVideoFrameYuvI420(fmt.get(), (int)size.width, (int)size.height, (int)size.width, (int)size.width/2, (int)20);
    }
    
    std::shared_ptr<StreamData> data = std::make_shared<StreamData>();
    data->Refer((void*)bytes, len, len);
    
    unsigned int timeStamp = CoreUtils::TickCount();
    if(timeStamp <= _lastTimeStamp){
        timeStamp = _lastTimeStamp + 10;
        NSLog(@"ShowStream.mm push timestamp == lasttimestamp == %d", timeStamp);
    }
    data->SetTimestamp(timeStamp);
    _lastTimeStamp = timeStamp;
    
    Sdk::Instance()->Push(fmt, data);
    return true;
}

#pragma mark --
#pragma mark -- 乐库相关
- (void)mp3StateChanged:(ShowMp3State)state duration:(CGFloat)duration progress:(CGFloat)percent{
    if(_mp3_progress_block){
        _mp3_progress_block(state, duration, percent);
    }
}
- (CGFloat)musicVolume{
    CGFloat volume = 90.0;
    const SdkConfig::AudioEffect *effect = Sdk::Instance()->GetAdjustBackgroudMusicEffect();
    if(effect){
        volume = effect->nMusicVol;
    }else{
        NSLog(@"error:sdk is closed!");
    }
    return volume;
}
- (CGFloat)micVolume{
    CGFloat volume = 90.0;
    const SdkConfig::AudioEffect *effect = Sdk::Instance()->GetAdjustBackgroudMusicEffect();
    if(effect){
        volume = effect->nMicVol;
    }else{
        NSLog(@"error:sdk is closed!");
    }
    return volume;
}

- (void)setMusicVolume:(CGFloat)vol{
    const SdkConfig::AudioEffect *effect = Sdk::Instance()->GetAdjustBackgroudMusicEffect();
    if(effect){
        SdkConfig::AudioEffect tmp;
        memmove(&tmp, effect, sizeof(SdkConfig::AudioEffect));
        tmp.nMusicVol = vol;
        Sdk::Instance()->SetAdjustBackgroudMusicEffect(&tmp);
    }else{
        NSLog(@"error:sdk is closed!");
    }
}

- (void)setMicVolume:(CGFloat)vol{
    const SdkConfig::AudioEffect *effect = Sdk::Instance()->GetAdjustBackgroudMusicEffect();
    if(effect){
        SdkConfig::AudioEffect tmp;
        memmove(&tmp, effect, sizeof(SdkConfig::AudioEffect));
        tmp.nMicVol = vol;
        Sdk::Instance()->SetAdjustBackgroudMusicEffect(&tmp);
    }else{
        NSLog(@"error:sdk is closed!");
    }
}

- (BOOL)playBackgroundMusic:(NSString *)musicfile progress:(mp3_play_progress)progress{
    
    _mp3_progress_block = nil;
    
    _mp3_progress_block = progress;
    
    return [self openBackgroundMusic:musicfile cycle:NO];
}
- (BOOL)pauseBackgroundMusic{
    return Sdk::Instance()->PauseBackgroudMusic();
}
- (BOOL)resumeBackgroundMusic{
    return Sdk::Instance()->ResumeBackgroudMusic();
}
- (BOOL)stopBackgroundMusic{
    
    _mp3_progress_block = nil;
    
    return Sdk::Instance()->CloseBackgroudMusic();
}

- (BOOL)openBackgroundMusic:(NSString*)musicFile
                      cycle:(BOOL)cycle{
    return Sdk::Instance()->OpenBackgroudMusic(musicFile.UTF8String, NULL);
    
}
//bool OpenBackgroudMusic(const char *strFileName, SdkConfig::AudioEffect * param, bool cycle = true);
//double  nMusicVol;//0-100
//double  nMicVol;//0-100
//double  nMixedVol;//0-100
//int  nScene;
- (BOOL)openBackgroundMusic:(NSString*)musicFile
                   musicVol:(CGFloat)musicVol
                     micVol:(CGFloat)micVol
                   mixedVol:(CGFloat)mixedVol
                      scene:(NSInteger)scene
                      cycle:(BOOL)cycle{
    
    if([[NSFileManager defaultManager] fileExistsAtPath:musicFile]){
        return NO;
    }
    
    media::sdk::SdkConfig::AudioEffect effect;
    effect.nMusicVol =  musicVol;
    effect.nMicVol = micVol;
    effect.nMixedVol = mixedVol;
    effect.nScene = (int)scene;
    
    return Sdk::Instance()->OpenBackgroudMusic(musicFile.UTF8String, &effect);
}
//通知网络状态切换

- (void)startStateTimer{
#define kShowStreamBreakDelay 3 * 60
    
    if(timer) return;
    
    static NSInteger delay = 0;
    delay = 0;
    @weakify(self)
    timer = [GCDTimer timerWithInterval:1
                                  block:^{
                                      NSLog(@"stream wait for %lu seconds", (unsigned long)delay);
                                      @strongify(self)
                                      if(delay++>kShowStreamBreakDelay){
                                          delay = 0;
                                          
                                          [self stopStateTimer];
                                          
                                          if (_error_block){
                                              _error_block(ErrorAbort);
                                          }
                                      }
                                  } queue:streamQueue];
    [timer start];
}
- (void)stopStateTimer{
    if(timer){
        [timer destroy];
        timer = nil;
    }
    
}
//static void notifyNetworkStateChanged(SDKNetwork network);
- (void) onStateChangedFrom:(int) fr to:(int) to error:(int) code {
    
    
    @synchronized (self) {
        _isClosed = kShowStreamStateClosed == to || kShowStreamStateUninit == to;
    }
    
    if (_block){
        _block((ShowStreamState)to);
    }
    //#if !defined(DEBUG)
    if (code == ErrorAbort || code == ErrorDecode){
        if (_error_block){
            _error_block(code);
        }
    }
    
    if(to == kShowStreamStateBreak && !self.isClosed){
        [self startStateTimer];
        
    }else if(to == kShowStreamStateLive || to == kShowStreamStateBeginLive){
        [self stopStateTimer];
        
    }    //#endif
}

- (void)updateProgress:(CGFloat)current duration:(u_int64_t)duration{
    if (_replay_progress_block){
        _replay_progress_block(current, duration);
    }
}

#pragma mark--日志
- (void) onPushStatistic:(NSString *) info{
    dispatch_async(dispatch_get_main_queue(), ^{
        if (_statistic_block){
            _statistic_block(info);
        }
    });
}

- (void)forbidLogOutput {
    Sdk::Instance()->BlockLogOutput(true);
}
@end

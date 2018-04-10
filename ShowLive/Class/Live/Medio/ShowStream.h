//
//  ShowStream.h
//  ShowLive
//
//  Created by 周华 on 2018/4/7.
//  Copyright © 2018年 vning. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger, ShowStreamState){
    kShowStreamStateUninit,
    kShowStreamStateClosed,
    kShowStreamStateConnect,
    kShowStreamStateCacheOrPause,
    kShowStreamStateBeginLive,
    kShowStreamStateLive,
    kShowStreamStateBitrateLow = 6,
    kShowStreamStatePause = 7,
    kShowStreamStateReady = 8,
    kShowStreamStateStart = 9,
    kShowStreamStateEnd = 10,
    kShowStreamStateBreak = 11
};

typedef NS_ENUM(NSInteger, ShowMp3State){
    FileState_Unknown = 0,
    FileState_Ready,//1
    FileState_Open,//2
    FileState_Close,//3
    FileState_Play,//4
    FileState_Stop,//5
    FileState_Pause,//6
    FileState_Resume,//7
    FileState_Break,//8
    FileState_Continue,//9
    FileState_Error//10
};
typedef NS_ENUM(NSInteger, ShowLiveRole){
    kShowLiveRolePublisher = 0,//主播
    kShowLiveRoleWatcher,//观众
    kShowLiveRoleReplay,//回放
    kShowLiveRoleShortVideo,//短视频
    kShowLiveRoleNone
};
typedef NS_ENUM(NSInteger, ShowLiveAFKStatus){
    kShowLiveAFKStatusIn = 2,
    kShowLiveAFKStatusOut = 1
};
typedef void (^stream_state_block)(ShowStreamState);
typedef void (^stream_error_block)(int);
typedef void (^stream_statistic_block)(NSString*);
typedef void (^stream_replay_progress_block)(CGFloat, u_int64_t);

typedef void (^mp3_play_progress)(ShowMp3State state, CGFloat duration, CGFloat percent);

struct PushStreamConfiguration {
    int width;
    int height;
    int framerate;
    char preset[64];
};
@interface ShowStream : NSObject
@property (nonatomic, copy) stream_state_block block;
@property (nonatomic, copy) stream_error_block error_block;

@property (nonatomic, copy) stream_statistic_block statistic_block;
@property (nonatomic, copy) stream_replay_progress_block replay_progress_block;

@property(nonatomic, assign) uint32_t duration; //小视频时长，毫秒为单位
@property(nonatomic, assign) uint32_t size;

@property (nonatomic, assign) BOOL mute;
@property (nonatomic, assign) BOOL enableMic;
@property (nonatomic, readonly, getter=isClosed) BOOL isClosed;

+ (void)globalInit;
+ (const char*)cloudConfigStr:(const char*)name def:(const char*)def;
+ (int)cloudConfigInt:(const char*)name def:(int)def;
+ (void)cloudConfigUpdate;
+ (void)getPushStreamConfiguration: (struct PushStreamConfiguration*)configuration levelTip: (int)lvltip;

+ (ShowStream *)sharedInstance;
- (void)SDKInit;
- (void)SDKClose;
- (void)open:(NSString *)rtmp role:(ShowLiveRole)role streamID:(int)streamid completion:(void (^)())completion;
- (void)close:(NSString *)rtmp block:(void (^)())block;

- (void)pause;
- (void)resume;

- (void)seek:(CGFloat)percent;

- (void)onStateChangedFrom:(int) fr to:(int) to error:(int) code;
- (void)onPushStatistic:(NSString *)info;
- (void)updateProgress:(CGFloat)current duration:(u_int64_t)duration;

- (bool)push:(const char *)bytes size:(CGSize)size bytePerRow:(NSInteger)bytePerRow pictureFormat:(NSInteger)pictureFormat;

- (void)enterBackground;
- (void)becomeActive;

- (void)forbidLogOutput;

#pragma mark --
#pragma mark -- 乐库相关
//bool OpenBackgroudMusic(const char *strFileName, SdkConfig::AudioEffect * param, bool cycle = true);
//double  nMusicVol;//0-100
//double  nMicVol;//0-100
//double  nMixedVol;//0-100
//int  nScene;

- (CGFloat)musicVolume;//伴奏声
- (void)setMusicVolume:(CGFloat)vol;

- (CGFloat)micVolume;//人声
- (void)setMicVolume:(CGFloat)vol;

/*
 *parameters:
 *musicfile: 文件的绝对路径
 *progress : mp3的播放进度回调 state 表示当前状态 duration播放总时长 percent播放进度百分比
 */
- (BOOL)playBackgroundMusic:(NSString *)musicfile progress:(mp3_play_progress)progress;
- (BOOL)pauseBackgroundMusic;
- (BOOL)resumeBackgroundMusic;
- (BOOL)stopBackgroundMusic;

- (BOOL)openBackgroundMusic:(NSString*)musicFile
                      cycle:(BOOL)cycle;
- (BOOL)openBackgroundMusic:(NSString*)musicFile
                   musicVol:(CGFloat)musicVol
                     micVol:(CGFloat)micVol
                   mixedVol:(CGFloat)mixedVol
                      scene:(NSInteger)scene
                      cycle:(BOOL)cycle;

//私有方法
- (void)mp3StateChanged:(ShowMp3State)state duration:(CGFloat)duration progress:(CGFloat)percent;
@end

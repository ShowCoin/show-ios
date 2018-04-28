//
//  SLPlayerManager.m
//  ShowLive
//
//  Created by gongxin on 2018/4/16.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "SLPlayerManager.h"
@interface SLPlayerManager()

@property(nonatomic,strong)CNCMediaPlayerController * player;

@property(nonatomic,strong)NSURL * url;

@end

static id sharedInstance = nil;
@implementation SLPlayerManager

+(SLPlayerManager*)shareManager
{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init
{
    if (self = [super init]) {
        
        [self register_sdk];
        
    }
    return self;
}

//网宿拉流
-(void)register_sdk
{
    NSString *app_id = @"souyu";
    NSString *auth_key = @"4514DDECEC4E46E089A67BFDF5B31B5E";
    [CNCMediaPlayerSDK regist_app:app_id auth_key:auth_key];
    
    
}

- (void)installMovieNotificationObservers
{
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(moviePlayBackFinish:)
                                                 name:CNCMediaPlayerPlayDidFinishNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(loadStateDidChange:)
                                                 name:CNCMediaPlayerLoadStateDidChangeNotification
                                               object:nil];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(firstVideoFrameRendered:) name:CNCMediaPlayerFirstVideoFrameRenderedNotification object:nil];
    
}

- (void)removeMovieNotificationObservers {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}

-(void)loadStateDidChange:(NSNotification*)notification
{
    
    if (self.protocol && [self.protocol respondsToSelector:@selector(loadStateDidChange:)]) {
        [self.protocol loadStateDidChange:_player.loadState];
    }
    
}

- (void)moviePlayBackFinish:(NSNotification*)notification
{
    
}

-(void)firstVideoFrameRendered:(NSNotification*)notification
{
    
    if (self.protocol && [self.protocol respondsToSelector:@selector(firstVideoFrameRendered)]) {
        [self.protocol firstVideoFrameRendered];
    }
}


- (void)initPlayerWithView:(UIView*)view
                       url:(NSURL*)url
{
    if (_player == nil) {
        self.player = [[CNCMediaPlayerController alloc]initWithContentURL:url];
        
    } else {
        [self.player reloadWithContentURL:url fromStart:YES];
    }
    
    self.player.shouldAutoClearCache = YES;
    self.player.minBufferTime = 1000;
    self.player.videoDecoderMode = CNC_VIDEO_DECODER_MODE_HARDWARE;
    self.player.disableVideoDecodeInBackground = YES;
    self.player.mixOtherPlayer = NO;
    [self.player accelerateOpen:YES];
    [self.player superAccelerate:YES];
    
    self.player.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.player.view.frame = view.bounds;
    [view insertSubview:self.player.view atIndex:0];
    
    
}


- (void)play
{
    [self.player play];
}

- (void)pause
{
    [self.player pause];
}

-(void)stop
{
    [self.player stop];
}

-(void)shutdown
{
    [self.player shutdown];
}

- (void)reloadUrl:(NSURL*)url
{
    [self.player reloadWithContentURL:url fromStart:YES];
}

- (void)prepareToPlay
{
    [self.player prepareToPlay];
}

- (void)destroyPlayer
{
    
    [self removeMovieNotificationObservers];
    [self.player pause];
    [self.player stop];
    [self.player shutdown];
    self.player = nil;
}


@end

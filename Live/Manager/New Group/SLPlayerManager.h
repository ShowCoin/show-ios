//
//  SLPlayerManager.h
//  ShowLive
//
//  Created by WorkNew on 2018/4/16.
//  Copyright © 2018年 VNing. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <CNCLiveMediaPlayerFramework/CNCMediaPlayerSDK.h>
#import <CNCLiveMediaPlayerFramework/CNCMediaPlayerFramework.h>
#import <CNCLiveMediaPlayerFramework/CNCMediaPlayerController.h>
#import <CNCLiveMediaPlayerFramework/CNCMediaPlayerComDef.h>

@protocol SLPlayerStateProtocol <NSObject>

@optional

-(void)firstVideoFrameRendered;

-(void)loadStateDidChange:(CNCMediaLoadstate)loadState;

@end
@interface SLPlayerManager : NSObject

@property(nonatomic, weak)id<SLPlayerStateProtocol> protocol;

+(SLPlayerManager*)shareManager;

- (void)installMovieNotificationObservers;

- (void)removeMovieNotificationObservers;

- (void)initPlayerWithView:(UIView*)view
                       url:(NSURL*)url;

- (void)play;

- (void)pause;

- (void)stop;

-(void)shutdown;

- (void)reloadUrl:(NSURL*)url;

- (void)prepareToPlay;

- (void)destroyPlayer;




@end

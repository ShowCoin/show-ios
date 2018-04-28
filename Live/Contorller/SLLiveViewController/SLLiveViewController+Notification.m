                                                                                                                                                                                      //
//  SLLiveViewController+Notification.m
//  ShowLive
//
//  Created by WorkNew on 2018/4/13.
//  Copyright © 2018年 VNing. All rights reserved.
//

#import "SLLiveViewController+Notification.h"
#import "SLPushManager.h"
#import "SLLivePauseAction.h"
#import "SLLiveOpenAction.h"

@implementation SLLiveViewController (Notification)

-(void)addLiveNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(applicationDidBecomeActiveNotification:)
                                                 name:UIApplicationWillEnterForegroundNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(applicationWillResignActiveNotification:)
                                                 name:UIApplicationDidEnterBackgroundNotification
                                               object:nil];
}

-(void)removeLiveNotification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)applicationDidBecomeActiveNotification:(NSNotification*)notify
{
    [[SLPushManager shareInstance] resume];
    
    if (IsStrEmpty(self.startModel.streamName)) {
        return;
    }
    
    SLLiveOpenAction * action = [SLLiveOpenAction action];
    action.streamName = self.startModel.streamName;
    [self sl_startRequestAction:action Sucess:^(id result) {
         NSLog(@"[gx] live DidBecome sussces");
    } FaildBlock:^(NSError *error) {
         NSLog(@"[gx] liveDidBecome error");
    }];

    
}
-(void)applicationWillResignActiveNotification:(NSNotification*)notify
{
    [[SLPushManager shareInstance] pause];
    
    if (IsStrEmpty(self.startModel.streamName)) {
        return;
    }
    
    SLLivePauseAction * action = [SLLivePauseAction action];
    action.streamName = self.startModel.streamName;
    [self sl_startRequestAction:action Sucess:^(id result) {
         NSLog(@"[gx] live WillResignActive sussces");
    } FaildBlock:^(NSError *error) {
         NSLog(@"[gx] live WillResignActive error");
    }];

    
}


@end

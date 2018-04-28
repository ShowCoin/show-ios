//
//  SLPlayerViewController+Notification.m
//  ShowLive
//
//  Created by WorkNew on 2018/4/14.
//  Copyright © 2018年 VNing. All rights reserved.
//

#import "SLPlayerViewController+Notification.h"
#import <AVFoundation/AVFoundation.h>
@implementation SLPlayerViewController (Notification)

-(void)addLiveNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(audioSessionInterrupt)
                                                 name:AVAudioSessionInterruptionNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(applicationDidBecomeActive)
                                                 name:UIApplicationDidBecomeActiveNotification
                                               object:nil];
}

-(void)removeNotification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)audioSessionInterrupt
{
    self.isAudioInterrupt=TRUE;
}

- (void)applicationDidBecomeActive
{
    if (self.isAudioInterrupt) {
        self.isAudioInterrupt = FALSE;
       
    }
}

@end

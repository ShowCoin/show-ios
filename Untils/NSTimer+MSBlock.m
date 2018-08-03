//
//  NSTimer+MSBlock.m
//  MyShowFoundation
//
//  Created by showgx on 16/5/4.
//  Copyright © 2016年 showgx Network Technology Co., Ltd. All rights reserved.
//

#import "NSTimer+MSBlock.h"

@implementation NSTimer (MSBlock)

+(NSTimer *)scheduledMSTimerWithTimeInterval:(NSTimeInterval)interval
                                       block:(void (^)(void))block
                                     repeats:(BOOL)repeats
{
    return [self scheduledTimerWithTimeInterval:interval
                                         target:self
                                       selector:@selector(blockInvoke:)
                                       userInfo:[block copy]
                                        repeats:repeats];
}

+(NSTimer *)timerWithTimeInterval:(NSTimeInterval)interval
                            block:(void (^)(void))block
                          repeats:(BOOL)repeats
{
    return [self timerWithTimeInterval:interval
                                target:self
                              selector:@selector(blockInvoke:)
                              userInfo:[block copy]
                               repeats:repeats];
}

+(void)blockInvoke:(NSTimer *)timer
{
    
    void (^block)(void) = timer.userInfo;
    if (block) {
        block();
    }
}

@end

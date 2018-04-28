//
//  GCDTimer.h
//  VideoMake
//
//  Created by  JokeSmileZhang on 15/5/12.
//  Copyright (c) 2015年 JokeSmileZhang. All rights reserved.
//

#import <Foundation/Foundation.h>

//最大时间
#define Time_Max 60 * 60 * 24

@interface GCDTimer : NSObject

@property (nonatomic) BOOL suspend;

@property (nonatomic, assign) NSTimeInterval totleTime;

+ (instancetype)timerWithInterval:(NSTimeInterval)interval block:(void (^)(void))block queue:(dispatch_queue_t)queue;

- (void)startAfterInterVal;
- (void)start;
- (void)stop;

- (void)destroy;

@end

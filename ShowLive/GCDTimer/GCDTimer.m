//
//  GCDTimer.m
//  VideoMake
//
//  Created by sunlantao on 15/5/12.
//  Copyright (c) 2015年 sunlantao. All rights reserved.
//

#import "GCDTimer.h"

@interface GCDTimer(){
    dispatch_source_t _timer;
    NSRecursiveLock *_locker;
    BOOL cancelled;
}

@property(nonatomic) NSTimeInterval interval;
@property(nonatomic, copy) void (^block)(void);
@property(nonatomic) dispatch_queue_t queue;

//runloop次数
@property(nonatomic, assign) NSUInteger timerCount;

@end

@implementation GCDTimer


- (void)dealloc{
    [self destroy];
}

+ (instancetype)timerWithInterval:(NSTimeInterval)interval block:(void (^)(void))block queue:(dispatch_queue_t)queue{
    GCDTimer *timer = [[GCDTimer alloc] init];
    timer.interval = interval;
    timer.block = block;
    timer.queue = queue;
    timer.timerCount = 0;
    [timer setup];
    
    return timer;
}

- (void)setup{
    _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, _queue);
    dispatch_source_set_timer(_timer, dispatch_walltime(DISPATCH_TIME_NOW, 0), (uint64_t)(_interval * NSEC_PER_SEC), 0);
    dispatch_source_set_event_handler(_timer, _block);
    
    @weakify(self)
    dispatch_source_set_event_handler(_timer, ^{
        @strongify(self)
        [self  handleEventTimerCallback];
    });
   // dispatch_resume(_timer);
    _suspend = YES;
    _locker = [[NSRecursiveLock alloc] init];
}

- (void)handleEventTimerCallback
{
    if (self.totleTime > Time_Max) {
        self.timerCount = 0;
    }
    
    self.timerCount ++;
    
    if (_block) {
        _block();
    }
}

- (void)startAfterInterVal{
    [self performSelector:@selector(start) withObject:nil afterDelay:_interval];
}

- (void)start{
    [_locker lock];
    @try {
        if(_suspend)
            dispatch_resume(_timer);
        _suspend = NO;
    }
    @catch (NSException *exception) {
        NSLog(@"%@", exception.reason);
    }
    @finally {
        _suspend = NO;
    }
    [_locker unlock];
}

- (void)stop{

    [_locker lock];
    @try {
        if(!_suspend)
            dispatch_suspend(_timer);
    }
    @catch (NSException *exception) {
        NSLog(@"%@", exception.reason);
    }
    @finally {
        _suspend = YES;
    }
    [_locker unlock];
}

- (void)destroy{
    if (cancelled){
        return;
    }
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(start) object:nil];
    
    @try {
        [_locker lock];
        if(_suspend){
            dispatch_resume(_timer);
        }
        dispatch_cancel(_timer);
        cancelled = YES;
        [_locker unlock];
    } @catch (NSException *exception) {
        NSLog(@"%@", exception.reason);
    } @finally {
        
    }
}

#pragma mark -- ------------- set / get

- (NSTimeInterval)totleTime
{
    return self.timerCount * self.interval;
}

@end

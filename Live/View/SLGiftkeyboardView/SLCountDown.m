//
//  SLCountDown.m
//  ShowLive
//
//  Created by WorkNew on 2018/4/16.
//  Copyright © 2018年 VNing. All rights reserved.
//

#import "SLCountDown.h"
@interface SLCountDown()

@property (nonatomic,assign) NSInteger optionTimerCount;

@property (nonatomic,assign) NSInteger timerCount;

@property (nonatomic, strong) NSTimer *mTimer;

@property (nonatomic,assign) NSInteger currentCount;

@end
@implementation SLCountDown

/**
 初始化函数
 
 @param optionCount 设置倒计时的初始值
 
 @return 实例
 */
- (instancetype)initWithCount:(NSInteger)optionCount
{
    if (self = [super init]) {
        
        // init
        
        self.optionTimerCount = optionCount;
        self.timerCount = optionCount;
        self.currentCount = optionCount;
        
    }
    
    return self;
}

/**
 开启倒计时
 */
- (void)start
{
    self.currentCount = self.timerCount;
    self.timerCount   = self.optionTimerCount;
    _mTimer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(reductionNum) userInfo:nil repeats:YES];
    [_mTimer fire];
}

/**
 复位
 */
- (void)countReset
{
    self.timerCount = self.optionTimerCount;
    self.currentCount = self.timerCount;
}


/**
 停止倒计时
 */
- (void)stop
{
    if (_mTimer.isValid)
    {
        [self.mTimer invalidate];
    }
    
}

#pragma mark -- 私有

- (void)reductionNum
{
    self.timerCount --;
    self.currentCount = self.timerCount;
    if (self.delegate && [self.delegate respondsToSelector:@selector(reductionNum:)]) {
        
        [self.delegate reductionNum:self.timerCount];
        
    }
    
    if (self.timerCount <= 0)
    {
        [self stop];
    }
}

@end

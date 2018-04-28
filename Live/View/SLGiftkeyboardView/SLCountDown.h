//
//  SLCountDown.h
//  ShowLive
//
//  Created by gongxin on 2018/4/16.
//  Copyright © 2018年 vning. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol SLCountDownTimerDelegate <NSObject>

@optional

- (void)reductionNum:(NSInteger)currentCount;

@end

@interface SLCountDown : NSObject

@property (nonatomic, weak) id<SLCountDownTimerDelegate>delegate;

@property (nonatomic,assign, readonly) NSInteger currentCount;

/**
 初始化函数
 
 @param optionCount 设置倒计时的初始值
 
 @return 实例
 */
- (instancetype)initWithCount:(NSInteger)optionCount;



/**
 开启倒计时
 */
- (void)start;

/**
 复位
 */
- (void)countReset;


/**
 停止倒计时
 */
- (void)stop;
@end

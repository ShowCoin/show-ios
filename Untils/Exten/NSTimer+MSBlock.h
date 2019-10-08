//
//  NSTimer+MSBlock.h
//  MyShowFoundation
//
//  Created by showgx on 16/5/4.
//  Copyright © 2016年 showgx Network Technology Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimer (MSBlock)

+(NSTimer *)scheduledMSTimerWithTimeInterval:(NSTimeInterval)interval
                                     block:(void (^)(void))block
                                   repeats:(BOOL)repeats;
+(NSTimer *)timerWithTimeInterval:(NSTimeInterval)interval
                            block:(void (^)(void))block
                          repeats:(BOOL)repeats;

@end

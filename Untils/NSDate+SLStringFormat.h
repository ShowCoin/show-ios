//
//  NSDate+DLStringFormat.h
//  Dreamer-ios-client
//
//  Created by showgx on 17/3/18.
//  Copyright © 2017年 Show gx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (DLStringFormat)

- (NSString *)formattedStringWithDateString:(NSString *)string;

// 给一个结束时间(秒) 返回一个结束时间字符串
+ (NSString *)getEndTimeStr:(NSTimeInterval)end;

@end

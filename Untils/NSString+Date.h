//
//  NSString+Date.h
//  show
//
//  Created by showgx  on 16/6/26.
//  Copyright © 2016年 gx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Date)


+(NSString *)dateWithIntervale:(long long)interval formateStyle:(NSString*)style;
-(long long)dateStringWithFormateStyle:(NSString*)style;

+ (NSString *)dateTimeDifferenceWithStartTime:(NSString *)startTime endTime:(NSString *)endTime;


+ (NSString *)minutesWithStartTime:(NSString *)startTime endTime:(NSString *)endTime;

/**
 获取时间差
 
 @param date 时间
 
 @return 格式化时间字符串
 */
+ (NSString *)strintFromeDate:(NSDate *)date formate:(NSString *)formate;


/**
 获取当前时间的格式化字符串
 
 @param date 时间
 
 @return 格式化时间字符串
 */
+(NSString*)getNowString;

//获取当前时间戳
+(NSString *)getNowTimeInterval;

//时间转换时间戳
+(NSString*)exchageTimeInterval:(NSString*)timeString;

//获取pk当天日期
+(NSString*)getPKString;

@end

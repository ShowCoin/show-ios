//
//  NSString+Date.h
//  show
//
//  Created by showgx  on 16/6/26.
//  Copyright © 2016年 gx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Date)

//时间戳转时间
+(NSString *)dateWithIntervale:(long long)interval formateStyle:(NSString*)style;

//date style
-(long long)dateStringWithFormateStyle:(NSString*)style;

//时间差
+ (NSString *)dateTimeDifferenceWithStartTime:(NSString *)startTime endTime:(NSString *)endTime;

//计算时间差
+ (NSString *)minutesWithStartTime:(NSString *)startTime endTime:(NSString *)endTime;




@end

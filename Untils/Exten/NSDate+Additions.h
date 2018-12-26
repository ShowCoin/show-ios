//
//  NSDate+Additions.h
//  It'sMyCoupon
//
//  Created by Shingo Yabuki on 12-6-4.
//  Copyright (c) 2012年 c2y. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Additions)
//往后推几天
- (NSDate *)addDays:(NSInteger)days;
//年月日
- (NSString *)yearmonthdayDateFormattedString;
//time格式的
- (NSString *)timeDateFormattedString;

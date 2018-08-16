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
- (NSString *)yearmonthdayDateFormattedString;
- (NSString *)timeDateFormattedString;
- (NSString *)longDateFormattedString;
- (NSString *)lastUpdateDateFormattedString;
- (NSString *)longStringValue;
- (NSString *)stringValue;
- (NSString *)timeText;
- (NSInteger)season;
- (NSInteger)age;
- (NSString *)constellation;
- (NSString *)UMTimeInterval;
- (NSDate *)UMTDate;

@end

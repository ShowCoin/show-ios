//
//  NSDate+Additions.m
//  It'sMyCoupon
//
//  Created by Shingo Yabuki on 12-6-4.
//  Copyright (c) 2012年 c2y. All rights reserved.
//

#import "NSDate+Additions.h"

@implementation NSDate (Additions)

- (NSDate *)addDays:(NSInteger)days {
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comps = [calendar components:0xff fromDate:self];
    [comps setDay:([comps day]+ days)];
    return [calendar dateFromComponents:comps];
}
//年月日
- (NSString *)yearmonthdayDateFormattedString {
    
    NSString *formattedString;
    
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate:[NSDate date]];
    NSDate *now = [[NSDate date] dateByAddingTimeInterval:interval];
    
    NSCalendar *cal = [NSCalendar currentCalendar];
    unsigned int unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDateComponents *nowComponents = [cal components:unitFlags fromDate:now];
    NSDateComponents *components = [cal components:unitFlags fromDate:self];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    [formatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    NSDate *today = [formatter dateFromString:[NSString stringWithFormat:@"%i-%i-%i 00:00:00", nowComponents.year, nowComponents.month, nowComponents.day]];
    
    int secDiffInterval = [now timeIntervalSinceDate:self];
    int minDiffInterval = secDiffInterval / 60;
    int hourDiffInterval = minDiffInterval / 60;
    int secDiffIntervalSinceToday = [today timeIntervalSinceDate:self];
    formattedString = [NSString stringWithFormat:@"%i/%i/%i", components.year, components.month,components.day];
    
    
    return formattedString;
}
//时间
-(NSString *)timeDateFormattedString{
    NSString *formattedString;
    
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate:[NSDate date]];
    NSDate *now = [[NSDate date] dateByAddingTimeInterval:interval];
    
    NSCalendar *cal = [NSCalendar currentCalendar];
    unsigned int unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDateComponents *nowComponents = [cal components:unitFlags fromDate:now];
    NSDateComponents *components = [cal components:unitFlags fromDate:self];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    [formatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    NSDate *today = [formatter dateFromString:[NSString stringWithFormat:@"%i-%i-%i 00:00:00", nowComponents.year, nowComponents.month, nowComponents.day]];
    
    int secDiffInterval = [now timeIntervalSinceDate:self];
    int minDiffInterval = secDiffInterval / 60;
    int hourDiffInterval = minDiffInterval / 60;
    int secDiffIntervalSinceToday = [today timeIntervalSinceDate:self];
    if (minDiffInterval < 1) {
        //小于1分钟
        formattedString = @"刚刚";
    }
    else if (hourDiffInterval < 1) {
        //小于1小时
        formattedString = [NSString stringWithFormat:@"%i分钟前", minDiffInterval];
    }else {
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"hh:mm"];
        formattedString = [dateFormatter stringFromDate:self];
    }
    return formattedString;
    
}
- (NSString *)longDateFormattedString {
    
    NSString *formattedString;
    
    //获取本地时区现在时间
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate:[NSDate date]];
    NSDate *now = [[NSDate date] dateByAddingTimeInterval:interval];
    
    NSCalendar *cal = [NSCalendar currentCalendar];
    unsigned int unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDateComponents *nowComponents = [cal components:unitFlags fromDate:now];
    NSDateComponents *components = [cal components:unitFlags fromDate:self];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    [formatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    NSDate *today = [formatter dateFromString:[NSString stringWithFormat:@"%i-%i-%i 00:00:00", nowComponents.year, nowComponents.month, nowComponents.day]];
    
    int secDiffInterval = [now timeIntervalSinceDate:self];
    int minDiffInterval = secDiffInterval / 60;
    int hourDiffInterval = minDiffInterval / 60;
    int secDiffIntervalSinceToday = [today timeIntervalSinceDate:self];
    if (minDiffInterval < 1) {
        //小于1分钟
        formattedString = @"刚刚";
    }
    else if (hourDiffInterval < 1) {
        //小于1小时
        formattedString = [NSString stringWithFormat:@"%i分钟前", minDiffInterval];
    }
    else if (hourDiffInterval < 24) {
        
        //小于1天
        formattedString = [NSString stringWithFormat:@"%i小时前", hourDiffInterval];
    }
    else if (secDiffIntervalSinceToday > 0 && secDiffIntervalSinceToday < 3600*24) {
        
        //昨天
        formattedString = @"昨天";
    }
    else {
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-M-d hh:mm"];
        formattedString = [dateFormatter stringFromDate:self];
    }
    
    return formattedString;
}
- (NSString *)lastUpdateDateFormattedString {
    
    NSString *formattedString;
    
    //获取本地时区现在时间
    NSTimeZone *zone =  [NSTimeZone timeZoneWithName:@"Asia/BeiJing"];
    NSInteger interval = [zone secondsFromGMTForDate:[NSDate date]];
    NSDate *now = [[NSDate date] dateByAddingTimeInterval:interval];
    
    NSCalendar *cal = [NSCalendar currentCalendar];
    unsigned int unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDateComponents *nowComponents = [cal components:unitFlags fromDate:now];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    [formatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    NSDate *today = [formatter dateFromString:[NSString stringWithFormat:@"%i-%i-%i 00:00:00", nowComponents.year, nowComponents.month, nowComponents.day]];
    
    int hourDiffInterval = [now timeIntervalSinceDate:self] / 60 / 60;
    int dayDiffInterval = hourDiffInterval / 24;
    int monthDiffInterval = dayDiffInterval / 30;
    int yearDiffInterval = monthDiffInterval / 12;
    int secDiffIntervalSinceToday = [today timeIntervalSinceDate:self];
    
    if (hourDiffInterval < 1) {
        
        //一小时内
        formattedString = @"1小时内";
    }
    else if (dayDiffInterval < 2) {
        
        //两天以内
        formattedString = [NSString stringWithFormat:@"%i小时前", hourDiffInterval];
    }
    else if (secDiffIntervalSinceToday > 0 && secDiffIntervalSinceToday < 3600*24*30) {
        
        //N天前
        formattedString = [NSString stringWithFormat:@"%i天前", dayDiffInterval];
    }
    else if (secDiffIntervalSinceToday > 0 && secDiffIntervalSinceToday < 3600*24*365) {
        
        //N月前
        formattedString = [NSString stringWithFormat:@"%i个月前", monthDiffInterval];
    }
    else {
        
        formattedString = [NSString stringWithFormat:@"%i年前", yearDiffInterval];
    }
    
    return formattedString;
}
- (NSString *)longStringValue {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    [formatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    NSString *destDateString = [formatter stringFromDate:self];
    return destDateString;
}

- (NSString *)stringValue {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    [formatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    NSString *destDateString = [formatter stringFromDate:self];
    return destDateString;
}

- (NSString *)timeText {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"hh:mm"];
    [formatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    NSString *destDateString = [formatter stringFromDate:self];
    return destDateString;
}

- (NSInteger)season {
    
    NSCalendar *cal = [NSCalendar currentCalendar];
    unsigned int unitFlags = NSMonthCalendarUnit;
    NSDateComponents *components = [cal components:unitFlags fromDate:self];
    if (components.month >= 1 && components.month <=3)
        return 1;
    else if (components.month >= 4 && components.month <=6)
        return 2;
    else if (components.month >= 6 && components.month <=9)
        return 3;
    else if (components.month >= 9 && components.month <=12)
        return 4;
    return 0;
}

@end

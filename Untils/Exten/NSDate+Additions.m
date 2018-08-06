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


@end

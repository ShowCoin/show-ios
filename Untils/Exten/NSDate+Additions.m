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

- (NSInteger)age {
    
    NSTimeInterval dateDiff = [self timeIntervalSinceNow];
    int age = trunc(dateDiff / (60 * 60 * 24)) / 365 * -1;
    return age;
}

- (NSString *)constellation {
    
    NSString *retStr=@"";
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"MM"];
    int i_month=0;
    NSString *theMonth = [dateFormat stringFromDate:self];
    if([[theMonth substringToIndex:0] isEqualToString:@"0"]){
        i_month = [[theMonth substringFromIndex:1] intValue];
    }else{
        i_month = [theMonth intValue];
    }
    
    [dateFormat setDateFormat:@"dd"];
    int i_day=0;
    NSString *theDay = [dateFormat stringFromDate:self];
    if([[theDay substringToIndex:0] isEqualToString:@"0"]){
        i_day = [[theDay substringFromIndex:1] intValue];
    }else{
        i_day = [theDay intValue];
    }
    /*
     摩羯座 12月22日------1月19日
     水瓶座 1月20日-------2月18日
     双鱼座 2月19日-------3月20日
     白羊座 3月21日-------4月19日
     金牛座 4月20日-------5月20日
     双子座 5月21日-------6月21日
     巨蟹座 6月22日-------7月22日
     狮子座 7月23日-------8月22日
     处女座 8月23日-------9月22日
     天秤座 9月23日------10月23日
     天蝎座 10月24日-----11月21日
     射手座 11月22日-----12月21日
     */
    switch (i_month) {
        case 1:
            if(i_day>=20 && i_day<=31){
                retStr=@"水瓶座";
            }
            if(i_day>=1 && i_day<=19){
                retStr=@"摩羯座";
            }
            break;
        case 2:
            if(i_day>=1 && i_day<=18){
                retStr=@"水瓶座";
            }
            if(i_day>=19 && i_day<=31){
                retStr=@"双鱼座";
            }
            break;
        case 3:
            if(i_day>=1 && i_day<=20){
                retStr=@"双鱼座";
            }
            if(i_day>=21 && i_day<=31){
                retStr=@"白羊座";
            }
            break;
        case 4:
            if(i_day>=1 && i_day<=19){
                retStr=@"白羊座";
            }
            if(i_day>=20 && i_day<=31){
                retStr=@"金牛座";
            }
            break;
        case 5:
            if(i_day>=1 && i_day<=20){
                retStr=@"金牛座";
            }
            if(i_day>=21 && i_day<=31){
                retStr=@"双子座";
            }
            break;
        case 6:
            if(i_day>=1 && i_day<=21){
                retStr=@"双子座";
            }
            if(i_day>=22 && i_day<=31){
                retStr=@"巨蟹座";
            }
            break;
        case 7:
            if(i_day>=1 && i_day<=22){
                retStr=@"巨蟹座";
            }
            if(i_day>=23 && i_day<=31){
                retStr=@"狮子座";
            }
            break;
        case 8:
            if(i_day>=1 && i_day<=22){
                retStr=@"狮子座";
            }
            if(i_day>=23 && i_day<=31){
                retStr=@"处女座";
            }
            break;
        case 9:
            if(i_day>=1 && i_day<=22){
                retStr=@"处女座";
            }
            if(i_day>=23 && i_day<=31){
                retStr=@"天秤座";
            }
            break;
        case 10:
            if(i_day>=1 && i_day<=23){
                retStr=@"天秤座";
            }
            if(i_day>=24 && i_day<=31){
                retStr=@"天蝎座";
            }
            break;
        case 11:
            if(i_day>=1 && i_day<=21){
                retStr=@"天蝎座";
            }
            if(i_day>=22 && i_day<=31){
                retStr=@"射手座";
            }
            break;
        case 12:
            if(i_day>=1 && i_day<=21){
                retStr=@"射手座";
            }
            if(i_day>=21 && i_day<=31){
                retStr=@"摩羯座";
            }
            break;
    }
    return retStr;
}

- (NSString *)UMTimeInterval {
    
    NSString *timeInterval;
    NSCalendar *cal = [NSCalendar currentCalendar];
    unsigned int unitFlags = NSHourCalendarUnit;
    NSDateComponents *nowComponents = [cal components:unitFlags fromDate:[NSDate date]];
    NSInteger hour = nowComponents.hour;
    if (hour >= 5 && hour < 11)
        timeInterval = @"早上5:00至上午11:00";
    else if (hour >= 11 && hour < 16)
        timeInterval = @"上午11:00至下午16:00";
    else if (hour >= 16 && hour < 20)
        timeInterval = @"下午16:00至晚上20:00";
    else if (hour >= 20 || hour < 2)
        timeInterval = @"晚上20:00至凌晨2:00";
    else
        timeInterval = @"夜间";
    
    return timeInterval;
}
- (NSDate *)UMTDate {
    
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate:self];
    NSDate *UMTDate = [self dateByAddingTimeInterval:interval];
    
    return UMTDate;
}
@end

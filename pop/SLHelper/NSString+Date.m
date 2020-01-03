//
//  NSString+Date.m
//  showlive
//
//  Created by show gx on 16/6/26.
//  Copyright © 2016年 show. All rights reserved.
//

#import "NSString+Date.h"

@implementation NSString (Date)
+(NSString*)dateWithIntervale:(long long)interval formateStyle:(NSString *)style
{
    NSDate * date=[NSDate dateWithTimeIntervalSince1970:interval/1000];
    NSDateFormatter * formate=[[NSDateFormatter alloc]init];
    [formate setDateFormat:style];
    NSString * str =[formate stringFromDate:date];
    
    return str;
}

-(long long)dateStringWithFormateStyle:(NSString *)style{
    NSDateFormatter * formate=[[NSDateFormatter alloc]init];
    [formate setDateFormat:style];
    NSDate * date=[formate dateFromString:self];
    NSTimeInterval interval=[date timeIntervalSince1970];
    
    return interval*1000;
}

+ (NSString *)dateTimeDifferenceWithStartTime:(NSString *)startTime endTime:(NSString *)endTime{
    
    
    NSDateFormatter *date = [[NSDateFormatter alloc]init];
    [date setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    date.timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    //日历类型，公历
    NSCalendar * gregorian_cal = [[NSCalendar alloc] initWithCalendarIdentifier:
                                  NSCalendarIdentifierGregorian];
    date.calendar = gregorian_cal;
    
    
    NSDate *startD;
    NSDate *endD;
    
    if (IsStrEmpty(startTime)) {
        startD = [NSDate date];
    }else
    {
        startD =[date dateFromString:startTime];
    }
    
    if (IsStrEmpty(endTime)||[endTime isEqualToString:@"0000-00-00 00:00:00"]) {
        endD = [NSDate date];
    }else
    {
        endD = [date dateFromString:endTime];
    }
    
    
    NSTimeInterval late1=[startD timeIntervalSince1970]*1;
    NSTimeInterval late2=[endD timeIntervalSince1970]*1;
    NSTimeInterval value=late2-late1;
    
    if(value<0)
    {
        value = 0;
    }
    int second = (int)value%60;//秒
    int minute = (int)value/60%60;
    int house = (int)value/3600;
    
    NSString * houseStr = [self exchangeWithInt:house];
    NSString * minuteStr = [self exchangeWithInt:minute];
    NSString * secondStr = [self exchangeWithInt:second];
    
    
    NSString *str;
    if (house != 0) {
        str = [NSString stringWithFormat:@"%@:%@:%@",houseStr,minuteStr,secondStr];
    }else if ( house== 0 && minute!=0) {
        str = [NSString stringWithFormat:@"00:%@:%@",minuteStr,secondStr];
    }else{
        str = [NSString stringWithFormat:@"00:00:%@",secondStr];
    }
    return str;
}

+ (NSString *)minutesWithStartTime:(NSString *)startTime endTime:(NSString *)endTime
{
    NSDateFormatter *date = [[NSDateFormatter alloc]init];
    [date setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    //默认时区
    date.timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    //日历类型，公历
    NSCalendar * gregorian_cal = [[NSCalendar alloc] initWithCalendarIdentifier:
                                  NSCalendarIdentifierGregorian];
    date.calendar = gregorian_cal;
    
    
    NSDate *startD;
    NSDate *endD;
    
    if (IsStrEmpty(startTime)) {
        startD = [NSDate date];
    }else
    {
        startD =[date dateFromString:startTime];
    }
    
    if (IsStrEmpty(endTime)||[endTime isEqualToString:@"0000-00-00 00:00:00"]) {
        endD = [NSDate date];
    }else
    {
        endD = [date dateFromString:endTime];
    }
    
    
    NSTimeInterval late1=[startD timeIntervalSince1970]*1;
    NSTimeInterval late2=[endD timeIntervalSince1970]*1;
    NSTimeInterval value=late2-late1;
    
    if(value<0)
    {
        value = 0;
    }
    
    int minute = (int)value/60%60;
    int house = (int)value/3600;
    int allminute;
    NSString *str;
    if (house != 0) {
        
        allminute = house*60+minute;
        
        str = [NSString stringWithFormat:@"%d",allminute];
    }else if ( house== 0 && minute!=0) {
        str = [NSString stringWithFormat:@"%d",minute];
    }else
    {
        str = @"1";
    }
    
    return str;
    
}

+ (NSString *)strintFromeDate:(NSDate *)date formate:(NSString *)formate
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:formate];
    
    return [dateFormatter stringFromDate:date];
}

+(NSString*)getNowString
{
    NSDate *now = [NSDate date];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:
                            NSCalendarIdentifierGregorian];
    NSUInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:now];
    
    int year =(int) [dateComponent year];
    int month = (int) [dateComponent month];
    int day = (int) [dateComponent day];
    int hour = (int) [dateComponent hour];
    int minute = (int) [dateComponent minute];
    int second = (int) [dateComponent second];
    
    //字符串的转化并且拼接
    NSString *yearstr=[NSString stringWithFormat:@"%ld-",(long)year];
    NSString *monthstr=[NSString stringWithFormat:@"%@-",[self exchangeWithInt:month]];
    NSString *daystr=[NSString stringWithFormat:@"%@ ",[self exchangeWithInt:day]];
    NSString *hourstr=[NSString stringWithFormat:@"%@:",[self exchangeWithInt:hour]];
    NSString *minutestr=[NSString stringWithFormat:@"%@:",[self exchangeWithInt:minute]];
    NSString *secondstr=[NSString stringWithFormat:@"%@",[self exchangeWithInt:second]];
    //字符串开始拼接
    NSString *allstr=[yearstr stringByAppendingString:monthstr];
    NSString *allstr1=[allstr stringByAppendingString:daystr];
    NSString *allstr2=[allstr1 stringByAppendingString:hourstr];
    NSString *allstr3=[allstr2 stringByAppendingString:minutestr];
    NSString *DateTime=[allstr3 stringByAppendingString:secondstr];
    
    
    return DateTime;
}


- (NSString *)timeWithTimeIntervalString:(NSString *)timeString
{
    // 格式化时间
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [formatter setTimeZone:timeZone];
    //日历类型，公历
    NSCalendar * gregorian_cal = [[NSCalendar alloc] initWithCalendarIdentifier:
                                  NSCalendarIdentifierGregorian];
    formatter.calendar = gregorian_cal;
    
    // 毫秒值转化为秒
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:[timeString doubleValue]];
    NSString* dateString = [formatter stringFromDate:date];
    
    return dateString;
}


@end

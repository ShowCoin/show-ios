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


@end

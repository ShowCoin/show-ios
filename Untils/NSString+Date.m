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


@end

//
//  NSDateFormatter+TSJ.m
//  living
//
//  Created by milo on 15/6/18.
//  Copyright (c) 2015年 MJHF. All rights reserved.
//

#import "NSDateFormatter+TSJ.h"

@implementation NSDateFormatter (TSJ)

+ (id)dateFormatter
{
    return [[self alloc] init];
}

+ (id)dateFormatterWithFormat:(NSString *)dateFormat
{
    NSDateFormatter *dateFormatter = [[self alloc] init];
    dateFormatter.dateFormat = dateFormat;
    return dateFormatter;
}

+ (id)defaultDateFormatter
{
    return [self dateFormatterWithFormat:@"yyyy-MM-dd HH:mm:ss"];
}
@end

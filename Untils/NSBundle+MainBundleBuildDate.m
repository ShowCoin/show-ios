//
//  NSBundle+MainBundleBuildDate.m
//  Dreamer
//
//  Created by Ant on 16/10/21.
//  Copyright © 2016年 Beijing Dreamer. All rights reserved.
//

#import "NSBundle+MainBundleBuildDate.h"

@implementation NSBundle (MainBundleBuildDate)

+ (NSString *)mainBundleBuildDate
{
    NSString *string = [[NSBundle mainBundle] pathForResource:@"BuildDate" ofType:@"plist"];
    NSDictionary *buildDateDictionary = [NSDictionary dictionaryWithContentsOfFile:string];
    return buildDateDictionary[@"BuildDate"];
}

@end


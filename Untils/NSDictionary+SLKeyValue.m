//
//  NSDictionary+DLKeyValue.m
//  Dreamer-ios-client
//
//  Created by lei on 17/3/27.
//  Copyright © 2017年 Beijing Dreamer. All rights reserved.
//

#import "NSDictionary+DLKeyValue.h"

@implementation NSDictionary (DLKeyValue)

- (NSString *)dl_safeStringForKey:(id)key
{
    id string = [self objectForKey:key];
    if (string && [string isKindOfClass:NSString.class]) {
        return string;
    } else if ([string respondsToSelector:@selector(stringValue)]) {
        return [string stringValue];
    }
    return @"";
}

@end

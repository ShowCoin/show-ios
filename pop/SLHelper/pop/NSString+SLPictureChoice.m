//
//  NSString+SLPictureChoice.m
//  showgx
//
//  Created by showgx on 17/2/13.
//  Copyright © 2017年 SHOWgx. All rights reserved.
//

#import "NSString+DLPictureChoice.h"

@implementation NSString (SLPictureChoice)

- (NSString *)stringWithSizeString:(NSString *)str
{
    if (IsStrEmpty(str)) return self;
    
    if (!self) {
        return nil;
    }
    
    NSArray *array = [self componentsSeparatedByString:@"."];
    
    if (!array) return nil;
    
    NSString *subUrl = [array lastObject];
    
    if ([subUrl isEqualToString:@""]||[subUrl isEqualToString:@"<null>"]|| !subUrl || [subUrl isEqualToString:@"(null)"] || [subUrl isKindOfClass:NSNull.class]) { // 没有后缀 或者 地址为空
        return nil;
    }
    
    NSRange range = [self rangeOfString:[NSString stringWithFormat:@".%@",subUrl]];
    NSUInteger avatarlength = range.location + range.length;
    if (avatarlength>[self length])//加保护 避免越界情况
    {
        
        return self;
    }
    
    return [self stringByReplacingCharactersInRange:range
                                         withString:[NSString stringWithFormat:@"_%@.%@",str,subUrl]];
    
}

@end

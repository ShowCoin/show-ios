//
//  NSString+Trim.m
//  show gx
//
//  Created by show  on 2017/10/10.
//  Copyright © 2017年 Show. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSString+Trim.h"

@implementation NSString (Trim)


+ (NSString *)trim:(NSString *)val trimCharacterSet:(NSCharacterSet *)characterSet {
    NSString *returnVal = @"";
    
    NSString * vall = [NSString stringWithFormat:@"%@",val]; //加保护
    if (vall) {
        returnVal = [vall stringByTrimmingCharactersInSet:characterSet];
    }
    
    return returnVal;
}

+ (NSString *)trimWhitespace:(NSString *)val {
    return [self trim:val trimCharacterSet:[NSCharacterSet whitespaceCharacterSet]]; //去掉前后空格
}


@end

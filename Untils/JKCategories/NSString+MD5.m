//
//  NSString+MD5.m
//  CreditGroup
//
//  Created by JPlay on 14-2-21.
//  Copyright (c) 2014年 JPlay. All rights reserved.
//

#import "NSString+MD5.h"
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>

@implementation NSString (MD5)

+(NSString *)MD5WithString:(NSString *)string{
    
    const char *cStr = [string UTF8String];
    unsigned char result[16];
    CC_MD5( cStr, strlen(cStr), result);
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

+(NSString *)MD5AndSaltString:(NSString *)string{
    static NSString *salt = @"2&g$MEpN98AXjZ91bS#euIZLrRkyTYSreF3Igy3aa@hS1HIN7VIk!WtEBs4*^h!G";
    NSString * newStr = [string stringByAppendingString:salt];
    NSString *anwen = [self MD5WithString:newStr];
    return anwen;
}

@end

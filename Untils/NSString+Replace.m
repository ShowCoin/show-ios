//
//  NSString+Replace.m
//  show live
//
//  Created by show gx on 2017/6/15.
//  Copyright © 2017年 Showgx. All rights reserved.
//

#import "NSString+Replace.h"

@implementation NSString (Replace)

/** 多个字符串替换 */
+(NSString *)replaceString:(NSString *)descString
                  keyArray:(NSArray <NSString *> *)keyArray
                valueArray:(NSArray <NSString *> *)valueArray {
    
    if (descString.length == 0 || descString == nil) return nil;
    if (keyArray.count == 0 || keyArray == nil) return nil;
    if (valueArray.count == 0 || valueArray == nil) return nil;
    if (valueArray.count != keyArray.count) return nil;
    
    
    NSMutableString *string = [[NSMutableString alloc] initWithString:descString];
    
    for (NSUInteger i = 0; i < keyArray.count; i++) {
        NSRange range = [string rangeOfString:keyArray[i]];
        [string replaceCharactersInRange:range withString:valueArray[i]];
    }
    
    return [string copy];
}


@end

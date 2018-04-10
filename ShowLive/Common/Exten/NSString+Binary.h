//
//  NSString+Binary.h
//  Shell
//
//  Created by sunjiaqi on 16/7/1.
//  Copyright © 2016年 show. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Binary)
//  十进制转二进制
+ (NSString *)toBinarySystemWithDecimalSystem:(NSString *)decimal;

//  二进制转十进制
+ (NSString *)toDecimalSystemWithBinarySystem:(NSString *)binary;

@end

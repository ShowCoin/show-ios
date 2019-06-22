//
//  NSString+Binary.h
//  showLive
//
//  Created by Z on 2018/4/1.
//  Copyright © 2018年 vning. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Binary)
//  十进制转二进制
+ (NSString *)toBinarySystemWithDecimalSystem:(NSString *)decimal;

//  二进制转十进制
+ (NSString *)toDecimalSystemWithBinarySystem:(NSString *)binary;

@end

//
//  NSString+JKBase64.h
//  JKCategories (https://github.com/shaojiankui/JKCategories)
//
//  Created by Jakey on 15/2/8.
//  Copyright (c) 2015年 www.skyfox.org. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (JKBase64)
//base64的string
+ (NSString *)jk_stringWithBase64EncodedString:(NSString *)string;
//base64的string和wrap
- (NSString *)jk_base64EncodedStringWithWrapWidth:(NSUInteger)wrapWidth;
//base64加密
- (NSString *)jk_base64EncodedString;
//base64解密
- (NSString *)jk_base64DecodedString;
//base64 解密DATA
- (NSData *)jk_base64DecodedData;
@end

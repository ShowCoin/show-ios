//
//  NSString+JKBase64.h
//  JKCategories (https://github.com/shaojiankui/JKCategories)
//
//  Created by Jakey on 15/2/8.
//  Copyright (c) 2015年 www.skyfox.org. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (JKBase64)
//base64的编码字符串
+ (NSString *)jk_stringWithBase64EncodedString:(NSString *)string;
//base64 编码wrapWidth
- (NSString *)jk_base64EncodedStringWithWrapWidth:(NSUInteger)wrapWidth;
- (NSString *)jk_base64EncodedString;
- (NSString *)jk_base64DecodedString;
- (NSData *)jk_base64DecodedData;
@end

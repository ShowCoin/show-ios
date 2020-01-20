//
//  NSString+MKNetworkKitAdditions.h
//  MKNetworkKitDemo
//
//  Created by Mugunth Kumar (@mugunthkumar) on 11/11/11.
//  Copyright (C) 2011-2020 by Steinlogic

//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

@interface NSString (MKNetworkKitAdditions)

- (NSString *)trim;
- (NSString *)trimString:(NSString *)string;
- (BOOL)isNilOrEmpty;
//+ (BOOL)isValidString:(NSString *)value;
- (NSString *) md5;
+ (NSString*) uniqueString;
- (NSString*) urlEncodedString;
- (NSString*) urlDecodedString;
- (NSDate *)date;
- (NSDate *)datetime;
+ (NSString *)fileSize:(long long)size;
- (BOOL)isValidatePhoneNumber;
- (BOOL)isValidateEmail;
- (BOOL)isChinese;
- (CGFloat)heightOfTextWithWidth:(float)width theFont:(UIFont*)aFont;
- (CGFloat)heightOfTextWithWidth:(float)width height:(float)height theFont:(UIFont*)aFont;

- (CGFloat)heightOfTextViewWithWidth:(float)width theFont:(UIFont*)aFont;
- (CGFloat)heightOfTextViewWithWidth:(float)width height:(float)height theFont:(UIFont*)aFont;

- (CGFloat)textViewHeightWithFont:(UIFont *)font width:(CGFloat)width;
- (CGFloat)textViewHeightWithAttributedString:(NSAttributedString *)attributedString width:(CGFloat)width;
- (CGFloat)textViewHeightWithAttributedString:(NSAttributedString *)attributedString width:(CGFloat)width limitedHeight:(CGFloat)height;
- (UIColor *)color;
- (BOOL)containsString:(NSString *)aString;
- (NSString*)telephoneWithReformat;
- (NSString *)pureUrl;
- (NSString *)urlWithWidth:(CGFloat)width;
- (NSString *)urlWithHeight:(CGFloat)height;
- (NSString *)urlWithSize:(CGSize)size;
- (NSString *)urlWithSizeForImage:(UIImage *)image;
+ (NSString *)spaceWithCount:(NSInteger)count;

//分转元
- (NSString *)pointToDollar;

//元转分
- (NSString *)dollarToPoint;

//数字转换成万
-(NSString *)numberToMyriad;

- (NSString *)typesetting;

- (NSMutableString*)urlWithStringFormatAddString:(NSString*)addString;//给字符串 添加 语音秒数

//文字高亮
- (NSAttributedString *)highlightColor:(UIColor *)color betweenIndex:(NSInteger)startIndex andIndex:(NSInteger)lastIndex;

//行间距
- (NSAttributedString *)spacingForLine:(NSInteger)spacing;
- (NSAttributedString *)attributedStringWithFontSize:(CGFloat)fontSize;
- (NSAttributedString *)attributedStringWithFontSize:(CGFloat)fontSize textColor:(UIColor *)color;
- (NSAttributedString *)attributedStringForTruncatingTail:(NSAttributedString *)attributedString;

//设置添加行间距后返回的内容
- (NSAttributedString *)spacingWithFont:(UIFont *)font LineSpacing:(NSInteger)spacing;
//根据添加行间距后的内容计算高度
- (CGFloat)heightOfAttributedText:(NSAttributedString*)attributed width:(float)width;
- (CGFloat)heightOfAttributedText:(NSAttributedString*)attributed width:(float)width limitedHeight:(CGFloat)height;
//data转换为十六进制的string
+ (NSString *)hexStringFromData:(NSData *)myD;
//json转字典
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;

-(NSString *)validNameString;
+ (BOOL)isSafePassword:(NSString *)strPwd;
+ (BOOL)isSafePhonePassword:(NSString *)strPwd;

@end

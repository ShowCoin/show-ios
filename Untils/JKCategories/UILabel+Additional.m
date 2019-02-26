//
//  UILabel+Additional.m
//  PublicProject
//
//  Created by user on 15/8/26.
//  Copyright (c) 2015年 家伟 李. All rights reserved.
//

#import "UILabel+Additional.h"

@implementation UILabel (Additional)
+ (instancetype)labelWithFrame:(CGRect)frame fontSize:(float)size{
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.font = [UIFont systemFontOfSize:size];
    label.textColor = [UIColor whiteColor];
    return label;
}

+ (instancetype)labelWithFrame:(CGRect)frame text:(NSString *)text textColor:(UIColor *)textColor font:(UIFont *)font{
    return [self labelWithFrame:frame text:text textColor:textColor font:font backgroundColor:[UIColor clearColor]];
}

+ (instancetype)labelWithFrame:(CGRect)frame text:(NSString *)text textColor:(UIColor *)textColor font:(UIFont *)font backgroundColor:(UIColor *)backgroundColor{
    return [self labelWithFrame:frame text:text textColor:textColor font:font backgroundColor:backgroundColor alignment:NSTextAlignmentLeft];
}

+ (instancetype)labelWithText:(NSString *)text font:(UIFont *)font alignment:(NSTextAlignment)alignment{
    return [self labelWithText:text textColor:[UIColor blackColor] font:font backgroundColor:[UIColor clearColor] alignment:alignment];
}

+ (instancetype)labelWithText:(NSString *)text textColor:(UIColor *)textColor font:(UIFont *)font backgroundColor:(UIColor *)backgroundColor alignment:(NSTextAlignment)alignment;{
    return [self labelWithFrame:CGRectZero text:text textColor:textColor font:font backgroundColor:backgroundColor alignment:alignment];
}

+ (instancetype)labelWithFont:(UIFont *)font alignment:(NSTextAlignment)alignment{
    return [self labelWithFont:font textColor:[UIColor blackColor] alignment:alignment];
}

+ (instancetype)labelWithFont:(UIFont *)font textColor:(UIColor *)textColor alignment:(NSTextAlignment)alignment{
    return [self labelWithFont:font textColor:textColor backgroundColor:[UIColor clearColor] alignment:alignment];
}

+ (instancetype)labelWithFont:(UIFont *)font textColor:(UIColor *)textColor backgroundColor:(UIColor *)backgroundColor alignment:(NSTextAlignment)alignment{
    return [self labelWithFrame:CGRectZero text:@"" textColor:textColor font:font backgroundColor:backgroundColor alignment:alignment];
}
+ (instancetype)labelWithFrame:(CGRect)frame text:(NSString *)text textColor:(UIColor *)textColor font:(UIFont *)font backgroundColor:(UIColor *)backgroundColor alignment:(NSTextAlignment)alignment{
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.text = text;
    label.textColor = textColor;
    label.font = font;
    label.backgroundColor = backgroundColor;
    label.textAlignment = alignment;
    return label;
}
@end

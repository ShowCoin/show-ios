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

@end

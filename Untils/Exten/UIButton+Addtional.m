//
//  UIButton+Addtional.m
//  PublicProject
//
//  Created by user on 15/8/26.
//  Copyright (c) 2015年 家伟 李. All rights reserved.
//

#import "UIButton+Addtional.h"

@implementation UIButton (Addtional)
+ (instancetype)buttonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor{
    return [self buttonWithTitle:title titleColor:titleColor backgroundColor:[UIColor whiteColor]];
}

+ (instancetype)buttonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor backgroundColor:(UIColor *)backgroundColor{
    return [self buttonWithTitle:title titleColor:titleColor font:[UIFont systemFontOfSize:16] backgroundColor:backgroundColor];
}

+ (instancetype)buttonWithTitleColor:(UIColor *)titleColor font:(UIFont *)font backgroundColor:(UIColor *)backgroundColor{
    return [self buttonWithTitle:@"" titleColor:titleColor font:font backgroundColor:backgroundColor];
}

+ (instancetype)buttonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor font:(UIFont *)font backgroundColor:(UIColor *)backgroundColor{
    return [self buttonWithType:UIButtonTypeCustom frame:CGRectZero title:title titleColor:titleColor font:font backgroundColor:backgroundColor];
}



@end

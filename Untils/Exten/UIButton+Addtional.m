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

+ (instancetype)buttonWithFrame:(CGRect)frame title:(NSString *)title titleColor:(UIColor *)titleColor font:(UIFont *)font backgroundColor:(UIColor *)backgroundColor{
    return [self buttonWithType:UIButtonTypeCustom frame:frame title:title titleColor:titleColor font:font backgroundColor:backgroundColor];
}

+ (instancetype)buttonWithType:(UIButtonType)buttonType frame:(CGRect)frame title:(NSString *)title titleColor:(UIColor *)titleColor font:(UIFont *)font backgroundColor:(UIColor *)backgroundColor{
    UIButton *button = [UIButton buttonWithType:buttonType];
    button.frame = frame;
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    button.titleLabel.font = font;
    button.backgroundColor = backgroundColor;
    return button;
}
- (void)xr_setButtonImageWithUrl:(NSString *)urlStr {
    NSURL * url = [NSURL URLWithString:urlStr];
    // 根据图片的url下载图片数据
    dispatch_queue_t xrQueue = dispatch_queue_create("loadImage", NULL); // 创建GCD线程队列
    dispatch_async(xrQueue, ^{
        // 异步下载图片
        UIImage * img = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
        // 主线程刷新UI
        dispatch_async(dispatch_get_main_queue(), ^{
            [self setImage:img forState:UIControlStateNormal];
        });
    });
}
+ (instancetype)buttonWithImage:(UIImage *)image frame:(CGRect)frame{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:image forState:UIControlStateNormal];
    btn.frame = frame;
    return btn;
}

+ (instancetype)buttonWithTitle:(NSString *)title frame:(CGRect)frame{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.titleLabel.font = [UIFont systemFontOfSize:15];
    [btn setTitle:title forState:UIControlStateNormal];
    btn.frame = frame;
    return btn;
}

@end

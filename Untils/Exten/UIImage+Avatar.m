//
//  UIImage+Avatar.m
//  O2O_storePhone
//
//  Created by hanlei on 16/8/22.
//  Copyright © 2016年 hanlei. All rights reserved.
//

#import "UIImage+Avatar.h"

@implementation UIImage (Avatar)
/**
 *  二维码添加头像
 *
 *  @param bgImage     背景（二维码）
 *  @param logoImage  logo
 *  @param size        绘制区域大小
 *
 *  @return newImage
 */
+ (UIImage *)imagewithBgImage:(UIImage *)bgImage addLogoImage:(UIImage *)LogoImage ofTheSize:(CGSize)size;
{
    if (LogoImage == nil) {
        return bgImage;
    }
    BOOL opaque = 1.0;
    // 获取当前设备的scale
    CGFloat scale = [UIScreen mainScreen].scale;
    // 创建画布Rect
    CGRect bgRect = CGRectMake(0, 0, size.width, size.height);
    // 头像大小 _不能大于_ 画布的1/4 （这个大小之内的不会遮挡二维码的有效信息）
    CGFloat avatarWidth = (size.width/4.0);
    CGFloat avatarHeight = avatarWidth;
    //MARK:-调用一个新的切割绘图方法 crop image add cornerRadius  (裁切头像图片为圆角，并添加bored   返回一个newimage)
    LogoImage = [UIImage clipCornerRadius:LogoImage withSize:CGSizeMake(avatarWidth, avatarHeight)];
    // 设置头像的位置信息
    CGPoint position = CGPointMake(size.width/2.0, size.height/2.0);
    CGRect avatarRect = CGRectMake(position.x-(avatarWidth/2.0), position.y-(avatarHeight/2.0), avatarWidth, avatarHeight);
    
    // 设置画布信息
    UIGraphicsBeginImageContextWithOptions(size, opaque, scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSaveGState(context);{// 开启画布
        // 翻转context （画布）
        CGContextTranslateCTM(context, 0, size.height);
        CGContextScaleCTM(context, 1, -1);
        // 根据 bgRect 用二维码填充视图
        CGContextDrawImage(context, bgRect, bgImage.CGImage);
        //  根据newLogoImage 填充头像区域
        CGContextDrawImage(context, avatarRect, LogoImage.CGImage);
        
    }CGContextRestoreGState(context);// 提交画布
    // 从画布中提取图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    // 释放画布
    UIGraphicsEndImageContext();
    return image;
}

+ (UIImage *)clipCornerRadius:(UIImage *)image withSize:(CGSize) size
{
    // 白色border的宽度
    CGFloat outerWidth = size.width/15.0;
    // 黑色border的宽度
    CGFloat innerWidth = outerWidth/10.0;
    // 圆角这个就是我觉着的适合的一个值 ，可以自行改
    CGFloat corenerRadius = size.width/5.0;
    // 为context创建一个区域
    CGRect areaRect = CGRectMake(0, 0, size.width, size.height);
    UIBezierPath *areaPath = [UIBezierPath bezierPathWithRoundedRect:areaRect byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(corenerRadius, corenerRadius)];
    
    // 因为UIBezierpath划线是双向扩展的 初始位置就不会是（0，0）
    // origin position
    CGFloat outerOrigin = outerWidth/2.0;
    CGFloat innerOrigin = innerWidth/2.0 + outerOrigin/1.2;
    CGRect outerRect = CGRectInset(areaRect, outerOrigin, outerOrigin);
    CGRect innerRect = CGRectInset(outerRect, innerOrigin, innerOrigin);
    //  外层path
    UIBezierPath *outerPath = [UIBezierPath bezierPathWithRoundedRect:outerRect byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(outerRect.size.width/5.0, outerRect.size.width/5.0)];
    //  内层path
    UIBezierPath *innerPath = [UIBezierPath bezierPathWithRoundedRect:innerRect byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(innerRect.size.width/5.0, innerRect.size.width/5.0)];
    // 创建上下文
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);{
        // 翻转context
        CGContextTranslateCTM(context, 0, size.height);
        CGContextScaleCTM(context, 1, -1);
        // context  添加 区域path -> 进行裁切画布
        CGContextAddPath(context, areaPath.CGPath);
        CGContextClip(context);
        // context 添加 背景颜色，避免透明背景会展示后面的二维码不美观的。（当然也可以对想遮住的区域进行clear操作，但是我当时写的时候还没有想到）
        CGContextAddPath(context, areaPath.CGPath);
        UIColor *fillColor = [UIColor colorWithRed:0.85 green:0.85 blue:0.85 alpha:1];
        CGContextSetFillColorWithColor(context, fillColor.CGColor);
        CGContextFillPath(context);
        // context 执行画头像
        CGContextDrawImage(context, innerRect, image.CGImage);
        // context 添加白色的边框 -> 执行填充白色画笔
        CGContextAddPath(context, outerPath.CGPath);
        CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:0.85 green:0.85 blue:0.85 alpha:1].CGColor);
        CGContextSetLineWidth(context, outerWidth);
        CGContextStrokePath(context);
        // context 添加黑色的边界假象边框 -> 执行填充黑色画笔
        CGContextAddPath(context, innerPath.CGPath);
        CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
        CGContextSetLineWidth(context, innerWidth);
        CGContextStrokePath(context);

    }CGContextRestoreGState(context);
    UIImage *radiusImage  = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return radiusImage;
}


@end

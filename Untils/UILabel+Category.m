//
//  UILabel+Category.m
//  show
//
//  Created by showgx on 15/9/6.
//  Copyright (c) 2015年 show. All rights reserved.
//

#import "UILabel+Category.h"
@implementation UILabel (Category)
//label自适应宽度
+ (CGFloat)getLabelWidthWithText:(NSString *)text wordSize:(CGFloat)wordSize height:(CGFloat)height
{
    UIFont * fnt = [UIFont fontWithName:TextFontName size:wordSize];
    
    CGRect tmpRect = [text boundingRectWithSize:CGSizeMake(MAXFLOAT, height) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:[NSDictionary dictionaryWithObjectsAndKeys:fnt,NSFontAttributeName, nil] context:nil];
    
    return tmpRect.size.width;
}

//label自适应高度
+ (CGFloat)getLabelHeightWithText:(NSString *)text wordSize:(CGFloat)wordSize width:(CGFloat)width
{
    UIFont * fnt = [UIFont fontWithName:TextFontName size:wordSize];
    
    CGRect tmpRect = [text boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObjectsAndKeys:fnt,NSFontAttributeName, nil] context:nil];
    return tmpRect.size.height;
}

+(UILabel*)setLabelFrame:(CGRect)frame Text:(NSString *)text TextColor:(UIColor *)color font:(UIFont *)font textAlignment:(NSTextAlignment)textAlignment
{
    UILabel * label=[[UILabel alloc]initWithFrame:frame];
    label.text=text;
    label.textColor=color;
    label.font=font;
    label.textAlignment=textAlignment;
    
    
    return label;
    
}









@end

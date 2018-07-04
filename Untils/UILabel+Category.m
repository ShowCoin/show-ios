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




@end

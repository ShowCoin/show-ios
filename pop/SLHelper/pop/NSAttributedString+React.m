//
//  NSAttributedString+React.m
//  show gx
//
//  Created by show gx on 17/3/20.
//  Copyright © 2017年 Show. All rights reserved.
//

#import "NSAttributedString+React.h"

@implementation NSAttributedString (React)
-(CGFloat)getWidthWithAttributeString:(NSMutableAttributedString *)attributeString labelheight:(CGFloat)height
{
    CGRect tmpRect = [self boundingRectWithSize:CGSizeMake(MAXFLOAT, height) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading|NSStringDrawingTruncatesLastVisibleLine context:nil];
    
    return ceilf(tmpRect.size.width);
}
-(CGFloat)getHeightWithAttributeString:(NSMutableAttributedString *)attributeString labelwidth:(CGFloat)width
{
    CGRect tmpRect = [self boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading|NSStringDrawingTruncatesLastVisibleLine context:nil];
    
    return ceilf(tmpRect.size.height);
}

-(CGFloat)getWidthWithFont:(UIFont *)font height:(CGFloat)height
{
    CGRect tmpRect = [self boundingRectWithSize:CGSizeMake(MAXFLOAT, height) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading context:nil];
    
    return tmpRect.size.width;
}
-(CGFloat)getHeightWithFont:(UIFont *)font width:(CGFloat)width
{
    
    CGRect tmpRect = [self boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil];
    return tmpRect.size.height;
}
@end

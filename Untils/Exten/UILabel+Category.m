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


- (CGSize)boundingRectWithHeight:(CGFloat)height
{
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 7.0) {
        
        NSDictionary *attribute = @{NSFontAttributeName: self.font};
        
        return [self.text boundingRectWithSize:CGSizeMake(0, height)
                                       options:\
                NSStringDrawingTruncatesLastVisibleLine |
                NSStringDrawingUsesLineFragmentOrigin |
                NSStringDrawingUsesFontLeading
                                    attributes:attribute
                                       context:nil].size;
    } else {
        return [self.text sizeWithFont:self.font constrainedToSize:CGSizeMake(CGFLOAT_MAX, height) lineBreakMode:self.lineBreakMode];
    }
}

-(CGSize)getLabelSize {
    
    return [self.text boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)
                                   options:NSStringDrawingUsesLineFragmentOrigin
                                attributes:@{NSFontAttributeName: self.font}
                                   context:nil].size;
}


-(CGSize)getLabelAttributedSize {
    return [self.attributedText boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)
                                             options:NSStringDrawingUsesLineFragmentOrigin
                                             context:nil].size;
}

- (void)setText:(NSString*)text lineSpacing:(CGFloat)lineSpacing {
    if (lineSpacing < 0.01 || !text) {
        self.text = text;
        return;
    }
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:text];
    [attributedString addAttribute:NSFontAttributeName value:self.font range:NSMakeRange(0, [text length])];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpacing];
    [paragraphStyle setLineBreakMode:self.lineBreakMode];
    [paragraphStyle setAlignment:self.textAlignment];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [text length])];
    
    self.attributedText = attributedString;
}







@end

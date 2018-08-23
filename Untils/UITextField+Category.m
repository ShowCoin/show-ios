//
//  UITextField+Category.m
//  show gx
//
//  Created by show on 16/6/21.
//  Copyright © 2016年 show gx. All rights reserved.
//

#import "UITextField+Category.h"

@implementation UITextField (Category)
-(void)setPlaceholder:(NSString *)placeholder withFont:(UIFont *)font color:(UIColor *)color
{
    
    NSMutableParagraphStyle *style =[[self.defaultTextAttributes objectForKey:NSParagraphStyleAttributeName] mutableCopy];
    
    style.minimumLineHeight =self.font.lineHeight - (self.font.lineHeight -font.lineHeight)/2;
    
    NSMutableAttributedString * attString=[[NSMutableAttributedString alloc]initWithString:placeholder];
    
    NSDictionary *attrsDictionary = [NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName,color,NSForegroundColorAttributeName,style,NSParagraphStyleAttributeName, nil];
    
    
    [attString addAttributes:attrsDictionary range:NSMakeRange(0, placeholder.length)];
    
    self.attributedPlaceholder=attString;
    self.keyboardAppearance=UIKeyboardAppearanceDark;

}

-(void)setPlaceholder:(NSString *)placeholder withFont:(float)font color:(NSString *)color alpha:(float)alpha
{
    
    self.placeholder = [NSString stringWithFormat:@" %@",placeholder];
    [self setValue:[UIColor customColorWithString:color] forKeyPath:@"_placeholderLabel.textColor"];
    [self setValue:[UIFont fontWithName:TextFontName size:font] forKeyPath:@"_placeholderLabel.font"];
    [self setValue:[NSNumber numberWithFloat:alpha] forKeyPath:@"_placeholderLabel.alpha"];
    
}

@end

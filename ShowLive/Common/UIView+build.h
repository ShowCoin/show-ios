//
//  UIView+build.h 
//  Secret
//
//  Created by Tim on 14-3-5.
//  Copyright (c) 2014年 Wk. All rights reserved.

#import <UIKit/UIKit.h>

@interface UIView(build)
-(UILabel*)buildLabel:(NSString*)text withFrame:(CGRect)frame withFont:(UIFont*)font withTextColor:(UIColor*)color withTextAlign:(NSTextAlignment)align;
-(UIImageView*)buildImageView:(NSString*)imageName withFrame:(CGRect)frame;
-(UIView*)buildView:(UIColor*)bgColor withFrame:(CGRect)frame;
-(UITextField*)buildTextField:(UIColor*)bgColor withFrame:(CGRect)frame withPlaceholder:(NSString*)placeholder withTextColor:(UIColor*)textColor withFont:(UIFont*)font withReturnKeyType:(UIReturnKeyType)returnKeyType withKeyboardType:(UIKeyboardType)keyboardType;
//-(UIButton*)buildButton:(NSString*)title withFrame:(CGRect)frame withTitleColor:(UIColor*)color withTarget:(id)target withAction:(SEL)action withBoderWidth:(CGFloat)boderWidth withBoderColor:(UIColor*)boderColor withBockgroundColor:(UIColor*)bgColor;
-(UIButton*)buildButton:(NSString*)title withFrame:(CGRect)frame withTitleColor:(UIColor*)color withTarget:(id)target withAction:(SEL)action withBoderWidth:(CGFloat)boderWidth withBoderColor:(UIColor*)boderColor withBackgroundColor:(UIColor*)bgColor withSelectedBgColor:(UIColor*)selectedBgColor;

-(UIView*)poptips:(NSString*)tips;
-(UIView*)processingDefault;
-(UIView*)processing:(NSString*)tips;
-(void)fadeProcessingView;
@end

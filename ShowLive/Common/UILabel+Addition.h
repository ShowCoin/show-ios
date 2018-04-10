//
//  NSArray+Addition.h

//
//  Copyright © 2016年 will23. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Addition)
/**
 返回一个Label控件
 
 @param text  label上显示的文字
 @param font  字体大小
 @param color 文字颜色
 */
+ (UILabel *)makeLabelWithText:(NSString *)text andTextFont:(CGFloat)font andTextColor:(UIColor *)color;
@end

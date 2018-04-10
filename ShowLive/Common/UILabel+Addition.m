///
//  NSArray+Addition.h

//
//  Copyright © 2016年 will23. All rights reserved.
//


#import "UILabel+Addition.h"

@implementation UILabel (Addition)
+ (UILabel *)makeLabelWithText:(NSString *)text andTextFont:(CGFloat)font andTextColor:(UIColor *)color {
    
    UILabel *label = [[UILabel alloc] init];
    label.text = text;
    // 设置字体大小
    label.font = [UIFont systemFontOfSize:font];
    // 设置文字颜色
    label.textColor = color;
    
    return label;
}
@end

//
//  UILabel+Category.h
//  show
//
//  Created by show on 15/9/6.
//  Copyright (c) show. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Category)

//获取label的宽度
+ (CGFloat)getLabelWidthWithText:(NSString *)text wordSize:(CGFloat)wordSize height:(CGFloat)height;



@end

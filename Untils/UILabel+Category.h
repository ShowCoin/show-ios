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

//获取label的高度
+ (CGFloat)getLabelHeightWithText:(NSString *)text wordSize:(CGFloat)wordSize width:(CGFloat)width;


//创建label
+(UILabel*)setLabelFrame:(CGRect)frame Text:(NSString*)text TextColor:(UIColor*)color font:(UIFont*)font textAlignment:(NSTextAlignment)textAlignment;


/**
 *  生成文本的尺寸
 *
 *  @param height 文本的高度
 *
 *  @return 文本尺寸
 */
- (CGSize)boundingRectWithHeight:(CGFloat)height;



@end

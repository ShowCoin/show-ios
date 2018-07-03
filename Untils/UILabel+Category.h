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



/**
 获取Lbael的大小（此方法使用前需设置好label的font,text,返回大小以单行计算）

 @return Label大小
 */
-(CGSize)getLabelSize;

-(CGSize)getLabelAttributedSize;

/**
 设置行间距
 @param text 文本
 @param lineSpacing 间距
 */

- (void)setText:(NSString*)text lineSpacing:(CGFloat)lineSpacing;

@end

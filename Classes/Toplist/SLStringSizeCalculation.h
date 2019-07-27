//
//  SLStringSizeCalculation.h
//  ShowLive
//
//  Created by iori_chou on 2018/4/11.
//  Copyright © 2018年 vning. All rights reserved.
//

#import <Foundation/Foundation.h>

@class YYTextLayout;

@interface SLStringSizeCalculation : NSObject

/// 计算attributeString size
+ (CGSize)sizeOfLabelWithAttributedString:(NSAttributedString *)attributedString baseOnSize:(CGSize)baseOnSize;
/// 计算label size
+ (CGSize)sizeOfLabelWithString:(NSString *)string baseOnSize:(CGSize)baseOnSize font:(UIFont *)font;

/// 获取YYTextLayout
+ (YYTextLayout *)getYYTextLayoutWithAttributedString:(NSAttributedString *)attributedString baseOnSize:(CGSize)size;
/// 获取YYText布局 size
+ (CGSize)sizeOfYYTextWithAttributedString:(NSAttributedString *)attributedString baseOnSize:(CGSize)baseOnSize;

@end

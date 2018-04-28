//
//  SLStringSizeCalculation.m
//  ShowLive
//
//  Created by Mac on 2018/4/11.
//  Copyright © 2018年 VNing. All rights reserved.
//

#import "SLStringSizeCalculation.h"
#import "YYTextLayout.h"

@implementation SLStringSizeCalculation
+ (CGSize)sizeOfLabelWithAttributedString:(NSAttributedString *)attributedString baseOnSize:(CGSize)baseOnSize
{
    CGRect rect = [attributedString boundingRectWithSize:baseOnSize options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading context:nil];
    return CGSizeMake( ceil(rect.size.width), ceil(rect.size.height) );
}

+ (CGSize)sizeOfLabelWithString:(NSString *)string baseOnSize:(CGSize)baseOnSize font:(UIFont *)font
{
    CGSize size = [string boundingRectWithSize:baseOnSize options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesFontLeading attributes:@{ NSFontAttributeName: font } context:nil].size;
    return CGSizeMake( ceil(size.width), ceil(size.height) );
}

+ (YYTextLayout *)getYYTextLayoutWithAttributedString:(NSAttributedString *)attributedString baseOnSize:(CGSize)size
{
    YYTextLayout *layout = [YYTextLayout layoutWithContainerSize:size text:attributedString];
    return layout;
}

+ (CGSize)sizeOfYYTextWithAttributedString:(NSAttributedString *)attributedString baseOnSize:(CGSize)baseOnSize
{
    return [self getYYTextLayoutWithAttributedString:attributedString baseOnSize:baseOnSize].textBoundingSize;
}

@end

//
//  NSAttributedString+KMHeight.m
//  ShowLive
//
//  Created by sunjiaqi on 2017/11/28.
//  Copyright © 2017年 show. All rights reserved.
//

#import "NSAttributedString+KMHeight.h"
#import "YYTextLayout.h"

@implementation NSAttributedString (KMHeight)

-(CGSize)attributedStringSize:(CGSize)MaxSize{
    YYTextLayout *layout = [YYTextLayout layoutWithContainerSize:MaxSize text:self];
    return layout.textBoundingSize;
}

@end

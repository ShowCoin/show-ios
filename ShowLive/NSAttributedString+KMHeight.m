//
//  NSAttributedString+KMHeight.m
//  ShowLive
//
//  Created by iori_chou on 18/4/1.
//  Copyright © 2018年 show. All rights reserved.
//

#import "NSAttributedString+KMHeight.h"
#import "YYTextLayout.h"

@implementation NSAttributedString (KMHeight)

-(CGSize)attributedStringSize:(CGSize)MaxSize{
    YYTextLayout *layout = [YYTextLayout layoutWithContainerSize:MaxSize text:self];
    return layout.textBoundingSize;
}

@end

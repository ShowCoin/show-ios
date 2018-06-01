//
//  SLVerticalButton.m
//  ShowLive
//
//  Created by 陈英豪 on 2018/5/30.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "SLVerticalButton.h"

CGFloat const kMAButtonW = 44;
CGFloat const kMAButtonH = 44 + 17;

@implementation SLVerticalButton

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat w = self.frame.size.width;
    CGFloat h = self.frame.size.height;
    
    CGFloat titleH = self.titleLabel.font.lineHeight;
    CGFloat margin = (h - CGRectGetMaxY(self.imageView.frame) - titleH) / 3;
    margin = margin > 0 ? margin : 0;
    self.imageView.frame = CGRectMake(0, margin, w, w);
    CGFloat titleY = CGRectGetMaxY(self.imageView.frame) + margin;
    self.titleLabel.frame = CGRectMake(0, titleY, w, titleH);
}

- (void)sl_noSelect {
    self.selected = NO;
}

@end

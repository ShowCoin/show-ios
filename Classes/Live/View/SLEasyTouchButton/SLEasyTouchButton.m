//
//  SLEasyTouchButton.m
//  ShowLive
//
//  Created by gongxin on 2018/5/29.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "SLEasyTouchButton.h"

/**
 <#Description#>
 */
@implementation SLEasyTouchButton

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent*)event
{
    
    CGRect bounds = self.bounds;
    CGFloat widthDelta = MAX(44.0 - bounds.size.width, 0);
    CGFloat heightDelta = MAX(44.0 - bounds.size.height, 0);
    bounds = CGRectInset(bounds, -0.5 * widthDelta, -0.5 * heightDelta);
    return CGRectContainsPoint(bounds, point);
    
}

@end


@implementation SLTakeButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.titleLabel.textColor = [UIColor whiteColor];
        //self.backgroundColor = [Color(@"0C0C0C") colorWithAlphaComponent:0.5];
        self.titleLabel.font = [UIFont pingfangMediumWithSize:9];
        [self setTitle:@"收\n起" forState:UIControlStateNormal];
        [self setTitle:@"榜\n单\n详\n情" forState:UIControlStateSelected];
        [self setTitleColor:HexRGBAlpha(0xf7f7f7, 0.7) forState:UIControlStateNormal];
        [self setTitleColor:HexRGBAlpha(0x171717, 1) forState:UIControlStateSelected];
        [self setImage:[UIImage imageNamed:@"live_end_right"] forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:@"live_end_left"] forState:UIControlStateSelected];
        [self setBackgroundImage:nil forState:UIControlStateNormal];
        [self setBackgroundImage:[UIImage imageNamed:@"live_end_more"] forState:UIControlStateSelected];
        self.titleLabel.numberOfLines = 0;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat w = CGRectGetWidth(self.frame);
    CGFloat h = CGRectGetHeight(self.frame);
    
    CGRect imageF = self.imageView.frame;
    CGRect titleF = self.titleLabel.frame;
    
    CGFloat margin = (h - imageF.size.height - titleF.size.height - 3) / 2;
    
    imageF.origin.x = (w - imageF.size.width) / 2;
    imageF.origin.y = margin;
    self.imageView.frame = imageF;
    
    titleF.origin.x = 0;
    titleF.origin.y = CGRectGetMaxY(imageF) + 2;
    titleF.size.width = w;
    self.titleLabel.frame = titleF;
}

@end

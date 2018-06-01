//
//  SLMoreActionView.m
//  Animation
//
//  Created by 陈英豪 on 2018/5/28.
//  Copyright © 2018年 chuxia. All rights reserved.
//

#import "SLMoreActionView.h"

CGFloat const kSLMoreActionViewH = 140;

@interface SLMoreActionView ()

@property (nonatomic, strong) NSMutableArray *views;

@end

@implementation SLMoreActionView

- (void)initView
{
    [super initView];
    
    [self addEffect:UIBlurEffectStyleDark];
    
    self.views = [NSMutableArray array];
    NSArray *images = @[@"live_more_pause", @"live_more_message"];
    NSArray *titles = @[@"暂停", @"私信"];
    
    for (int i = 0; i < images.count; i++) {
        SLVerticalButton *button = [SLVerticalButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:titles[i] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:images[i]] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        button.titleLabel.font = [UIFont systemFontOfSize:13];
        button.titleLabel.textAlignment = NSTextAlignmentCenter;
        button.backgroundColor = [UIColor orangeColor];
        button.tag = i;
        [self addSubview:button];
        [self.views addObject:button];
    }
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat w = self.frame.size.width;
    CGFloat h = self.frame.size.height;

    CGFloat y = (h - kMAButtonH) / 2;
    NSInteger count = self.views.count;
    CGFloat margin = (w - count * kMAButtonW) / (count + 1);
    CGFloat x = margin;
    for (int i = 0; i < self.views.count; i++) {
        UIView *v = self.views[i];
        v.frame = CGRectMake(x, y, kMAButtonW, kMAButtonH);
        x += margin + kMAButtonW;
    }
}

- (void)buttonAction:(UIButton *)button {
    if (self.clickBlock) {
        self.clickBlock(button.tag);
    }
}

@end


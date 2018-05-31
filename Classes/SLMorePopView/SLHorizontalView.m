//
//  SLHorizontalView.m
//  ShowLive
//
//  Created by 陈英豪 on 2018/5/30.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "SLHorizontalView.h"
#import "SLVerticalButton.h"

NSString * const kHorizontalViewTitle = @"kHorizontalViewTitle";
NSString * const kHorizontalViewImage = @"kHorizontalViewImage";
CGFloat const kSLHorizontalViewH = 70 * 2;
NSInteger const kRowCount = 3;

@interface SLHorizontalView ()

@property (nonatomic, strong) NSMutableArray *views;

@end

@implementation SLHorizontalView

- (void)setDatas:(NSArray *)datas {
    _datas = datas;
    
    for (int i = 0; i < datas.count; i++) {
        NSDictionary *dic = datas[i];
        SLVerticalButton *button = [SLVerticalButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:dic[kHorizontalViewTitle] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:dic[kHorizontalViewImage]] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        button.titleLabel.font = [UIFont systemFontOfSize:13];
        button.titleLabel.textAlignment = NSTextAlignmentCenter;
        button.tag = i;
        
        [self addSubview:button];
        [self.views addObject:button];
    }
    [self setNeedsDisplay];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat w = self.frame.size.width;
    CGFloat h = self.frame.size.height;
    
    CGFloat y = (h - kMAButtonH) / 2;
    NSInteger count = self.views.count;
    CGFloat margin = (w - count * kMAButtonW) / (count + 1);
    CGFloat x = margin;
    
//    CGFloat kMargin = (w - kRowCount * kMAButtonW) / (kRowCount + 1);
//    NSInteger row =
//    
//    for (int i = 0; i < self.views.count; i++) {
//        UIView *v = self.views[i];
//        v.frame = CGRectMake(x, y, kMAButtonW, kMAButtonH);
//        x += margin + kMAButtonW;
//    }
}

- (void)buttonAction:(UIButton *)button {
    if (self.clickBlock) {
        self.clickBlock(button);
    }
}


- (NSMutableArray *)views {
    if (!_views) {
        _views = [NSMutableArray array];
    }
    return _views;
}

@end

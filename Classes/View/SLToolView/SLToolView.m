//
//  SLToolView.m
//  ShowLive
//
//  Created by 陈英豪 on 2018/5/28.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "SLToolView.h"
#import "SLMoreActionView.h"

CGFloat const kSLToolViewH  = 140;

@interface SLToolView ()

@property (nonatomic, strong) NSMutableArray *views;
@property (nonatomic, strong) SLTitleView *topView;

@end

@implementation SLToolView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        SLTitleView *top = [SLTitleView new];
        top.titleLabel.text = @"工具";
        [self addSubview:top];
        self.topView = top;
        
        self.views = [NSMutableArray array];
        // @"live_tool_resume"
        NSArray *images = @[@"live_tool_pause", @"live_tool_clear"];
        NSArray *titles = @[@"暂停", @"清屏"];
        
        for (int i = 0; i < images.count; i++) {
            SLVerticalButton *button = [SLVerticalButton buttonWithType:UIButtonTypeCustom];
            [button setTitle:titles[i] forState:UIControlStateNormal];
            [button setImage:[UIImage imageNamed:images[i]] forState:UIControlStateNormal];
            [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
            button.titleLabel.font = [UIFont systemFontOfSize:13];
            button.titleLabel.textAlignment = NSTextAlignmentCenter;
            button.tag = i;
            
            if (i == SLLiveToolTypeClear) {
                [button setImage:[UIImage imageNamed:@"live_tool_resume"] forState:UIControlStateSelected];
                [button setTitle:@"恢复" forState:UIControlStateSelected];
            }
            
            [self addSubview:button];
            [self.views addObject:button];
        }
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat w = self.frame.size.width;
    CGFloat h = self.frame.size.height;
    
    self.topView.frame = CGRectMake(0, 0, w, kTitleViewH);
    
    CGFloat y = (h - kMAButtonH - kTitleViewH) / 2;
    NSInteger count = self.views.count;
    CGFloat margin = (w - count * kMAButtonW) / (count + 1);
    CGFloat x = margin;
    for (int i = 0; i < self.views.count; i++) {
        UIView *v = self.views[i];
        v.frame = CGRectMake(x, y + kTitleViewH, kMAButtonW, kMAButtonH);
        x += margin + kMAButtonW;
    }
}


/**
 UIButton

 @param button <#button description#>
 */
- (void)buttonAction:(UIButton *)button {
    if (button.tag == SLLiveToolTypeClear) {
        button.selected = !button.selected;
        self.clearSelect = button.selected;
    }
    if (self.clickBlock) {
        self.clickBlock(button.tag);
    }
}



@end

@implementation SLTitleView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UILabel *title = [UILabel new];
        title.font = [UIFont systemFontOfSize:12];
        title.textColor = kGrayWith999999;
        title.textAlignment = NSTextAlignmentCenter;
        [self addSubview:title];
        self.titleLabel = title;
        
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.titleLabel.frame = self.bounds;
}

@end


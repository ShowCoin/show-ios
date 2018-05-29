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


@end


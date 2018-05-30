//
//  SLTextView.m
//  ShowLive
//
//  Created by vning on 2018/5/27.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "SLTextView.h"

@implementation SLTextView
//没有粘贴板的uitextview
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //Initialzation code
    }
    return self;
}
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    UIMenuController *menuController = [UIMenuController sharedMenuController];
    if (menuController) {
        //设置为不可用
        [UIMenuController sharedMenuController].menuVisible = NO;
    }
    return NO;
}

@end

//
//  SLLinkLabel.m
//  ShowLive
//
//  Created by vning on 2018/5/31.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "SLLinkLabel.h"

@implementation SLLinkLabel

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addCopyForLabel];
    }
    return self;
}

- (void)awakeFromNib {
    
    [super awakeFromNib];
    [self addCopyForLabel];
}
#pragma mark -- 可复制

- (void)addCopyForLabel
{
    self.userInteractionEnabled = YES;
    UILongPressGestureRecognizer *longTouch = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longTouchAction:)];
    longTouch.minimumPressDuration = 1;
    [self addGestureRecognizer:longTouch];
}

- (BOOL)canBecomeFirstResponder {
    return YES;
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    return action == @selector(copyTextInThisLabel:);
}

- (void)copyTextInThisLabel:(id)sender {
    UIPasteboard *pasteBoard = [UIPasteboard generalPasteboard];
    pasteBoard.string = self.text;
}

- (void)longTouchAction:(UIGestureRecognizer *)recognizer {
    [self becomeFirstResponder];
    UIMenuItem *copyItem = [[UIMenuItem alloc] initWithTitle:@"复制" action:@selector(copyTextInThisLabel:)];
    [[UIMenuController sharedMenuController] setMenuItems:[NSArray arrayWithObjects:copyItem, nil]];
    [[UIMenuController sharedMenuController] setTargetRect:self.frame inView:self.superview];
    [[UIMenuController sharedMenuController] setMenuVisible:YES animated:YES];
}



@end

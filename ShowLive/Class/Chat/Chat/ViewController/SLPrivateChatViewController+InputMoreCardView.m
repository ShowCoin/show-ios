//
//  SLPrivateChatViewController+InputMoreCardView.m
//  ShowLive
//
//  Created by Mac on 2018/4/11.
//  Copyright © 2018年 VNing. All rights reserved.
//

#import "SLPrivateChatViewController+InputMoreCardView.h"
#import "SLPrivateChatViewController+InputView.h"
#import "SLPrivateChatViewController+TableView.h"
#import "SLPrivateChatViewController+Events.h"
#import "SLPrivateChatViewController+Business.h"
#import "SLPrivateChatViewController+Common.h"
#import "SLPrivateChatViewController+Emoji.h"
#import <objc/runtime.h>

@implementation SLPrivateChatViewController (InputMoreCardView)
#pragma mark - Property
- (BOOL)isInputMoreCardViewShow
{
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setIsInputMoreCardViewShow:(BOOL)isInputMoreCardViewShow
{
    [self setInputMoreCardViewShow:isInputMoreCardViewShow];
    objc_setAssociatedObject(self, @selector(isInputMoreCardViewShow), @(isInputMoreCardViewShow), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (SLConversationInputMoreCardView *)inputMoreCardView
{
    id obj = objc_getAssociatedObject(self, _cmd);
    if (!obj) {
        obj = [self loadInputMoreCardView];
    }
    return obj;
}

- (void)setInputMoreCardView:(SLConversationInputMoreCardView *)inputMoreCardView
{
    objc_setAssociatedObject(self, @selector(inputMoreCardView), inputMoreCardView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - Private
- (SLConversationInputMoreCardView *)loadInputMoreCardView
{
    SLConversationInputMoreCardView *inputMoreCardView = [[SLConversationInputMoreCardView  alloc] initWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth, _GetChatInputMoreCardHeight())];
    inputMoreCardView.delegate = self;
    self.inputMoreCardView = inputMoreCardView;
    return inputMoreCardView;
}

- (void)setInputMoreCardViewShow:(BOOL)show
{
    if (self.isInputMoreCardViewShow == show) {
        return;
    }
    
    if (show) {
        self.isEmojiViewShow = NO;
        
        // 把语音状态更改为自然状态
        if (self.chatInputView.isAutioMsg) {
            self.chatInputView.isAutioMsg = NO;
        }
        self.inputMoreCardView.top = self.chatInputView.bottom + KTabbarSafeBottomMargin;
        [self.view addSubview:self.inputMoreCardView];
        
        [self scrollToBottomAnimated:YES];
        
        CGFloat bottomH = _GetChatInputViewHeight();
        CGFloat distance = self.inputMoreCardView.height;;
        CGFloat minH =  kScreenHeight - kNaviBarHeight  - bottomH - distance - KTabbarSafeBottomMargin;
        CGFloat maxH = kScreenHeight- kNaviBarHeight - bottomH - KTabbarSafeBottomMargin;
        CGFloat newH = minH;
        
        // content 高度
        CGFloat contentH = self.tableView.contentSize.height + self.tableView.contentInset.top + self.tableView.contentInset.bottom;
        CGFloat move = 0;
        if (contentH > minH) {
            move = contentH - minH ;
            move = move > distance ? distance : move;
            newH = contentH < maxH ? contentH : maxH;
        }
        
        [UIView animateWithDuration:0.25 delay:0 options:0 animations:^{
            self.tableView.height = newH;
            self.tableView.transform = CGAffineTransformMakeTranslation(0, -move);
            self.chatInputView.top = self.tableView.bottom;
            self.inputMoreCardView.top = self.chatInputView.bottom;
            self.chatInputView.moreButton.transform = CGAffineTransformMakeRotation(M_PI_4*3);
            
        } completion:nil];
        
    } else {
        if (!self.inputMoreCardView.superview) {
            return;
        }
        
        [UIView animateWithDuration:0.25 delay:0 options:0 animations:^{
            self.tableView.height = kMainScreenHeight- _GetChatInputViewHeight() - kNaviBarHeight - KTabbarSafeBottomMargin;
            self.chatInputView.bottom = self.view.bottom - KTabbarSafeBottomMargin;
            self.inputMoreCardView.top = self.view.bottom;
            self.tableView.transform=CGAffineTransformIdentity;
            self.chatInputView.moreButton.transform = CGAffineTransformMakeRotation(M_PI_4*4);
            
        } completion:^(BOOL finished) {
            [self.inputMoreCardView removeFromSuperview];
        }];
    }
}

#pragma mark - SLConversationInputMoreCardViewDelegate
- (void)conversationInputMoreCardViewDidClickBtnWithType:(SLConversationInputMoreCardViewButtonType)type
{
    switch (type) {
        case SLConversationInputMoreCardViewButtonTypeGift:{
            self.isInputMoreCardViewShow = NO;
            break;
        }
        case SLConversationInputMoreCardViewButtonTypeCamera:{
            self.isInputMoreCardViewShow = NO;
            [self handleVideoRecordingAction];
        }
            break;
        case SLConversationInputMoreCardViewButtonTypeLocation:{
            self.isInputMoreCardViewShow = NO;
        }
            break;
        case SLConversationInputMoreCardViewButtonTypeDlice:{
        }
            break;
            
        default:
            break;
    }
}

@end

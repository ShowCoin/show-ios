//
//  SLPrivateChatViewController+Emoji.m
//  ShowLive
//
//  Created by 周华 on 2018/4/11.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "SLPrivateChatViewController+Emoji.h"
#import "SLPrivateChatViewController+TableView.h"
#import "SLPrivateChatViewController+InputView.h"
#import "SLPrivateChatViewController+InputMoreCardView.h"

@implementation SLPrivateChatViewController (Emoji)
#pragma mark - Property
- (BOOL)isEmojiViewShow
{
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setIsEmojiViewShow:(BOOL)isEmojiViewShow
{
    [self setEmojiViewShow:isEmojiViewShow];
    objc_setAssociatedObject(self, @selector(isEmojiViewShow), @(isEmojiViewShow), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - Setup
- (void)setEmojiViewShow:(BOOL)show
{
    if (self.isEmojiViewShow == show) {
        return;
    }
    
    [self loadEmojiViewIfNeed];
    
    if (show) {
        self.isInputMoreCardViewShow = NO;
        [self resignChatViewFirstResponder];
        // 把语音状态更改为自然状态
        if (self.chatInputView.isAutioMsg) {
            self.chatInputView.isAutioMsg = NO;
        }
        CGFloat bottomH = _GetChatInputViewHeight();
        CGFloat distance = self.emojiView.transDistance;
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
        self.emojiView.show = YES;
        [UIView animateWithDuration:0.25 delay:0 options:0 animations:^{
            self.tableView.height = newH;
            self.tableView.transform = CGAffineTransformMakeTranslation(0, -move);
            self.chatInputView.top = self.tableView.bottom;
        } completion:nil];
    } else {
        self.emojiView.show = NO;
        [UIView animateWithDuration:0.25 delay:0 options:0 animations:^{
            self.tableView.height = kScreenHeight- _GetChatInputViewHeight() - kNaviBarHeight - KTabbarSafeBottomMargin;
            self.chatInputView.bottom = self.view.bottom - KTabbarSafeBottomMargin;
            self.tableView.transform=CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
        }];
    }
}

- (void)loadEmojiViewIfNeed
{
    if (!self.emojiView) {
        @weakify(self)
        self.emojiView = [SLEmojiView emojiViewWithDidClickEmojiBlock:^(SLEmojiView * _Nonnull emojiView, SLEmoji * _Nonnull emoji) {
            @strongify(self);
            [self.chatInputView.inputTextView insertText:emoji.emojiString];
        } didClickSendButtonBlock:^(SLEmojiView * _Nonnull emojiView, UIButton * _Nonnull sendButton) {
            @strongify(self)
            [self sendTextActionIfNeed];
        } didClickDeleteButtonBlock:^(SLEmojiView * _Nonnull emojiView, UIButton * _Nonnull deleteButton) {
            @strongify(self)
            [self.chatInputView.inputTextView deleteBackward];
        }];
    }
}

@end

//
//  SLEmojiView.h
//  ShowLive
//
//  Created by 周华 on 2018/4/11.
//  Copyright © 2018年 vning. All rights reserved.
//
/*
 ---------------------------------------------
 |                                             |
 |           -------------------------------   |
 |  T       |   -------------------------   |  |
 |  O       |  |                         |  |  |
 |          |  |  SLEmojiCollectionView  |  |  |
 |  P       |  |                         |  |  |
 |          |   -------------------------   |  |
 |          |                               |  |
 |          |   SLEmojiPageCollectionView   |  |
 |           -------------------------------   |
 | ------------------------------------------- |
 | Bottom   |      SLEmojiCategoryView         |
 ---------------------------------------------
 */


#import <UIKit/UIKit.h>
#import "SLEmoji.h"

NS_ASSUME_NONNULL_BEGIN
@class SLEmojiView;

UIKIT_EXTERN NSString * const SLEmojiViewWillShowNotification;
UIKIT_EXTERN NSString * const SLEmojiViewWillHideNotification;

@protocol SLEmojiViewDelegate <NSObject>
- (void)emojiView:(SLEmojiView *)emojiView didClickEmoji:(SLEmoji *)emoji;
- (void)emojiView:(SLEmojiView *)emojiView didClickSendButton:(UIButton *)sendButton;
- (void)emojiView:(SLEmojiView *)emojiView didClickDeleteButton:(UIButton *)deleteButton;
@end

typedef void (^EmojiViewDidClickEmojiBlock)(SLEmojiView *emojiView, SLEmoji *emoji);
typedef void (^EmojiViewDidClickSendButtonBlock)(SLEmojiView *emojiView, UIButton *sendButton);
typedef void (^EmojiViewDidClickDeleteButtonBlock)(SLEmojiView *emojiView, UIButton *deleteButton);

@interface SLEmojiView : UIWindow

@property (assign, nonatomic, readonly) CGFloat transDistance;
@property (assign, nonatomic) NSTimeInterval animationDuration;
@property (assign, nonatomic, getter = isShow) BOOL show;
@property (assign, nonatomic) BOOL enableSendButton;

+ (SLEmojiView *)emojiViewWithDelegate:(id<SLEmojiViewDelegate>)delegate;
+ (SLEmojiView *)emojiViewWithDidClickEmojiBlock:(EmojiViewDidClickEmojiBlock)didClickEmojiBlock
                         didClickSendButtonBlock:(EmojiViewDidClickSendButtonBlock)didClickSendButtonBlock
                       didClickDeleteButtonBlock:(EmojiViewDidClickDeleteButtonBlock)didClickDeleteButtonBlock;
@end
NS_ASSUME_NONNULL_END


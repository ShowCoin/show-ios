//
//  SLChatMessageCellProtocol.h
//  ShowLive
//
//  Created by Z on 2018/4/7.
//  Copyright © 2018年 Show. All rights reserved.
// 定义cell的处理事件、回调,从basecell里剖离出来

#import "SLChatMessageBaseCellViewModel.h"
#import "SLChatGiftMessageCellViewModel.h"

@protocol SLChatMessageCellProtocol;

#pragma mark - Delegates
/**
 回调，某个子cell
 */
@protocol SLChatMessageCellDelegate <NSObject>

/**
 点击头像

 @param cell cell
 @param viewModel viewModel
 */
- (void)chatCell:(id<SLChatMessageCellProtocol>)cell didClickHeadProtraitWithViewModel:(id <SLChatMessageBaseCellViewModel>)viewModel;

/**
 点击消息内容区域

 @param cell cell
 @param viewModel viewModel
 */
- (void)chatCell:(id<SLChatMessageCellProtocol>)cell didClickContentViewWithViewModel:(id <SLChatMessageBaseCellViewModel>)viewModel;

/**
 点击重试按钮

 @param cell cell
 @param viewModel viewModel
 */
- (void)chatCell:(id<SLChatMessageCellProtocol>)cell didClickRetryButtonWithViewModel:(id <SLChatMessageBaseCellViewModel>)viewModel;


/**
 点击底部提示条

 @param cell cell
 @param viewModel viewModel
 */
- (void)chatCell:(id<SLChatMessageCellProtocol>)cell didClickBottomTipsLabelWithViewModel:(id <SLChatMessageBaseCellViewModel>)viewModel;


@end

#pragma mark - Protocols
/**
 基础通用的接口
 */
@protocol SLChatMessageCellProtocol <NSObject>

@property (weak, nonatomic) id<SLChatMessageCellDelegate> delegate;

// cell的高度
+ (CGFloat)getCellHeightWithViewModel:(id<SLChatMessageBaseCellViewModel>)viewModel;

/**
 viewModel
 */
@property (strong, nonatomic) id<SLChatMessageBaseCellViewModel> viewModel;

@end

@protocol SLChatVoiceMessageCellProtocol <SLChatMessageCellProtocol>

- (void)startAnimation;
- (void)stopAnimation;

@end

@protocol SLChatRichMessageCellProtocol <SLChatMessageCellProtocol>

- (UIImageView *)artWorkImageView;

@end



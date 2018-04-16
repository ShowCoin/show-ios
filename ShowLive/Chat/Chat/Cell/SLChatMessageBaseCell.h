//
//  SLChatMessageBaseCell.h
//  ShowLive
//
//  Created by 周华 on 2018/4/11.
//  Copyright © 2018年 vning. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SLChatMessageCellProtocol.h"
#import "SLChatMessageCellConstants.h"
#import "YYText.h"
@interface SLChatMessageBaseCellSizeCache : NSObject
@property (assign, nonatomic) CGFloat cellHeight;
+ (SLChatMessageBaseCellSizeCache *)cacheWithViewModel:(id<SLChatMessageBaseCellViewModel>)viewModel;
- (void)updateAllCachedSizeIfNeedWithViewModel:(id<SLChatMessageBaseCellViewModel>)viewModel;
@end


/* cell高度组成：
 根据从上到下主要有4部分构成，
 1.顶部时间条；可能会隐藏,
 2.头像和messageContainerView:(二者顶部持平,一般以messageContainerView高度为主);
 3.底部提示条:拉黑、免打扰提示等，部分cell有
 4.已读/未读状态条:只有发的送消息才有
 除了1、2、4，所有影响messageContainerView高度的控件都应该囊括在里面。
 */

/**
 头像的高度
 
 @return height
 */
static inline CGFloat GetSLChatCellHeadProtraitHeight(void) {
    return 45;
}

/**
 头像顶部到cell顶部的距离,根据时间条是否显示
 
 @param hideTime hideTime
 @return height
 */
static inline CGFloat GetChatCellHeadProtraitToTopMarginWithHideTime(BOOL hideTime) {
    return hideTime ? 15 : 49;
}

/**
 发送消息读取状态的高度和距离
 
 @param showSentMessageReadState 是否显示
 @return height
 */
static inline CGFloat GetChatCellReadStateLabelHeight(BOOL showSentMessageReadState) {
    return showSentMessageReadState ? 25 : 0;
}

/**
 底部提示条的高度和距离
 
 @param showBottomTips 是否显示
 @return height
 */
static inline CGFloat GetChatCellBottomTipsLabelHeight(BOOL showBottomTips) {
    return showBottomTips ? 38 : 0;
}

@interface SLChatMessageBaseCell : UITableViewCell
<SLChatMessageCellProtocol>

@property (strong, nonatomic) SLHeadPortrait *headProtrait;
@property (strong, nonatomic) UILabel *timeLabel;

/**
 气泡(即消息内容的背景图)
 */
@property (strong, nonatomic) UIImageView *bubbleImageView;

/**
 消息中间主体内容,要与头像顶部top平齐，提供手势。
 */
@property (strong, nonatomic) UIView *middleContainerView;

/**
 底部一个label，默认显示免打扰、拉黑等信息提示条，部分cell显示
 */
@property (strong, nonatomic) YYLabel *bottomTipsLabel;

/**
 消息发送方的已读、未读状态,部分底部显示，
 */
@property (strong, nonatomic) UILabel *messageReadStateLabel;

/**
 初始化之后的起点，初始化UI，需要子类重载
 */
- (void)setupUI;

/**
 更新头像信息数据，根据self.viewModel
 */
- (void)updateHeadProtraitData;

/**
 更新时间条显示数据、隐藏
 */
- (void)updateTimeLabelData;

/**
 更新发送消息读取状态，根据self.viewModel，自动根据需要播放动画
 */
- (void)updateSentMessageReadReceiptState;


/**
 更新气泡,并设置为某个view的遮罩，图片已经采用了assets的slicing方式实现了延展
 
 @param view 要设置为某个maskView
 @param size size
 */
- (void)updateBubbleImageAsMaskViewOnView:(UIView *)view size:(CGSize)size;

/**
 更新气泡
 
 @param size size
 */
- (void)updateBubbleImageWithSize:(CGSize)size;
@property (strong, nonatomic) SLChatMessageBaseCellSizeCache *sizeCache;

@end

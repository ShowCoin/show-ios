//
//  SLChatMessageBaseCell+LayoutSize.h
//  ShowLive
//
//  Created by 周华 on 2018/4/14.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "SLChatMessageBaseCell.h"

@interface SLChatMessageBaseCell (LayoutSize)
/// 加载时间条布局
- (void)setupTimeLabelLayoutFrames;

/// 加载头像布局
- (void)setupProtraitLayoutFrames;

/// 加载底部提示条布局
- (void)setupBottomTipsLabelLayoutFrames;



/// 更新时间条
- (void)updateTimeLabelLayoutFrames;

///  更新头像布局，根据消息方向
- (void)updateProtraitLayoutFrames;

/// 加载消息读取状态布局
- (void)updateMessageReadStateLabelLayoutFrames;

/// 更新消息主体内容布局，根据消息方向，需要传入ContainerView的size
- (void)updateMiddleContainerViewLayoutFramesWithSize:(CGSize)size;



/// 获取除了消息主体内容的高度，包括时间条、已读未读、免打扰，加上ContainerView的height就是整个cell的高度了
+ (CGFloat)getCellHeightExceptMiddleContainerView:(id<SLChatMessageBaseCellViewModel>)viewModel;

@end

//
//  SLChatMessageBaseCell+LayoutSize.m
//  ShowLive
//
//  Created by Mac on 2018/4/14.
//  Copyright © 2018年 VNing. All rights reserved.
//

#import "SLChatMessageBaseCell+LayoutSize.h"
#import "SLStringSizeCalculation.h"
#import <YYText/YYText.h>
static CGFloat kHeadProtraitHeight = 40;

@implementation SLChatMessageBaseCell (LayoutSize)
#pragma mark - Setup
- (void)setupTimeLabelLayoutFrames;
{
    self.timeLabel.frame = CGRectMake(0, 20, kScreenWidth, 20);
}

- (void)setupProtraitLayoutFrames
{
    self.headProtrait.frame = CGRectMake(10, 49, kHeadProtraitHeight, kHeadProtraitHeight);
}


#pragma mark - Update
- (void)updateTimeLabelLayoutFrames
{
    if (!self.viewModel.hideTime) {
        [self.timeLabel sizeToFit];
        CGFloat width = self.timeLabel.frame.size.width + 2 *6;
        self.timeLabel.frame = CGRectMake((kMainScreenWidth - width)/2, 20, width, 20);
    }
}
- (void)updateProtraitLayoutFrames
{
    CGFloat topSpacingToMargin = GetChatCellHeadProtraitToTopMarginWithHideTime(self.viewModel.hideTime);
    if (self.viewModel.messageDirection == SLChatMessageDirectionSend) {
        self.headProtrait.frame = CGRectMake(kScreenWidth - kHeadProtraitHeight - 10, topSpacingToMargin, kHeadProtraitHeight, kHeadProtraitHeight);
    } else {
        self.headProtrait.frame = CGRectMake(10, topSpacingToMargin, kHeadProtraitHeight, kHeadProtraitHeight);
    }
}

- (void)updateMiddleContainerViewLayoutFramesWithSize:(CGSize)size
{
    CGFloat topSpacingToMargin = GetChatCellHeadProtraitToTopMarginWithHideTime(self.viewModel.hideTime);
    CGFloat contentToProtrait = 5;
    
    if (self.viewModel.messageDirection == SLChatMessageDirectionSend) {
        self.middleContainerView.frame = CGRectMake(self.headProtrait.left - contentToProtrait - size.width, topSpacingToMargin, size.width, size.height);
    } else {
        self.middleContainerView.frame = CGRectMake(self.headProtrait.right + contentToProtrait, topSpacingToMargin, size.width, size.height);
    }
}

- (void)updateMessageReadStateLabelLayoutFrames
{
    self.messageReadStateLabel.frame = CGRectMake(self.middleContainerView.right - 10 - 100, self.middleContainerView.bottom + 5, 100, 20);
}

#pragma mark - Get
+ (CGFloat)getCellHeightExceptMiddleContainerView:(id<SLChatMessageBaseCellViewModel>)viewModel
{
    if (![viewModel conformsToProtocol:@protocol(SLChatMessageBaseCellViewModel) ]) {
        NSAssert(0, @"check out viewModel`s class");
        return 0;
    }
    
    CGFloat headTopToMargin = GetChatCellHeadProtraitToTopMarginWithHideTime(viewModel.hideTime);
    CGFloat readStateLabelHeight = GetChatCellReadStateLabelHeight(viewModel.showSentMessageReadState);
    CGFloat showNotDisturbTipsHeight = GetChatCellBottomTipsLabelHeight(viewModel.showNotDisturbTips);
    // contentView 比 cell高度 小1像素
    return headTopToMargin + readStateLabelHeight + showNotDisturbTipsHeight + 1;
}

@end

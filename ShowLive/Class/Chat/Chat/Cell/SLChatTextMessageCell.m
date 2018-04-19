//
//  SLChatTextMessageCell.m
//  ShowLive
//
//  Created by 周华 on 2018/4/11.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "SLChatTextMessageCell.h"
#import "SLChatTextMessageCellViewModel.h"
#import "SLStringSizeCalculation.h"
#import "SLChatMessageBaseCell+LayoutSize.h"
static CGFloat labelInsertMargin = 8;// label到四周距离
static CGFloat labelWidthReducedFromSuperView = 6;// label 和 contentview的 宽度差距
static CGFloat labelWidthBeginAfterArrow = 8;// label 起始点，跳过arrow的宽度

#if CHAT_USE_YYLABEL
#import "YYText.h"
#endif
@interface SLChatTextMessageCell()
#if CHAT_USE_YYLABEL
@property (strong, nonatomic) YYLabel *contentLabel;
#else
@property (strong, nonatomic) UILabel *contentLabel;
#endif
@end

@implementation SLChatTextMessageCell

@synthesize viewModel = _viewModel;

- (void)setupUI
{
    [self.contentView addSubview:self.timeLabel];
    [self.contentView addSubview:self.headProtrait];
    [self.contentView addSubview:self.middleContainerView];
    [self.contentView addSubview:self.messageReadStateLabel];
    [self.contentView addSubview:self.bottomTipsLabel];
    
    [self.middleContainerView addSubview:self.bubbleImageView];
    [self.middleContainerView addSubview:self.contentLabel];
    
}

#pragma mark - Layout

- (void)updateFrames
{
    [self updateTimeLabelLayoutFrames];
    [self updateProtraitLayoutFrames];
    
    SLChatTextMessageCellSizeCache *sizeCache = (SLChatTextMessageCellSizeCache *)self.viewModel.sizeCache;
    CGSize size = sizeCache.contentMiddleSize;
    [self updateMiddleContainerViewLayoutFramesWithSize:size];
    
    CGSize contentLabelSize = CGSizeMake(size.width - labelWidthReducedFromSuperView - labelInsertMargin*2, size.height - labelInsertMargin*2);
    
    if (self.viewModel.messageDirection == SLChatMessageDirectionSend) {
        self.contentLabel.frame = CGRectMake(size.width - (labelWidthBeginAfterArrow + labelWidthReducedFromSuperView) - contentLabelSize.width, labelInsertMargin, contentLabelSize.width, contentLabelSize.height);
    } else {
        self.contentLabel.frame = CGRectMake(labelWidthBeginAfterArrow + labelWidthReducedFromSuperView, labelInsertMargin, contentLabelSize.width, contentLabelSize.height);
    }
    
    
    
    [self updateBubbleImageWithSize:size];
    [self updateMessageReadStateLabelLayoutFrames];
}

+ (CGFloat)getCellHeightWithViewModel:(id<SLChatTextMessageCellViewModel>)viewModel
{
    CGSize  contentSize = [self sizeOfContainerView:viewModel];
    CGFloat contentHeight = contentSize.height;
    // 可能字少，高度小于头像的高度
    contentHeight = MAX(contentHeight, GetSLChatCellHeadProtraitHeight());
    
    // set cache
    SLChatTextMessageCellSizeCache *sizeCache = (SLChatTextMessageCellSizeCache *) viewModel.sizeCache;
    sizeCache.contentMiddleSize = CGSizeMake(contentSize.width, contentHeight);
    
    CGFloat exceptMessageContentViewHeight = [self getCellHeightExceptMiddleContainerView:viewModel];
    return exceptMessageContentViewHeight + contentHeight;;
}

+ (CGSize)sizeOfContainerView:(id<SLChatTextMessageCellViewModel>)viewModel
{
    
#if CHAT_USE_YYLABEL
    CGSize size = [SLStringSizeCalculation sizeOfYYTextWithAttributedString:viewModel.contentAttributedString baseOnSize:CGSizeMake(kMainScreenWidth-120, MAXFLOAT)];
#else
    CGSize size = [SLStringSizeCalculation sizeOfLabelWithAttributedString:viewModel.contentAttributedString baseOnSize:CGSizeMake(kMainScreenWidth-120, MAXFLOAT)];
    //    CGSize size = [SLStringSizeCalculation sizeOfLabelWithString:viewModel.contentString baseOnSize:CGSizeMake(SLainScreenWidth-120, MAXFLOAT) font:[UIFont systemFontOfSize:15]];
#endif
    
    size.width = size.width + labelWidthReducedFromSuperView + labelInsertMargin*2;
    size.height = size.height + labelInsertMargin*2;
    return size;
}

#pragma mark - Getter

#if CHAT_USE_YYLABEL
- (YYLabel *)contentLabel
{
    if (!_contentLabel) {
        YYLabel *label = [[YYLabel alloc] init];
        label.backgroundColor = [UIColor clearColor];
        label.numberOfLines = 0;
        label.lineBreaSLode = NSLineBreakByWordWrapping;
        label.textVerticalAlignment = YYTextVerticalAlignmentCenter;
        label.userInteractionEnabled = YES;
        label.textColor = [UIColor whiteColor];
        label.font = [UIFont systemFontOfSize:15];
        _contentLabel = label;
    }
    return _contentLabel;
}
#else
- (UILabel *)contentLabel
{
    if (!_contentLabel) {
        UILabel *label = [UILabel labelWithFrame:CGRectZero text:@"" textColor:[UIColor whiteColor] font:[UIFont systemFontOfSize:15]];
        label.numberOfLines = 0;
        _contentLabel = label;
    }
    return _contentLabel;
}
#endif



#pragma mark - Action
- (void)retryAction:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(chatCell:didClickRetryButtonWithViewModel:)]) {
        [self.delegate chatCell:self didClickRetryButtonWithViewModel:self.viewModel];
    }
}

#pragma mark - Setup Data
- (void)setViewModel:(id<SLChatTextMessageCellViewModel>)viewModel
{
    if (![viewModel conformsToProtocol:@protocol(SLChatTextMessageCellViewModel)]) {
        return;
    }
    _viewModel = viewModel;
    
    [self updateTimeLabelData];
    [self updateHeadProtraitData];
    [self updateSentMessageReadReceiptState];
    [self updateContentLabel];
    
    self.bottomTipsLabel.hidden = !viewModel.showNotDisturbTips;
    
    [self updateFrames];
}

- (void)updateContentLabel
{
    id<SLChatTextMessageCellViewModel> viewModel = (id<SLChatTextMessageCellViewModel>)self.viewModel;
#if CHAT_USE_YYLABEL
    self.contentLabel.attributedText = viewModel.contentAttributedString;
    YYTextLayout *layout = [SLStringSizeCalculation getYYTextLayoutWithAttributedString:viewModel.contentAttributedString baseOnSize:CGSizeMake(kMainScreenWidth-120, MAXFLOAT)];
    self.contentLabel.textLayout = layout;
    self.contentLabel.size = layout.textBoundingSize;
#else
    self.contentLabel.attributedText = viewModel.contentAttributedString;
#endif
}
@end
#pragma mark - SLChatTextMessageCellSizeCache
@implementation SLChatTextMessageCellSizeCache
@end



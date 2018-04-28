//
//  SLChatVoiceMessageCell.m
//  ShowLive
//
//  Created by Mac on 2018/4/11.
//  Copyright © 2018年 VNing. All rights reserved.
//

#import "SLChatVoiceMessageCell.h"
#import "SLChatVoiceMessageCellViewModel.h"
#import "SLChatMessageBaseCell+LayoutSize.h"

static inline CGSize _GetContainerViewSizeWithWidthIncrease(NSInteger widthPadding) {
    return CGSizeMake(60+widthPadding, 40);
}

@interface SLChatVoiceMessageCell()
@property (strong, nonatomic) UIView *bgView;
@property (strong, nonatomic) UIImageView *voiceImageView;
@property (nonatomic, strong) UILabel *durationLabel;
@property (nonatomic, strong) UIView *unReadPoint;
@end
@implementation SLChatVoiceMessageCell
@synthesize viewModel = _viewModel;

- (void)setupUI
{
    [self.contentView addSubview:self.timeLabel];
    [self.contentView addSubview:self.headProtrait];
    [self.contentView addSubview:self.middleContainerView];
    
    [self.contentView addSubview:self.durationLabel];
    [self.contentView addSubview:self.unReadPoint];
    [self.contentView addSubview:self.bottomTipsLabel];
    [self.contentView addSubview:self.messageReadStateLabel];
    
    [self.middleContainerView addSubview:self.bgView];
    [self.middleContainerView addSubview:self.voiceImageView];
    
    
    self.durationLabel.size = CGSizeMake(60, 20);
    self.voiceImageView.size = CGSizeMake(18, 18);
    [self setupTimeLabelLayoutFrames];
}

#pragma mark - Layout

- (void)updateFrames
{
    [self updateTimeLabelLayoutFrames];
    [self updateProtraitLayoutFrames];
    id <SLChatVoiceMessageCellViewModel> viewModel = (id<SLChatVoiceMessageCellViewModel>)self.viewModel;
    SLChatVoiceMessageCellSizeCache *sizeCache = (SLChatVoiceMessageCellSizeCache *)viewModel.sizeCache;
    
    [self updateMiddleContainerViewLayoutFramesWithSize:sizeCache.contentMiddleSize];
    [self updateBubbleImageAsMaskViewOnView:self.middleContainerView size:sizeCache.contentMiddleSize];
    
    self.bgView.frame = self.middleContainerView.bounds;
    
    if (self.viewModel.messageDirection == SLChatMessageDirectionSend) {
        self.voiceImageView.centerY = self.middleContainerView.height/2;
        self.voiceImageView.right = self.middleContainerView.width - 14;
        
        _durationLabel.textAlignment = NSTextAlignmentRight;
        
        self.durationLabel.centerY = self.middleContainerView.centerY;
        self.durationLabel.right = self.middleContainerView.left - 5;
        
    } else {
        self.voiceImageView.centerY = self.middleContainerView.height/2;
        self.voiceImageView.left = 14;
        
        _durationLabel.textAlignment = NSTextAlignmentLeft;
        
        self.durationLabel.centerY = self.middleContainerView.centerY;
        self.durationLabel.left = self.middleContainerView.right + 5;
        
        // 接收的消息才有
        if (!self.unReadPoint.hidden) {
            self.unReadPoint.size = CGSizeMake(8, 8);
            self.unReadPoint.top = self.middleContainerView.top;
            self.unReadPoint.left = self.durationLabel.left;
        }
    }
    
    [self updateMessageReadStateLabelLayoutFrames];
}


+ (CGFloat)getCellHeightWithViewModel:(id<SLChatMessageBaseCellViewModel>)viewModel
{
    id<SLChatVoiceMessageCellViewModel> vm = (id<SLChatVoiceMessageCellViewModel>)viewModel;
    SLChatVoiceMessageCellSizeCache *sizeCache = (SLChatVoiceMessageCellSizeCache *)vm.sizeCache;
    
    NSInteger contentWidthPadding = vm.duration*2;
    CGSize containerSize = _GetContainerViewSizeWithWidthIncrease(contentWidthPadding);
    sizeCache.contentMiddleSize = containerSize;
    
    CGFloat exceptMessageContentViewHeight = [self getCellHeightExceptMiddleContainerView:viewModel];
    return exceptMessageContentViewHeight + containerSize.height;
}

#pragma mark - Getter
- (UIView *)bgView
{
    if (!_bgView) {
        _bgView = [[UIView alloc] initWithFrame:CGRectZero];
        _bgView.layer.masksToBounds = YES;
        _bgView.layer.cornerRadius = 5;
    }
    return _bgView;
}

- (UIImageView *)voiceImageView
{
    if (!_voiceImageView) {
        _voiceImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _voiceImageView.image = [UIImage imageNamed:@"yuyin_right_3"];
    }
    return _voiceImageView;
}

- (UILabel *)durationLabel
{
    if (!_durationLabel) {
        _durationLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _durationLabel.font = [UIFont systemFontOfSize:14];
        _durationLabel.textAlignment = NSTextAlignmentRight;
        _durationLabel.textColor = RGBAllColor(0x979797);
    }
    return _durationLabel;
}

- (UIView *)unReadPoint
{
    if (!_unReadPoint) {
        _unReadPoint = [[UIView alloc]initWithFrame:CGRectZero];
        _unReadPoint.layer.cornerRadius = 4;
        _unReadPoint.backgroundColor = Color(@"888888");
        
    }
    return _unReadPoint;
}

#pragma mark - Action
- (void)retryAction:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(chatCell:didClickRetryButtonWithViewModel:)]) {
        [self.delegate chatCell:self didClickRetryButtonWithViewModel:self.viewModel];
    }
}

#pragma mark - setUpData
- (void)setViewModel:(id<SLChatVoiceMessageCellViewModel>)viewModel
{
    if (![viewModel conformsToProtocol:@protocol(SLChatVoiceMessageCellViewModel)]) {
        return;
    }
    _viewModel = viewModel;
    
    [self updateTimeLabelData];
    [self updateHeadProtraitData];
    [self updateSentMessageReadReceiptState];
    
    if (viewModel.messageDirection == SLChatMessageDirectionSend) {
        self.bgView.backgroundColor = RGBCOLOR(238, 238, 238);
    } else {
        self.bgView.backgroundColor = [UIColor whiteColor];
    }
    BOOL isSend = ( viewModel.messageDirection == SLChatMessageDirectionSend );
    self.durationLabel.text = viewModel.durationDescription;
    self.unReadPoint.hidden = isSend || viewModel.listened;
    
    self.voiceImageView.image =isSend? [UIImage imageNamed:@"yuyin_left_3"] : [UIImage imageNamed:@"yuyin_right_3"];
    
    [self updateFrames];
}

#pragma mark - Animation
- (NSArray *)animationImgArray
{
    if (self.viewModel.messageDirection == SLChatMessageDirectionSend) {
        return @[[UIImage imageNamed:@"yuyin_left_1"],
                 [UIImage imageNamed:@"yuyin_left_2"],
                 [UIImage imageNamed:@"yuyin_left_3"]];
    }
    return @[[UIImage imageNamed:@"yuyin_right_1"],
             [UIImage imageNamed:@"yuyin_right_2"],
             [UIImage imageNamed:@"yuyin_right_3"]];
}

- (NSInteger) animationRepeatCount
{
    NSString *strDuration = self.durationLabel.text;
    strDuration = [strDuration substringToIndex:strDuration.length - 1];
    return [strDuration integerValue];
}

#pragma mark - SLChatVoiceMessageCellProtocol
- (void)startAnimation
{
    self.voiceImageView.animationImages = self.animationImgArray;
    self.voiceImageView.animationDuration = 1;
    NSInteger duration = [self animationRepeatCount];
    self.voiceImageView.animationRepeatCount = duration;
    [self.voiceImageView startAnimating];
    
    _unReadPoint.hidden = YES;
}

- (void)stopAnimation
{
    if (self.voiceImageView.isAnimating) {
        [self.voiceImageView stopAnimating];
    }
}

@end
@implementation SLChatVoiceMessageCellSizeCache
@end

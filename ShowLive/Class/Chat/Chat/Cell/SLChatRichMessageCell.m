//
//  SLChatRichMessageCell.m
//  ShowLive
//
//  Created by 周华 on 2018/4/14.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "SLChatRichMessageCell.h"
#import "SLChatRichMessageCellViewModel.h"
#import "SLChatMessageBaseCell+LayoutSize.h"
static inline CGSize GetPictureSize(void) {
    return CGSizeMake(161 * Proportion375, 259 * Proportion375);
}

@interface SLChatRichMessageCell()
@property (strong, nonatomic) YYAnimatedImageView *artworkCover;
@property (strong, nonatomic) UIImageView *artworkVideoIcon;
@property (strong, nonatomic) UILabel *artworkTitle;
@property (strong, nonatomic) UIActivityIndicatorView *loadingView;
@end

@implementation SLChatRichMessageCell
@synthesize viewModel = _viewModel;

- (void)setupUI
{
    [self.contentView addSubview:self.timeLabel];
    [self.contentView addSubview:self.headProtrait];
    [self.contentView addSubview:self.middleContainerView];
    [self.contentView addSubview:self.messageReadStateLabel];
//    [self.contentView addSubview:self.bottomTipsLabel];
//    [self.contentView addSubview:self.loadingView];
    
    [self.middleContainerView addSubview:self.artworkCover];
//    [self.middleContainerView addSubview:self.artworkVideoIcon];
//    [self.middleContainerView addSubview:self.artworkTitle];
    
    self.artworkVideoIcon.hidden = YES;
    self.loadingView.hidden = YES;
    [self setupTimeLabelLayoutFrames];
    
}

#pragma mark - Layout

- (void)updateFrames
{
    [self updateTimeLabelLayoutFrames];
    [self updateProtraitLayoutFrames];
    [self updateMiddleContainerViewLayoutFramesWithSize:GetPictureSize()];
    [self updateBubbleImageAsMaskViewOnView:self.middleContainerView size:GetPictureSize()];
    
    self.artworkCover.frame = self.middleContainerView.bounds;
    
    
    
    if (self.viewModel.messageDirection == SLChatMessageDirectionSend) {
        self.loadingView.size = CGSizeMake(24, 24);
        self.loadingView.centerY = self.middleContainerView.centerY;
        self.loadingView.right = self.middleContainerView.left - 10;
        [self updateMessageReadStateLabelLayoutFrames];
    }
}

+ (CGFloat)getCellHeightWithViewModel:(id<SLChatRichMessageCellViewModel>)viewModel
{
    CGFloat messageContentHeight = GetPictureSize().height;
    CGFloat exceptMessageContentViewHeight = [self getCellHeightExceptMiddleContainerView:viewModel];
    return exceptMessageContentViewHeight + messageContentHeight;
}

#pragma mark - Getter
- (YYAnimatedImageView *)artworkCover
{
    if (!_artworkCover) {
        _artworkCover = [[YYAnimatedImageView alloc] initWithFrame:CGRectZero];
        _artworkCover.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _artworkCover;
}

- (UIImageView *)artworkVideoIcon
{
    if (!_artworkVideoIcon) {
        _artworkVideoIcon = [[UIImageView alloc] initWithFrame:CGRectZero];
        _artworkVideoIcon.image = [UIImage imageNamed:@"bofang"];
    }
    return _artworkVideoIcon;
}

- (UILabel *)artworkTitle
{
    if (!_artworkTitle) {
        _artworkTitle = [UILabel labelWithFrame:CGRectZero text:@"" textColor:[UIColor whiteColor] font:[UIFont systemFontOfSize:16] backgroundColor:[UIColor clearColor] alignment:NSTextAlignmentCenter];
        _artworkTitle.numberOfLines = 0;
    }
    return _artworkTitle;
}
- (UIActivityIndicatorView *)loadingView
{
    if (!_loadingView) {
        _loadingView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    }
    return _loadingView;
}
#pragma mark - Action
- (void)retryAction:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(chatCell:didClickRetryButtonWithViewModel:)]) {
        id<SLChatRichMessageCellViewModel> vm = (id<SLChatRichMessageCellViewModel>) self.viewModel;
        vm.isUploading = YES;
        [self.loadingView startAnimating];
        [self.delegate chatCell:self didClickRetryButtonWithViewModel:self.viewModel];
    }
}

#pragma mark - Setup Data
- (void)setViewModel:(id<SLChatRichMessageCellViewModel>)viewModel
{
    if (![viewModel conformsToProtocol:@protocol(SLChatRichMessageCellViewModel)]) {
        return;
    }
    _viewModel = viewModel;
    
    [self updateTimeLabelData];
    [self updateHeadProtraitData];
    [self updateSentMessageReadReceiptState];
    
    
//    if (viewModel.isUploading && !viewModel.sentFailed) {
//        [self.loadingView startAnimating];
//    } else {
//        [self.loadingView stopAnimating];
//    }
    
    // artworkImageView
    NSString *placehoder = @"userhome_avatar_image";
    if (viewModel.cover) {
        // 以后优化一下
        NSURL *url = [NSURL URLWithString:viewModel.cover];
        [self.artworkCover yy_setImageWithURL:url placeholder:[UIImage imageNamed:placehoder]];
    } else {
        UIImage *localCover = [[UIImage alloc] initWithContentsOfFile:viewModel.localCover];
        self.artworkCover.image =localCover;
    }
    
    [self updateFrames];
}

#pragma mark - SLChatRichMessageCellProtocol
- (UIImageView *)artWorkImageView
{
    return self.artworkCover;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

//
//  SLChatMessageBaseCell.m
//  ShowLive
//
//  Created by Mac on 2018/4/11.
//  Copyright © 2018年 VNing. All rights reserved.
//

#import "SLChatMessageBaseCell.h"
#import "SLStringSizeCalculation.h"
#import "SLChatMessageCellConfig.h"
#import "SLStringSizeCalculation.h"
#import <YYText/YYText.h>

static CGFloat kHeadProtraitHeight = 40;

@implementation SLChatMessageBaseCellSizeCache
+ (SLChatMessageBaseCellSizeCache *)cacheWithViewModel:(id<SLChatMessageBaseCellViewModel>)viewModel
{
    SLChatMessageBaseCellSizeCache *cache = [[self alloc] init];
    return cache;
}

- (void)updateAllCachedSizeIfNeedWithViewModel:(id<SLChatMessageBaseCellViewModel>)viewModel
{
    NSString *cellName = [SLChatMessageCellConfig cellNameWithCellType:viewModel.cellType];
    self.cellHeight = [NSClassFromString(cellName) getCellHeightWithViewModel:viewModel];
}
@end
@interface SLChatMessageBaseCell() <HeadPortraitDelegate>
@end

@implementation SLChatMessageBaseCell
@synthesize delegate = _delegate;
@synthesize viewModel = _viewModel;
#pragma mark - Life Cycle
- (void)dealloc
{
    [self.layer removeAllAnimations];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self setupUI];
    }
    return self;
}

#pragma mark - Setup
- (void)setupUI
{
    NSAssert(0, @"subclass should override it");
}

#pragma mark - Common Updates
- (void)updateHeadProtraitData
{
    [self.headProtrait setRoundStyle:YES imageUrl:self.viewModel.avatarUrlString imageHeight:45 vip:self.viewModel.isVip attestation:self.viewModel.isIdentified];
}

- (void)updateTimeLabelData
{
    self.timeLabel.text = self.viewModel.time;
    self.timeLabel.hidden = self.viewModel.hideTime;
}

- (void)updateSentMessageReadReceiptState
{
    // 只在发送消息中有读取状态显示
    if (self.viewModel.messageDirection == SLChatMessageDirectionReceived) {
        self.messageReadStateLabel.text = nil;
        self.messageReadStateLabel.alpha = 0;
        return;
    }
    self.messageReadStateLabel.alpha = 1;
    self.messageReadStateLabel.layer.opacity = 1.f;
    if (self.viewModel.isSentMessageRead) {
        if (self.viewModel.showSentMessageReadAnimation && [self.messageReadStateLabel.text isEqualToString:@"未读"]) {
            [self addSentMessageStateAnimation];
            self.viewModel.showSentMessageReadAnimation = NO;
        } else {
            [self setMessageStateLabelTextWithSentMessageIsRead:YES];
        }
    } else {
        [self setMessageStateLabelTextWithSentMessageIsRead:NO];
        self.viewModel.showSentMessageReadAnimation = YES;
    }
}

- (void)setMessageStateLabelTextWithSentMessageIsRead:(BOOL)read
{
    if (read) {
        self.messageReadStateLabel.textColor = RGBCOLOR(151, 151, 151);
        self.messageReadStateLabel.text = @"已读";
    } else {
        self.messageReadStateLabel.textColor = RGBCOLOR(71, 186, 254);
        self.messageReadStateLabel.text = @"未读";
    }
}

- (void)updateBubbleImageAsMaskViewOnView:(UIView *)view size:(CGSize)size
{
    [self updateBubbleImageWithSize:size];
    view.maskView = self.bubbleImageView;
}

- (void)updateBubbleImageWithSize:(CGSize)size
{
    self.bubbleImageView.size = size;
    if (self.viewModel.messageDirection == SLChatMessageDirectionSend) {
        self.bubbleImageView.image = [UIImage imageNamed:@"qipao_left"];
    } else {
        self.bubbleImageView.image = [UIImage imageNamed:@"qipao_right"];
    }
}

#pragma mark - Getter UI
- (UILabel *)timeLabel
{
    if (!_timeLabel) {
        _timeLabel = [UILabel labelWithFrame:CGRectZero text:@"" textColor:[UIColor whiteColor] font:[UIFont systemFontOfSize:12] backgroundColor:RGBCOLOR(216, 216, 216) alignment:NSTextAlignmentCenter];
        _timeLabel.layer.cornerRadius = 4;
        _timeLabel.clipsToBounds = YES;
        
    }
    return _timeLabel;
}

- (SLHeadPortrait *)headProtrait
{
    if (!_headProtrait) {
        _headProtrait = [[SLHeadPortrait alloc] initWithFrame:CGRectMake(kMainScreenWidth-55, 49, 40, 40)];
        _headProtrait.delegate = self;
    }
    return _headProtrait;
}

- (UIImageView *)bubbleImageView
{
    if (!_bubbleImageView) {
        _bubbleImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    }
    return _bubbleImageView;
}

- (UIView *)middleContainerView
{
    if (!_middleContainerView) {
        _middleContainerView = [[UIView alloc] initWithFrame:CGRectZero];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapMessageContainerView:)];
        tap.cancelsTouchesInView = NO;
        [_middleContainerView addGestureRecognizer:tap];
    }
    return _middleContainerView;
}

#if CHAT_USE_YYLABEL
- (YYLabel *)bottomTipsLabel
{
    if (!_bottomTipsLabel) {
        YYLabel *label = [[YYLabel alloc] init];
        label.numberOfLines = 1;
        label.lineBreaSLode = NSLineBreakByWordWrapping;
        label.textAlignment = NSTextAlignmentCenter;
        label.userInteractionEnabled = YES;
        label.backgroundColor = RGBCOLOR(216, 216, 216);
        label.font = [UIFont systemFontOfSize:12];
        label.layer.masksToBounds = YES;
        label.layer.cornerRadius = 5;
        _bottomTipsLabel = label;
        [self setDefaultShowNotDistrubBottomTips];
    }
    return _bottomTipsLabel;
}
#else
//- (SLActionLabel *)bottomTipsLabel
//{
//    if (!_bottomTipsLabel) {
//        SLActionLabel *label = [[SLActionLabel alloc] initWithFrame:CGRectZero];
//        label.textColor = [UIColor whiteColor];
//        label.font = [UIFont systemFontOfSize:12];
//        label.backgroundColor = RGBCOLOR(216, 216, 216);
//        label.textAlignment = NSTextAlignmentCenter;
//        label.layer.masksToBounds = YES;
//        label.layer.cornerRadius = 5;
//        label.userInteractionEnabled = YES;
//        _bottomTipsLabel = label;
//        [self setDefaultShowNotDistrubBottomTips];
//    }
//    return _bottomTipsLabel;
//}
#endif

- (UILabel *)messageReadStateLabel
{
    if (!_messageReadStateLabel) {
        UILabel *label = [UILabel labelWithFrame:CGRectZero text:@"" textColor:[UIColor clearColor] font:[UIFont systemFontOfSize:12] backgroundColor:[UIColor clearColor] alignment:NSTextAlignmentRight];
        _messageReadStateLabel = label;
    }
    return _messageReadStateLabel;
}

#pragma mark - HeadPortraitDelegate
-(void)headPortraitClickAuthor
{
    if ([self.delegate respondsToSelector:@selector(chatCell:didClickHeadProtraitWithViewModel:)]) {
        [self.delegate chatCell:self didClickHeadProtraitWithViewModel:self.viewModel];
    }
}
#pragma mark - Tap Gesture: MessageContainerView
- (void)didTapMessageContainerView:(UITapGestureRecognizer *)tap
{
    if ([self.delegate respondsToSelector:@selector(chatCell:didClickHeadProtraitWithViewModel:)]) {
        [self.delegate chatCell:self didClickContentViewWithViewModel:self.viewModel];
    }
}

#pragma mark - SLChatMessageCellProtocol
+ (CGFloat)getCellHeightWithViewModel:(id<SLChatMessageBaseCellViewModel>)viewModel;
{
    NSAssert(0, @"subclass should implementate it");
    return 0;
}

#pragma mark - Private

- (void)addSentMessageStateAnimation
{
    self.messageReadStateLabel.layer.opacity = 0.f;
    [self setMessageStateLabelTextWithSentMessageIsRead:YES];
    [self.messageReadStateLabel.layer removeAnimationForKey:@"messageStateLabelAnim"];
    self.messageReadStateLabel.layer.timeOffset = 0;
    self.messageReadStateLabel.layer.speed = 1.f;
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"opacity"];
    anim.beginTime = CACurrentMediaTime()+0.5;
    anim.timeOffset = 0;
    anim.fromValue = @0.f;
    anim.toValue = @1.f;
    anim.duration = 1.f;
    anim.removedOnCompletion = NO;
    anim.fillMode = kCAFillModeForwards;
    [self.messageReadStateLabel.layer addAnimation:anim forKey:@"messageStateLabelAnim"];
}

- (NSAttributedString *)defaultNotDisturbBottomTipsAttributedString
{
    NSString *subString = @"免打扰或拉黑";
    NSString *string = [NSString stringWithFormat:@"若对方消息打扰，可以设置%@", subString];
    NSRange range = [string rangeOfString:subString];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:string];
    [attributedString yy_setColor:[UIColor whiteColor] range:NSMakeRange(0, range.location)];
    [attributedString yy_setColor:RGBAllColor(0x34B6FF) range:range];
    attributedString.yy_font = [UIFont systemFontOfSize:12];
    attributedString.yy_alignment = NSTextAlignmentCenter;
    
    return attributedString;
}

- (void)setDefaultShowNotDistrubBottomTips
{
    _bottomTipsLabel.attributedText = [self defaultNotDisturbBottomTipsAttributedString];
    
#if CHAT_USE_YYLABEL
    // set delegate
    @weakify(self);
    [_bottomTipsLabel setTextTapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
        @strongify(self);
        if ([self.delegate respondsToSelector:@selector(chatCell:didClickBottomTipsLabelWithViewModel:)]) {
            [self.delegate chatCell:self didClickBottomTipsLabelWithViewModel:self.viewModel];
        }
    }];
#else
#endif
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

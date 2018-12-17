//
//  LPCoverView.m
//  Edu
//
//  Created by chenyh on 2018/9/19.
//  Copyright © 2018年 chuxia. All rights reserved.
//

#import "LPCoverView.h"
#import "SLHeadPortrait.h"
#import "SLShadowLabel.h"
#import "LPIconView.h"

CGFloat LPGetLabelWidth(UILabel *label) {
    return [label.text boundingRectWithSize:CGSizeMake(MAXFLOAT, label.font.lineHeight) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : label.font} context:nil].size.width;
}

static CGFloat const kLPUserViewWH = 17;

/**
 LPCoverView create
 */
@interface LPCoverView ()

@property (nonatomic, strong) UIButton *addButton;
@property (nonatomic, strong) UIButton *preCoverButton;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) LPIconView *showView;
@property (nonatomic, strong) LPIconView *ratioView;
@property (nonatomic, strong) UILabel *textLabel;
@property (nonatomic, strong) SLHeadPortrait  *userView;
@property (nonatomic, strong) UILabel *nameLabel;

@end

@implementation LPCoverView {
    BOOL isScale;
    CGRect  originRect_;
    CGRect  beginRect_;
    UIView *beginView_;
}

/**
 initWithFrame

 @param frame CGRect
 @return instancetype
 */
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.imageView];
        [self addSubview:self.addButton];
        [self addSubview:self.preCoverButton];
        [self addSubview:self.showView];
        [self addSubview:self.ratioView];
        [self addSubview:self.textLabel];
        [self addSubview:self.userView];
        [self addSubview:self.nameLabel];
        
        LPSetViewCornerRadius(self);
        self.clipsToBounds = YES;
        
        [self addinfo];
        [self viewIsShare:NO];
        self.coverUrl = @"";
    }
    return self;
}

/**
 layoutSubviews
 */
- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat w = CGRectGetWidth(self.frame);
    CGFloat h = CGRectGetHeight(self.frame);
    
    self.imageView.frame = self.bounds;
    
    self.addButton.bounds = CGRectMake(0, 0, w, 100);
    self.addButton.center = CGPointMake(w / 2, h / 4);
    
    CGFloat leftMargin   = 10;
    CGFloat bottomMargin = 10;
    
    CGFloat viewX = 0;
    CGFloat viewH = 0;
    CGFloat viewW = 0;
    CGFloat viewY = 0;
    
    viewW = 80;//LPGetLabelWidth(self.preCoverButton.titleLabel) + 8;
    viewY = 100;
    viewX = (w - viewW) / 2;
    viewH = 30;//self.preCoverButton.titleLabel.font.lineHeight + 6;
    self.preCoverButton.frame = CGRectMake(viewX, viewY, viewW, viewH);
    
    CGRect userF = self.userView.frame;
    userF.origin.x = leftMargin;
    userF.origin.y = h - bottomMargin - userF.size.height - (isScale ? KTabbarSafeBottomMargin : 0);
    self.userView.frame = userF;
    
    viewX = CGRectGetMaxX(self.userView.frame) + 5;
    viewY = CGRectGetMinY(self.userView.frame);
    viewW = w - viewX - leftMargin;
    viewH = userF.size.height;
    self.nameLabel.frame = CGRectMake(viewX, viewY, viewW, viewH);
    
    viewX = leftMargin;
    viewW = w - 6;
    if (isScale) {
        viewW = w - leftMargin * 3 - 70;
    }
    viewH = SLFuncGetTextHeightFromLabel(self.textLabel, viewW);
    CGFloat kMaxH = self.textLabel.font.lineHeight * 3;
    if (viewH > kMaxH) {
        viewH = kMaxH;
    }
    viewY = CGRectGetMinY(self.nameLabel.frame) - kMaxH - 5;
    self.textLabel.frame = CGRectMake(viewX, viewY, viewW, viewH);
    
    CGFloat customMargin = self.ratioView.viewH * 1.5;
    viewX = leftMargin;
    viewW = LPGetLabelWidth(self.ratioView.textLabel) + customMargin;
    viewH = self.ratioView.viewH;
    viewY = CGRectGetMinY(self.textLabel.frame) - viewH - 5;
    if (self.textLabel.frame.size.height == 0) {
        viewY = CGRectGetMinY(self.nameLabel.frame) - viewH - 5;
    }
    self.ratioView.frame = CGRectMake(viewX, viewY, viewW, viewH);
    
    viewX = leftMargin;
    viewW = LPGetLabelWidth(self.showView.textLabel) + customMargin;
    viewH = CGRectGetHeight(self.ratioView.frame);
    viewY = CGRectGetMinY(self.ratioView.frame) - viewH - 5;
    self.showView.frame = CGRectMake(viewX, viewY, viewW, viewH);
}

/**
 touchesBegan

 @param touches NSSet
 @param event UIEvent
 */
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (isScale) {
        self->isScale = NO;
        [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveEaseIn | UIViewAnimationOptionLayoutSubviews animations:^{
            self.frame = self->beginRect_;
            [self setNeedsDisplay];
        } completion:^(BOOL finished) {
            self.frame = self->originRect_;
            [self->beginView_ addSubview:self];
            self.preCoverButton.hidden = NO;
        }];
    } else {
        CGPoint point = [touches.anyObject locationInView:self];
        CGRect topRect = CGRectMake(0, 0, self.width, self.height / 2);
        if (CGRectContainsPoint(topRect, point)) {
            [self addCorverAction];
        }
    }
}

/// 设置用户信息
/**
 addinfo
 */
- (void)addinfo {
    [self.userView setRoundStyle:YES imageUrl:AccountModel.shared.avatar
                     imageHeight:self.userView.height vip:NO attestation:NO];
    self.nameLabel.text = AccountModel.shared.nickname;
}

#pragma mark - Method

/**
 sl_updateTitle

 @param text NSString
 */
- (void)sl_updateTitle:(NSString *)text {
    self.textLabel.text = text.length > 0 ? text : kLPPlaceholderText;
    [self layoutSubviews];
}

/**
 <#Description#>

 @param text <#text description#>
 */
- (void)sl_updateWatch:(NSString *)text {
    self.ratioView.textLabel.text = [NSString stringWithFormat:@"%.2lf%%", [text doubleValue]];
    [self layoutSubviews];
}

- (void)sl_updateCoin:(NSString *)text {
    self.showView.textLabel.text = text;
    [self layoutSubviews];
}

- (void)addCorverAction {
    if (self.changeCoverBlock) {
        self.changeCoverBlock();
    }
}

- (void)setCoverUrl:(NSString *)coverUrl {
    _coverUrl = coverUrl;
    if (IsValidString(coverUrl)) {
        [self.imageView yy_setImageWithURL:[NSURL URLWithString:coverUrl] options:0];
        self.addButton.hidden = YES;
        self.preCoverButton.hidden = NO;
        self.backgroundColor = [UIColor clearColor];
    } else {
        self.addButton.hidden = NO;
        self.preCoverButton.hidden = YES;
        self.imageView.image = nil;
        self.backgroundColor = [Color(@"0c0c0c") colorWithAlphaComponent:0.4]; // LPViewBackgroundColor();
    }
}

- (void)sl_showShare {
    self.addButton.hidden = YES;
    self.preCoverButton.hidden = YES;
    
    isScale = YES;
    beginView_  = self.superview;
    originRect_ = self.frame;
    CGRect rect = [self convertRect:self.frame toCoordinateSpace:UIApplication.sharedApplication.keyWindow];
    beginRect_ = rect;
    self.frame = rect;
    [UIApplication.sharedApplication.keyWindow addSubview:self];
    
    CGFloat w = UIScreen.mainScreen.bounds.size.width * 0.8;
    CGFloat h = w * 818 / 375;
    CGRect bounds = CGRectMake(0, 0, w, h);
    
    [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveEaseOut | UIViewAnimationOptionLayoutSubviews animations:^{
        self.bounds = bounds;
        self.center = UIApplication.sharedApplication.keyWindow.center;
    } completion:nil];
}

- (void)sl_shareConfig {
    self.addButton.hidden = YES;
    self.preCoverButton.hidden = YES;
    self.layer.cornerRadius = 0;
    self.imageView.alpha = 1;
    isScale = YES;
    [self viewIsShare:YES];
    [self layoutSubviews];
}

// 分两种view 默认小图设置  大图分享
- (void)viewIsShare:(BOOL)isShare {
    if (isShare) {
        [self.userView removeFromSuperview];
        /// 重新创建SLHeadPortrait,重置大小
        self.userView = [[SLHeadPortrait alloc] initWithFrame:CGRectMake(0, 0, 34, 34)];
        [self addSubview:self.userView];
        [self addinfo];
        self.nameLabel.font = [UIFont systemFontOfSize:15];
        self.textLabel.font = [UIFont systemFontOfSize:18];
        self.ratioView.textLabel.font = [UIFont systemFontOfSize:18];
        self.showView.textLabel.font  = [UIFont systemFontOfSize:18];
    } else {
        self.nameLabel.font = [UIFont systemFontOfSize:7];
        self.textLabel.font = [UIFont systemFontOfSize:12];
        self.ratioView.textLabel.font = [UIFont systemFontOfSize:10];
        self.showView.textLabel.font  = [UIFont systemFontOfSize:10];
    }
}

#pragma mark - lazy

- (UIButton *)addButton {
    if (!_addButton) {
        _addButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_addButton setImage:[UIImage imageNamed:@"lp_cover_add"] forState:UIControlStateNormal];
        [_addButton addTarget:self action:@selector(addCorverAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addButton;
}

- (UIButton *)preCoverButton {
    if (!_preCoverButton) {
        _preCoverButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_preCoverButton setTitle:@"更换封面" forState:UIControlStateNormal];
        [_preCoverButton addTarget:self action:@selector(addCorverAction) forControlEvents:UIControlEventTouchUpInside];
        _preCoverButton.titleLabel.font = [UIFont systemFontOfSize:16];
        _preCoverButton.backgroundColor = [UIColor colorWithWhite:0 alpha:0.2];
        LPSetViewCornerRadius(_preCoverButton);
        _preCoverButton.hidden = YES;
    }
    return _preCoverButton;
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        _imageView.alpha = kLPAlpha;
    }
    return _imageView;
}

- (LPIconView *)showView {
    if (!_showView) {
        _showView = [[LPIconView alloc] init];
        _showView.imageView.image = [UIImage imageNamed:@"lp_cover_show"];
        _showView.textLabel.text = @"0";
    }
    return _showView;
}

- (LPIconView *)ratioView {
    if (!_ratioView) {
        _ratioView = [[LPIconView alloc] init];
        _ratioView.imageView.image = [UIImage imageNamed:@"lp_cover_watch"];
        _ratioView.textLabel.text = @"0%";
    }
    return _ratioView;
}

- (UILabel *)textLabel {
    if (!_textLabel) {
        _textLabel = [[SLShadowLabel alloc] init];
        _textLabel.textColor = kTextWhitef7f7f7;
        _textLabel.font = [UIFont systemFontOfSize:12];
        _textLabel.text = kLPPlaceholderText;
        _textLabel.numberOfLines = 3;
    }
    return _textLabel;
}

- (SLHeadPortrait *)userView {
    if (!_userView) {
        _userView = [[SLHeadPortrait alloc] initWithFrame:CGRectMake(0, 0, kLPUserViewWH, kLPUserViewWH)];
    }
    return _userView;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[SLShadowLabel alloc] init];
        _nameLabel.textColor = [UIColor whiteColor];
        _nameLabel.font = [UIFont systemFontOfSize:11];
    }
    return _nameLabel;
}

@end

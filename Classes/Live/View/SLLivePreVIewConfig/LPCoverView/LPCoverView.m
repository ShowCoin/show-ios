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

@end

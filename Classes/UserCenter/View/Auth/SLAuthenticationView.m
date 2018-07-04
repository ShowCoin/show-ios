//
//  SLIdCardVIew.m
//  test
//
//  Created by chenyh on 2018/7/2.
//  Copyright © 2018年 chuxia. All rights reserved.
//

#import "SLAuthenticationView.h"

static CGFloat const kMargin = 15;

@interface SLAuthenticationView ()

@property (nonatomic, weak) UILabel *textLabel;
@property (nonatomic, weak) UILabel *detialLabel;
@property (nonatomic, weak) SLAuthImageView *imageView;
@property (nonatomic, weak) UIImageView *placeholderView;
@property (nonatomic, weak) UILabel *errorLabel;
@property (nonatomic, copy) NSString *placeholder;

@end

@implementation SLAuthenticationView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    self.backgroundColor = SLNormalColor;
    UILabel *label = [[UILabel alloc] init];
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:15];
    [self addSubview:label];
    self.textLabel = label;
    
    label = [[UILabel alloc] init];
    label.textColor = [UIColor lightGrayColor];
    label.font = [UIFont systemFontOfSize:12];
    label.numberOfLines = 0;
    [self addSubview:label];
    self.detialLabel = label;
    
    SLAuthImageView *imageView = [[SLAuthImageView alloc] init];
    [self addSubview:imageView];
    self.imageView = imageView;
    
    UIImageView *imageView2 = [[UIImageView alloc] init];
    //imageView2.backgroundColor = [UIColor purpleColor];
    [self addSubview:imageView2];
    self.placeholderView = imageView2;
    
    label = [[UILabel alloc] init];
    label.textColor = [UIColor redColor];//
    label.font = [UIFont systemFontOfSize:12];
    label.numberOfLines = 0;
    label.hidden = YES;
    [self addSubview:label];
    self.errorLabel = label;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat w = self.frame.size.width;
    w = w == 0 ? UIScreen.mainScreen.bounds.size.width : w;

    CGFloat labelW = w - kMargin * 2;
    CGFloat labelH = self.textLabel.font.lineHeight;
    [self.textLabel sizeToFit];
    CGFloat textW = self.textLabel.frame.size.width;
    self.textLabel.frame = CGRectMake(kMargin, 15, textW, labelH);
    
    CGFloat detialX = 0;
    CGFloat detialY = 0;
    CGFloat detialH = 0;
    CGFloat detialW = 0;
    if (self.type == SLIdCardTypeHand) {
        detialX = kMargin;
        detialY = CGRectGetMaxY(self.textLabel.frame);
        detialW = labelW;
        detialH = [self.detialLabel.text boundingRectWithSize:CGSizeMake(detialW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : self.detialLabel.font} context:nil].size.height;
    } else {
        detialH = self.detialLabel.font.lineHeight;
        detialX = CGRectGetMaxX(self.textLabel.frame) + 5;
        detialY = CGRectGetMaxY(self.textLabel.frame) - detialH;
        detialW = labelW - CGRectGetMaxX(self.textLabel.frame) - kMargin * 2;
    }
    self.detialLabel.frame = CGRectMake(detialX, detialY, detialW, detialH);
    
    CGFloat imageW = (w - kMargin * 3) / 2;
    CGFloat imageY = CGRectGetMaxY(self.detialLabel.frame) + 15;
    // w1 / h1 = w2 / h2
    // h2 w1 = w2 h1
    CGFloat kImageViewH = imageW *  110 / 170;
    self.imageView.frame = CGRectMake(kMargin, imageY, imageW, kImageViewH);
    
    CGFloat placeX = CGRectGetMaxX(self.imageView.frame) + kMargin;
    self.placeholderView.frame = CGRectMake(placeX, imageY, imageW, kImageViewH);
    
    if (self.errorLabel.hidden == NO) {
        CGFloat errorY = CGRectGetMaxY(self.placeholderView.frame) + 15;
        CGFloat errorH = [self.errorLabel.text boundingRectWithSize:CGSizeMake(labelW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : self.errorLabel.font} context:nil].size.height;
        self.errorLabel.frame = CGRectMake(kMargin, errorY, labelW, errorH);
    }
}


@end



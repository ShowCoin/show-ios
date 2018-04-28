//
//  SLEmojiCell.m
//  ShowLive
//
//  Created by Mac on 2018/4/11.
//  Copyright © 2018年 VNing. All rights reserved.
//

#import "SLEmojiCollectionCell.h"
#import "SLEmoji.h"
#import "SLPureColorImageGenerate.h"

@interface SLEmojiCollectionCell()
@property (strong, nonatomic) UIButton *emojiButton;
@property (strong, nonatomic) UILabel *emojiLabel;
@end
@implementation SLEmojiCollectionCell
#pragma mark - LifeCycle
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self setupViews];
    }
    return self;
}

#pragma mark - setup
- (void)setupViews
{
    [self.contentView addSubview:self.emojiLabel];
    [self.contentView addSubview:self.emojiButton];

    self.emojiLabel.frame = self.bounds;
    self.emojiButton.frame = self.bounds;
}

- (void)setEmoji:(SLEmoji *)emoji
{
    _emoji = emoji;
    self.emojiLabel.text = emoji.emojiString;
}

#pragma mark - Getter
- (UILabel *)emojiLabel
{
    if (!_emojiLabel) {
        _emojiLabel = [[UILabel alloc] init];
        _emojiLabel.font = [UIFont systemFontOfSize:30];
        _emojiLabel.textAlignment = NSTextAlignmentCenter;
        // 搭配使用，居中
//        _emojiLabel.numberOfLines = 1;
//        _emojiLabel.adjustsFontSizeToFitWidth = YES;
//        _emojiLabel.minimumScaleFactor = 0.5;
//        _emojiLabel.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
    }
    return _emojiLabel;
}

- (UIButton *)emojiButton
{
    if (!_emojiButton) {
        _emojiButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [_emojiButton addTarget:self action:@selector(onEmojiButtonClick:) forControlEvents:UIControlEventTouchUpInside];
//        UIImage *image = [SLPureColorImageGenerate getImageWithColor:RGBACOLOR(0, 0, 0, 0.7) andSize:self.size corner:0];
//        [_emojiButton setBackgroundImage:image forState:UIControlStateHighlighted];
    }
    return _emojiButton;
}

#pragma mark - Action
- (void)onEmojiButtonClick:(id)sender
{
    if (self.emojiButtonClick) {
        self.emojiButtonClick(self.emoji);
    }
}

@end

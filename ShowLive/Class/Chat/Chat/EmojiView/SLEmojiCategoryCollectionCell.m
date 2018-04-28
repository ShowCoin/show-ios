//
//  SLEmojiCategoryCollectionCell.m
//  ShowLive
//
//  Created by Mac on 2018/4/11.
//  Copyright © 2018年 VNing. All rights reserved.
//

#import "SLEmojiCategoryCollectionCell.h"
#import "SLEmojiCategory.h"

@interface SLEmojiCategoryCollectionCell()
@property (strong, nonatomic) UIButton *button;
@end
@implementation SLEmojiCategoryCollectionCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
    }
    return self;
}

#pragma mark - setup
- (void)setupViews
{
    [self.contentView addSubview:self.button];
    [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}

- (void)setEmojiCategory:(SLEmojiCategory *)emojiCategory
{
    _emojiCategory = emojiCategory;
    NSString *transformedImageName =  [NSString stringWithFormat:@"emoji_category_%@", _emojiCategory.name];
    NSString *transformedHighlightImageName = [transformedImageName stringByAppendingString:@"_selected"];
    [self.button setImage:[UIImage imageNamed:transformedImageName] forState:UIControlStateNormal];
    [self.button setImage:[UIImage imageNamed:transformedHighlightImageName] forState:UIControlStateHighlighted];
    [self.button setImage:[UIImage imageNamed:transformedHighlightImageName] forState:UIControlStateSelected];
}

- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    self.button.selected = selected;
    if (selected) {
        self.button.backgroundColor = HexRGBAlpha(0xECEEF1, 1);
    } else {
        self.button.backgroundColor = nil;
    }
}

#pragma mark - Getter
- (UIButton *)button
{
    if (!_button) {
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        _button.userInteractionEnabled = NO;
//        [_button addTarget:self action:@selector(onSendButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button;
}
@end

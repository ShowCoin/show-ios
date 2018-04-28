//
//  SLEmojiPageCollectionCell.m
//  ShowLive
//
//  Created by Mac on 2018/4/11.
//  Copyright © 2018年 VNing. All rights reserved.
//

#define SLEmojiPageCollectionCell_Use_Collection 0

#import "SLEmojiPageCollectionCell.h"
#import "SLEmojiPageData.h"
#import "SLEmojiLayoutConst.h"
#import "SLEmojiLayout.h"

#if SLEmojiPageCollectionCell_Use_Collection
    #import "SLEmojiCollectionView.h"
#else
    #import "SLEmojiPageCellEmojiView.h"
#endif


@interface SLEmojiPageCollectionCell()
#if SLEmojiPageCollectionCell_Use_Collection
@property (strong, nonatomic) SLEmojiCollectionView *collectionView;
#else
@property (strong, nonatomic) SLEmojiPageCellEmojiView *cellEmojiView;
#endif

@property (strong, nonatomic) UIButton *deleteButton;
@property (strong, nonatomic) UILabel *tipsLabel;

@end

@implementation SLEmojiPageCollectionCell
#pragma mark - LifeCycle
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
#if SLEmojiPageCollectionCell_Use_Collection
    [self.contentView addSubview:self.collectionView];
#else
    [self.contentView addSubview:self.cellEmojiView];
#endif
    
    [self.contentView addSubview:self.tipsLabel];
    [self.contentView addSubview:self.deleteButton];
    self.tipsLabel.hidden = YES;
    self.backgroundColor = [UIColor clearColor];
}

- (void)setPageData:(SLEmojiPageData *)pageData
{
    _pageData = pageData;
    
#if SLEmojiPageCollectionCell_Use_Collection
    if (self.collectionView.emojis != pageData.emojis) {
        self.collectionView.emojis = pageData.emojis;
        [self.collectionView reloadData];
    }
#else
    if (self.cellEmojiView.emojis != pageData.emojis) {
        self.cellEmojiView.emojis = pageData.emojis;
    }
#endif
    
    if (!pageData.emojis || pageData.emojis.count == 0) {
        self.tipsLabel.hidden = NO;
        self.deleteButton.hidden = YES;
    } else {
        self.tipsLabel.hidden = YES;
        self.deleteButton.hidden = NO;
    }
}

#pragma mark - Getter

#if SLEmojiPageCollectionCell_Use_Collection
- (SLEmojiCollectionView *)collectionView
{
    if (!_collectionView) {
        _collectionView = [SLEmojiCollectionView viewWithFrame:CGRectMake(SLEmojiCollectionViewMarginPadding, SLEmojiCollectionViewMarginPadding, kMainScreenWidth-SLEmojiCollectionViewMarginPadding*2, SLEmojiCollectionViewHeight)];
    }
    return _collectionView;
}

#else
- (SLEmojiPageCellEmojiView *)cellEmojiView
{
    if (!_cellEmojiView) {
        _cellEmojiView = [[SLEmojiPageCellEmojiView alloc] initWithFrame:CGRectMake(SLEmojiCollectionViewMarginPadding, SLEmojiCollectionViewMarginPadding, kMainScreenWidth-SLEmojiCollectionViewMarginPadding*2, SLEmojiCollectionViewHeight)];
    }
    return _cellEmojiView;
}
#endif

- (UIButton *)deleteButton
{
    if (!_deleteButton) {
        _deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_deleteButton setImage:[UIImage imageNamed:@"emoji_delete_icon"] forState:UIControlStateNormal];
        [_deleteButton addTarget:self action:@selector(onEmojiButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        _deleteButton.frame = CGRectMake(kMainScreenWidth-SLEmojiCollectionViewMarginPadding-SLEmojiCollectionViewItemWidth, SLEmojiCollectionViewMarginPadding+SLEmojiCollectionViewHeight-SLEmojiCollectionViewItemWidth, SLEmojiCollectionViewItemWidth, SLEmojiCollectionViewItemWidth);
        
        UILongPressGestureRecognizer *longPressGestureRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPressGestureRecognizer:)];
        [_deleteButton addGestureRecognizer:longPressGestureRecognizer];
    }
    return _deleteButton;
}

- (UILabel *)tipsLabel
{
    if (!_tipsLabel) {
        _tipsLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.centerY - 30, self.width, 60)];
        _tipsLabel.textAlignment = NSTextAlignmentCenter;
        _tipsLabel.text = @"暂无历史表情";
        _tipsLabel.textColor = HexRGBAlpha(0xA4AAB3, 1);
        _tipsLabel.font = Font_Regular(14);
    }
    return _tipsLabel;
}

#pragma mark - Action
- (void)onEmojiButtonClick:(id)sender
{
    if (self.didClickDeleteButton) {
        self.didClickDeleteButton(sender);
    }
}

- (void)handleLongPressGestureRecognizer:(UILongPressGestureRecognizer *)gesture
{
    if (gesture.state == UIGestureRecognizerStateBegan || gesture.state == UIGestureRecognizerStateChanged) {
        if (self.didClickDeleteButton) {
            self.didClickDeleteButton(self.deleteButton);
        }
    }
}

- (void)setEmojiCollectionViewDidSelectItemWithEmoji:(void (^)(SLEmoji *))emojiCollectionViewDidSelectItemWithEmoji
{
#if SLEmojiPageCollectionCell_Use_Collection
    [self.collectionView setEmojiCollectionViewDidSelectItemWithEmoji:emojiCollectionViewDidSelectItemWithEmoji];
#else
    [self.cellEmojiView setEmojiCollectionViewDidSelectItemWithEmoji:emojiCollectionViewDidSelectItemWithEmoji];
#endif
}
@end

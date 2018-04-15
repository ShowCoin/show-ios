//
//  SLEmojiCategoryView.m
//  ShowLive
//
//  Created by 周华 on 2018/4/11.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "SLEmojiCategoryView.h"
#import "SLEmojiCategoryCollectionCell.h"
#import "SLEmojiCategory.h"

static const CGFloat sendButtonWidth = 60;

@interface SLEmojiCategoryView()<UICollectionViewDataSource,
                                 UICollectionViewDelegate,
                                 UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic) UICollectionView *collectionView;
@property (strong, nonatomic) UIButton *sendButton;
@property (assign, nonatomic) CGFloat itemWidth;
@end
@implementation SLEmojiCategoryView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
    }
    return self;
}

#pragma mark - setUp
- (void)setupViews
{
    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.collectionView];
    [self addSubview:self.sendButton];
}

- (void)setEmojiCategories:(NSArray<SLEmojiCategory *> *)emojiCategories
{
    _emojiCategories = emojiCategories;
    if (_emojiCategories.count > 0) {
        self.itemWidth = (self.width-sendButtonWidth)/_emojiCategories.count;
    }
}

- (void)reloadData
{
    [self.collectionView reloadData];
}

- (void)selectAtIndex:(NSInteger)index
{
    if (index < self.emojiCategories.count) {
        [self.collectionView selectItemAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0] animated:YES scrollPosition:UICollectionViewScrollPositionNone];
    }
}

- (void)setEnableSendButton:(BOOL)enableSendButton
{
    _enableSendButton = enableSendButton;
    _sendButton.enabled = enableSendButton;
//    _sendButton.alpha = enableSendButton ? 1.0 : 0.6;
}

#pragma mark - Getter
- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.minimumInteritemSpacing = 0;
        layout.minimumLineSpacing = 0;
        layout.sectionInset = UIEdgeInsetsZero;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.width-sendButtonWidth, self.height) collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[SLEmojiCategoryCollectionCell class] forCellWithReuseIdentifier:@"SLEmojiCategoryCollectionCell"];
        if (@available(iOS 11.0, *)) {
            _collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return _collectionView;
}

- (UIButton *)sendButton
{
    if (!_sendButton) {
        _sendButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _sendButton.frame = CGRectMake(self.width-sendButtonWidth, 0, sendButtonWidth, self.height);
        [_sendButton setTitle:@"发送" forState:UIControlStateNormal];
        [_sendButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _sendButton.backgroundColor = HexRGBAlpha(0x47BAFE, 1);
        _sendButton.titleLabel.font = Font_Medium(15);
        [_sendButton addTarget:self action:@selector(onSendButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sendButton;
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.emojiCategories.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SLEmojiCategoryCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SLEmojiCategoryCollectionCell" forIndexPath:indexPath];
    SLEmojiCategory *emojiCagegory = self.emojiCategories[indexPath.row];
    cell.emojiCategory = emojiCagegory;
    return cell;
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(self.itemWidth, self.height);
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.delegate respondsToSelector:@selector(emojiCategoryView:didSelectedRowAtIndexPath:)]) {
        [self.delegate emojiCategoryView:self didSelectedRowAtIndexPath:indexPath];
    }
}

#pragma mark - Action
- (void)onSendButtonClick:(UIButton *)button
{
    if ([self.delegate respondsToSelector:@selector(emojiCategoryView:didClickSendButton:)]) {
        [self.delegate emojiCategoryView:self didClickSendButton:button];
    }
}

@end

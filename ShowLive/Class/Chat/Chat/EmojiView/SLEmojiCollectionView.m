//
//  SLEmojiCollectionView.m
//  ShowLive
//
//  Created by 周华 on 2018/4/11.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "SLEmojiCollectionView.h"
#import "SLEmojiCollectionCell.h"
#import "SLEmojiHelper.h"
#import "SLEmojiLayout.h"

@interface SLEmojiCollectionView()<UICollectionViewDelegate, UICollectionViewDataSource>
@end

@implementation SLEmojiCollectionView
+ (instancetype)viewWithFrame:(CGRect)frame
{
    SLEmojiLayout *emojiLayout = [SLEmojiLayout getEmojiLayout];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.minimumInteritemSpacing = emojiLayout.itemSpacing;
    layout.minimumLineSpacing = emojiLayout.lineSpacing;
    layout.sectionInset = UIEdgeInsetsZero;
    layout.itemSize = emojiLayout.itemSize;
    SLEmojiCollectionView *pageCollectionView = [[self alloc] initWithFrame:frame collectionViewLayout:layout];
    return pageCollectionView;
}

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout
{
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        [self registerClass:[SLEmojiCollectionCell class] forCellWithReuseIdentifier:@"SLEmojiCell"];
        self.delegate = self;
        self.dataSource = self;
        self.backgroundColor = [UIColor clearColor];
        self.showsHorizontalScrollIndicator = NO;
        self.scrollEnabled = NO;
        if (@available(iOS 11.0, *)) {
            self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return self;
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.emojis.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SLEmojiCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SLEmojiCell" forIndexPath:indexPath];
    SLEmoji *emoji = self.emojis[indexPath.row];
    cell.emoji = emoji;
    
    @weakify(self);
    cell.emojiButtonClick = ^(SLEmoji *emoji) {
        @strongify(self);
        if (self.emojiCollectionViewDidSelectItemWithEmoji) {
            self.emojiCollectionViewDidSelectItemWithEmoji(emoji);
        }
    };
    return cell;
}


//#pragma mark - UICollectionViewDelegate
//- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
//    if (self.emojiCollectionViewDidSelectItemWithEmoji) {
//        SLEmoji *emoji = self.emojis[indexPath.row];
//        self.emojiCollectionViewDidSelectItemWithEmoji(emoji);
//    }
//}
@end

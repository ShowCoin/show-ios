//
//  SLEmojiPageCollectionView.m
//  ShowLive
//
//  Created by 周华 on 2018/4/11.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "SLEmojiPageCollectionView.h"
#import "SLEmojiPageCollectionCell.h"

@interface SLEmojiPageCollectionView()<UICollectionViewDelegate, UICollectionViewDataSource>
@end
@implementation SLEmojiPageCollectionView
+ (instancetype)viewWithFrame:(CGRect)frame
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    layout.sectionInset = UIEdgeInsetsZero;
    layout.itemSize = CGSizeMake(frame.size.width, frame.size.height);
    SLEmojiPageCollectionView *pageCollectionView = [[self alloc] initWithFrame:frame collectionViewLayout:layout];
    return pageCollectionView;
}

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout
{
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {

        self.delegate = self;
        self.dataSource = self;
        self.backgroundColor = [UIColor clearColor];
        self.pagingEnabled = YES;
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;

//        [self registerClass:[SLEmojiPageCollectionCell class] forCellWithReuseIdentifier:@"SLEmojiPageCollectionCell"];

        [self registerClass:[SLEmojiPageCollectionCell class] forCellWithReuseIdentifier:@"SLEmojiPageCollectionCell_0"];
        [self registerClass:[SLEmojiPageCollectionCell class] forCellWithReuseIdentifier:@"SLEmojiPageCollectionCell_1"];
        [self registerClass:[SLEmojiPageCollectionCell class] forCellWithReuseIdentifier:@"SLEmojiPageCollectionCell_2"];
        
        if (IOS10) {
            self.prefetchingEnabled = NO;// 滑动卡顿bug
        }
        
        if (@available(iOS 11.0, *)) {
            self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return self;
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.emojiCategories.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    SLEmojiCategory *emojiCagegory = self.emojiCategories[section];
    return emojiCagegory.pageDataList.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger i = indexPath.row % 3;
    NSString *identifier = [NSString stringWithFormat:@"SLEmojiPageCollectionCell_%ld", (long)i];

//    NSString *identifier = @"SLEmojiPageCollectionCell";
    SLEmojiPageCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    SLEmojiCategory *emojiCagegory = self.emojiCategories[indexPath.section];
    SLEmojiPageData *pageData = emojiCagegory.pageDataList[indexPath.row];
    cell.pageData = pageData;
    
    @weakify(self);
    cell.didClickDeleteButton = ^ (UIButton *deleteButton) {
        @strongify(self);
        if ([self.eventDelegate respondsToSelector:@selector(emojiPageCollectionViewDidClickDeleteButton:)]) {
            [self.eventDelegate emojiPageCollectionViewDidClickDeleteButton:deleteButton];
        }
    };
    
    cell.emojiCollectionViewDidSelectItemWithEmoji = ^(SLEmoji *emoji) {
        @strongify(self);
        if ([self.eventDelegate respondsToSelector:@selector(emojiPageCollectionViewDidSelectItemWithEmoji:)]) {
            [self.eventDelegate emojiPageCollectionViewDidSelectItemWithEmoji:emoji];
        }
    };
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
//    SLEmojiCategory *emojiCagegory = self.emojiCategories[indexPath.section];
//    SLEmojiPageData *pageData = emojiCagegory.pageDataList[indexPath.row];
//    ((SLEmojiPageCollectionCell *)cell).pageData = pageData;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if ([self.eventDelegate respondsToSelector:@selector(emojiPageCollectionViewDidScrollAtIndexPath:)]) {
        NSIndexPath *indexPath = [self indexPathForItemAtPoint:self.contentOffset];
        [self.eventDelegate emojiPageCollectionViewDidScrollAtIndexPath:indexPath];
    }
}
@end

//
//  SLEmojiView.m
//  ShowLive
//
//  Created by Mac on 2018/4/11.
//  Copyright © 2018年 VNing. All rights reserved.
//

#import "SLEmojiView.h"
#import "SLEmojiCategoryView.h"
#import "SLEmojiHelper.h"
#import "SLEmojiPageCollectionView.h"
#import "SLEmojiCacheManage.h"
#import "SLEmojiLayoutConst.h"
#import "SLEmojiPageCollectionCell.h"

NSString * const SLEmojiViewWillShowNotification = @"SLEmojiViewWillShowNotification";
NSString * const SLEmojiViewWillHideNotification = @"SLEmojiViewWillHideNotification";

static inline CGFloat GetSLEmojiViewContentHeight(void){
    return 228+KTabbarSafeBottomMargin;
}

@interface SLEmojiView()<SLEmojiCategoryViewDelegate,SLEmojiPageCollectionViewDelegate>
@property (copy, nonatomic) EmojiViewDidClickEmojiBlock didClickEmojiBlock;
@property (copy, nonatomic) EmojiViewDidClickDeleteButtonBlock didClickDeleteButtonBlock;
@property (copy, nonatomic) EmojiViewDidClickSendButtonBlock didClickSendButtonBlock;
@property (strong, nonatomic) UIPageControl *pageControl;
@property (strong, nonatomic) SLEmojiCategoryView *categoryView;
@property (strong, nonatomic) SLEmojiPageCollectionView *pageCollectionView;
@property (weak, nonatomic) id<SLEmojiViewDelegate> delegate;
@property (strong, nonatomic) NSMutableArray<SLEmojiCategory *> *emojiCategories;
@property (strong, nonatomic) NSIndexPath *currentIndexPath;
@property (assign, nonatomic) CGFloat transDistance;
@end

@implementation SLEmojiView

#pragma mark - LifeCycle
- (void)dealloc
{
    NSLog(@"");
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
        [self loadData];
    }
    return self;
}

#pragma mark - Init
+ (SLEmojiView *)emojiViewWithDelegate:(id<SLEmojiViewDelegate>)delegate
{
    SLEmojiView *emojiView = [[self alloc] initWithFrame:CGRectMake(0, kMainScreenHeight - GetSLEmojiViewContentHeight(), kMainScreenWidth, GetSLEmojiViewContentHeight())];
    emojiView.delegate = delegate;
    return emojiView;
}

+ (SLEmojiView *)emojiViewWithDidClickEmojiBlock:(EmojiViewDidClickEmojiBlock)didClickEmojiBlock
                         didClickSendButtonBlock:(EmojiViewDidClickSendButtonBlock)didClickSendButtonBlock
                       didClickDeleteButtonBlock:(EmojiViewDidClickDeleteButtonBlock)didClickDeleteButtonBlock
{
    SLEmojiView *emojiView = [[self alloc] initWithFrame:CGRectMake(0, kMainScreenHeight - GetSLEmojiViewContentHeight(), kMainScreenWidth, GetSLEmojiViewContentHeight())];
    emojiView.didClickEmojiBlock = didClickEmojiBlock;
    emojiView.didClickSendButtonBlock = didClickSendButtonBlock;
    emojiView.didClickDeleteButtonBlock = didClickDeleteButtonBlock;
    return emojiView;
}

#pragma mark - Getter
- (SLEmojiPageCollectionView *)pageCollectionView
{
    if (!_pageCollectionView) {
        _pageCollectionView = [SLEmojiPageCollectionView viewWithFrame:CGRectMake(0, 0, self.width, SLEmojiPageCollectionViewHeight)];
        _pageCollectionView.eventDelegate = self;
    }
    return _pageCollectionView;
}

- (SLEmojiCategoryView *)categoryView
{
    if (!_categoryView) {
        _categoryView = [[SLEmojiCategoryView alloc] initWithFrame:CGRectMake(0, self.height - 40 - KTabbarSafeBottomMargin, self.width, 40)];
        _categoryView.delegate = self;
    }
    return _categoryView;
}

- (UIPageControl *)pageControl
{
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, self.height - 33 - 40 - KTabbarSafeBottomMargin, self.width, 33)];
        _pageControl.currentPage = 0;
        _pageControl.numberOfPages = 0;
        _pageControl.hidesForSinglePage = YES;
        _pageControl.pageIndicatorTintColor = HexRGBAlpha(0xB6B6B6, 1);
        _pageControl.currentPageIndicatorTintColor = HexRGBAlpha(0x47BAFE, 1);
 
    }
    return _pageControl;
}

#pragma mark - setup
- (void)setup
{
    _show = NO;
    _transDistance = GetSLEmojiViewContentHeight();
    _animationDuration = 0.25;
    self.backgroundColor = HexRGBAlpha(0xECEEF1, 1);
    self.windowLevel = UIWindowLevelNormal + 1;

    [self addSubview:self.pageCollectionView];
    [self addSubview:self.pageControl];
    [self addSubview:self.categoryView];
}

#pragma mark - LoadData
- (void)loadData
{
    self.emojiCategories = [NSMutableArray array];
    self.currentIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    
    NSArray *categories = [SLEmojiHelper getAllEmojisCategories];
    [self.emojiCategories addObjectsFromArray:categories];
    
    [self reloadSubViewsData];
}

- (void)reloadSubViewsData
{
    self.pageCollectionView.emojiCategories = self.emojiCategories;
    [self.pageCollectionView reloadData];
    if (self.pageCollectionView.emojiCategories.count > 1) {
        NSIndexPath *indexPath =[NSIndexPath indexPathForRow:0 inSection:1];
        [self.pageCollectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    }

    self.categoryView.emojiCategories = self.emojiCategories;
    [self.categoryView reloadData];
    [self.categoryView selectAtIndex:1];

}

#pragma mark - Control
- (void)setShow:(BOOL)show
{
    if (_show == show) {
        return;
    }
    _show = show;
    
    if (show) {
        [[NSNotificationCenter defaultCenter] postNotificationName:SLEmojiViewWillShowNotification object:nil];
        [self makeKeyAndVisible];
        [UIView animateWithDuration:self.animationDuration animations:^{
            self.top = kMainScreenHeight - self.transDistance;
        } completion:^(BOOL finished) {
        }];
    } else {
        [self resignKeyWindow];
        [PageMgr.getCurrentWindow makeKeyAndVisible];
        [[NSNotificationCenter defaultCenter] postNotificationName:SLEmojiViewWillHideNotification object:nil];
        [UIView animateWithDuration:self.animationDuration animations:^{
            self.top = kMainScreenHeight;
        } completion:^(BOOL finished) {
        }];
    }
}

- (void)setEnableSendButton:(BOOL)enableSendButton
{
    self.categoryView.enableSendButton = enableSendButton;
}

- (BOOL)enableSendButton
{
    return self.categoryView.enableSendButton;
}

- (void)removeFromSuperview
{
    [self resignKeyWindow];
    [super removeFromSuperview];
}

#pragma mark - SLEmojiCategoryViewDelegate
- (void)emojiCategoryView:(SLEmojiCategoryView *)emojiCategoryView didSelectedRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger categoryIndex = indexPath.row;
    [self.pageCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:categoryIndex] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
}

- (void)emojiCategoryView:(SLEmojiCategoryView *)emojiCategoryView didClickSendButton:(UIButton *)sendButton
{
    if ([self.delegate respondsToSelector:@selector(emojiView:didClickSendButton:)]) {
        [self.delegate emojiView:self didClickSendButton:sendButton];
    }
    
    if (self.didClickSendButtonBlock) {
        self.didClickSendButtonBlock(self, sendButton);
    }
}

#pragma mark - SLEmojiPageCollectionViewDelegate
- (void)emojiPageCollectionViewDidClickDeleteButton:(UIButton *)deleteButton
{
    if ([self.delegate respondsToSelector:@selector(emojiView:didClickDeleteButton:)]) {
        [self.delegate emojiView:self didClickDeleteButton:deleteButton];
    }
    
    if (self.didClickDeleteButtonBlock) {
        self.didClickDeleteButtonBlock(self, deleteButton);
    }
}

- (void)emojiPageCollectionViewDidSelectItemWithEmoji:(SLEmoji *)emoji
{
    [[SLEmojiCacheManage sharedManage] setEmojiString:emoji.emojiString];
    SLEmojiCategory *historyCategory = [SLEmojiHelper getRefreshedHistoryCategory];
    [self.emojiCategories replaceObjectAtIndex:0 withObject:historyCategory];

    self.pageCollectionView.emojiCategories = self.emojiCategories;
//    self.categoryView.emojiCategories = self.emojiCategories; // category 没有变，不需要更新
    
    // 在历史表情页，不立即刷新
    if (self.currentIndexPath.section > 0) {
        [self.pageCollectionView reloadSections:[NSIndexSet indexSetWithIndex:0]];
    }
    
    if ([self.delegate respondsToSelector:@selector(emojiView:didClickEmoji:)]) {
        [self.delegate emojiView:self didClickEmoji:emoji];
    }
    
    if (self.didClickEmojiBlock) {
        self.didClickEmojiBlock(self, emoji);
    }
}

- (void)emojiPageCollectionViewDidScrollAtIndexPath:(NSIndexPath *)indexPath
{
    SLEmojiCategory *emojiCagegory = self.emojiCategories[indexPath.section];
    
    if (self.pageControl.numberOfPages != emojiCagegory.pageDataList.count) {
        self.pageControl.alpha = 0.f;
        [UIView animateWithDuration:0.2 animations:^{
            self.pageControl.alpha = 1.f;
        }];
    }
    self.pageControl.numberOfPages = emojiCagegory.pageDataList.count;
    self.pageControl.currentPage = indexPath.row;
   
    if (self.currentIndexPath.section != indexPath.section) {
        [self.categoryView selectAtIndex:indexPath.section];
    }
    self.currentIndexPath = indexPath;
}
@end


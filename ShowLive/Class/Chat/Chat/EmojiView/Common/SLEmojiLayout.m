//
//  SLEmojiLayout.m
//  ShowLive
//
//  Created by Mac on 2018/4/11.
//  Copyright © 2018年 VNing. All rights reserved.
//

#import "SLEmojiLayout.h"
#import "SLEmojiLayoutConst.h"
@interface SLEmojiLayout()

@end

@implementation SLEmojiLayout
- (instancetype)init
{
    self = [super init];
    if (self) {
        _itemSize = CGSizeMake(SLEmojiCollectionViewItemWidth, SLEmojiCollectionViewItemWidth);
        _maxLineCount = SLEmojiCollectionViewMaxLineCount;
        _requriedItemSpacing = SLEmojiCollectionViewRequriedItemSpacing;
    }
    return self;
}

+ (SLEmojiLayout *)layoutWithCollectionSize:(CGSize)collectionSize
{
    SLEmojiLayout *layout = [[self alloc] init];
    
    // 计算横间距
    CGFloat collectionWidth = collectionSize.width;
    NSInteger itemMaxCountOneLine = 5;
    CGFloat itemWidth = layout.itemSize.width;
    CGFloat itemSpacing = (collectionWidth - itemMaxCountOneLine*itemWidth)/(itemMaxCountOneLine-1);
    if (itemSpacing > layout.requriedItemSpacing) {
        while (itemSpacing > layout.requriedItemSpacing) {
            itemMaxCountOneLine++;
            itemSpacing = (collectionWidth - itemMaxCountOneLine*itemWidth)/(itemMaxCountOneLine-1);
        }
        // 减去最后一遍循环多加的
        itemMaxCountOneLine--;
        itemSpacing = (collectionWidth - itemMaxCountOneLine*itemWidth)/(itemMaxCountOneLine-1);
    }
    
    layout.itemSpacing = floor(itemSpacing);
    layout.itemMaxCountOneLine = itemMaxCountOneLine;
    layout.lineSpacing = floor((collectionSize.height - layout.itemSize.height * layout.maxLineCount)/(layout.maxLineCount-1));
    layout.pageMaxItemCount = layout.itemMaxCountOneLine*layout.maxLineCount-1;
    return layout;
}

+ (SLEmojiLayout *)getEmojiLayout
{
    SLEmojiLayout *emojiLayout = [self layoutWithCollectionSize:CGSizeMake(kScreenWidth-SLEmojiCollectionViewMarginPadding*2, SLEmojiCollectionViewHeight)];
    return emojiLayout;
}
@end

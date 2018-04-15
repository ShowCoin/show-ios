//
//  SLEmojiPageCellEmojiView.m
//  ShowLive
//
//  Created by 周华 on 2018/4/11.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "SLEmojiPageCellEmojiView.h"
#import "SLEmojiCollectionCell.h"
#import "SLEmojiLayout.h"
#import "SLEmojiLayoutConst.h"
#import "SLEmoji.h"

#define kEmoji_Tag_Begin 100

@interface SLEmojiPageCellEmojiView()
@property (strong, nonatomic) SLEmojiLayout *layout;

@end
@implementation SLEmojiPageCellEmojiView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createCells];
    }
    return self;
}

- (SLEmojiLayout *)layout
{
    if (!_layout) {
        _layout = [SLEmojiLayout getEmojiLayout];
    }
    return _layout;
}

- (void)createCells
{
    for (NSInteger i = 0; i < self.layout.pageMaxItemCount; i++) {
        NSInteger row = i%self.layout.itemMaxCountOneLine;
        NSInteger section = i/self.layout.itemMaxCountOneLine;
        CGFloat x = (self.layout.itemSize.width + self.layout.itemSpacing) * row;
        CGFloat y = (self.layout.itemSize.height + self.layout.lineSpacing) * section;
        SLEmojiCollectionCell *cell = [[SLEmojiCollectionCell alloc] initWithFrame:CGRectMake(x, y, self.layout.itemSize.width, self.layout.itemSize.height)];
        cell.tag = kEmoji_Tag_Begin+i;
        [self addSubview:cell];
    }
}

- (void)setEmojiCollectionViewDidSelectItemWithEmoji:(void (^)(SLEmoji *))emojiCollectionViewDidSelectItemWithEmoji
{
    for (NSInteger i = 0; i < self.layout.pageMaxItemCount; i++) {
        SLEmojiCollectionCell *cell = [self viewWithTag:kEmoji_Tag_Begin+i];
        cell.emojiButtonClick = emojiCollectionViewDidSelectItemWithEmoji;
    }
}

- (void)setEmojis:(NSArray<SLEmoji *> *)emojis
{
    _emojis = emojis;
    for (NSInteger i = 0; i < self.layout.pageMaxItemCount; i++) {
        SLEmojiCollectionCell *cell = [self viewWithTag:kEmoji_Tag_Begin+i];
        if (i < _emojis.count) {
            cell.emoji = _emojis[i];            
            cell.hidden = NO;
        } else {
            cell.hidden = YES;
        }
    }
}

@end

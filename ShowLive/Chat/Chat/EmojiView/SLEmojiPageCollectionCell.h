//
//  SLEmojiPageCollectionCell.h
//  ShowLive
//
//  Created by 周华 on 2018/4/11.
//  Copyright © 2018年 vning. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SLEmoji;
@class SLEmojiPageData;

@interface SLEmojiPageCollectionCell : UICollectionViewCell

@property (strong, nonatomic) SLEmojiPageData *pageData;
@property (copy, nonatomic) void (^didClickDeleteButton)(UIButton *deleteButton);
@property (copy, nonatomic) void (^emojiCollectionViewDidSelectItemWithEmoji)(SLEmoji *emoji);

@end

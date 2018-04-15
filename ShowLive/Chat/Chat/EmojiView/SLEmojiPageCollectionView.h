//
//  SLEmojiPageCollectionView.h
//  ShowLive
//
//  Created by 周华 on 2018/4/11.
//  Copyright © 2018年 vning. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SLEmojiCategory.h"

@protocol SLEmojiPageCollectionViewDelegate <NSObject>
- (void)emojiPageCollectionViewDidClickDeleteButton:(UIButton *)deleteButton;
- (void)emojiPageCollectionViewDidSelectItemWithEmoji:(SLEmoji *)emoji;
- (void)emojiPageCollectionViewDidScrollAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface SLEmojiPageCollectionView : UICollectionView

@property (strong, nonatomic) NSArray<SLEmojiCategory *> *emojiCategories;
@property (weak, nonatomic) id<SLEmojiPageCollectionViewDelegate> eventDelegate;

+ (instancetype)viewWithFrame:(CGRect)frame;

@end

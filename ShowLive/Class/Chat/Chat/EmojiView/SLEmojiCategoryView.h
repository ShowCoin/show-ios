//
//  SLEmojiCategoryView.h
//  ShowLive
//
//  Created by Mac on 2018/4/11.
//  Copyright © 2018年 VNing. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SLEmojiCategoryView;
@protocol SLEmojiCategoryViewDelegate <NSObject>
- (void)emojiCategoryView:(SLEmojiCategoryView *)emojiCategoryView didSelectedRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)emojiCategoryView:(SLEmojiCategoryView *)emojiCategoryView didClickSendButton:(UIButton *)sendButton;
@end

@class SLEmojiCategory;
@interface SLEmojiCategoryView : UIView
@property (strong, nonatomic) NSArray<SLEmojiCategory *> *emojiCategories;
@property (weak, nonatomic) id<SLEmojiCategoryViewDelegate> delegate;
@property (assign, nonatomic) BOOL enableSendButton;

- (void)selectAtIndex:(NSInteger)index;
- (void)reloadData;
@end

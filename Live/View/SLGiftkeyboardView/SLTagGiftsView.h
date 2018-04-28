//
//  SLTagGiftsView.h
//  ShowLive
//
//  Created by gongxin on 2018/4/16.
//  Copyright © 2018年 vning. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SLGiftListModel;

@protocol SLTagGiftsViewDelegate <NSObject>

@optional

- (void)selectedGift:(id)sender;

@end

@interface SLTagGiftsView : UIView

@property (nonatomic,weak) id<SLTagGiftsViewDelegate> delegate;


- (void)refreshUI:(SLLiveListModel *)model;

@end

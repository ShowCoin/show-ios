//
//  SLGiftButtonView.h
//  ShowLive
//
//  Created by gongxin on 2018/4/16.
//  Copyright © 2018年 vning. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SLGiftListModel.h"


@protocol SLGiftButtonViewDelegeate <NSObject>

@optional

- (void)selectedGift:(id)sender;

@end

@interface SLGiftButtonView : UIView

/**
 代理
 */
@property (nonatomic, weak) id <SLGiftButtonViewDelegeate> delegate;

/**
 是否选中
 */
@property (nonatomic, assign) BOOL isSelected;

/**
 礼物模型
 */
@property (strong, nonatomic) SLGiftListModel *giftModel;

/**
 初始化礼物按钮
 
 @param frame frame
 @param model 礼物模型
 
 @return 实例
 */
-(instancetype)initWithFrame:(CGRect)frame infoModel:(SLGiftListModel*)model;

- (void)setNum:(NSInteger)num;

@end

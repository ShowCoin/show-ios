//
//  SLSmallGiftView.h
//  ShowLive
//
//  Created by WorkNew on 2018/4/17.
//  Copyright © 2018年 VNing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SLReceivedGiftModel.h"

typedef void(^SLDoubleClickFinish)(BOOL finished); // 礼物连击结束回调

typedef void(^SLShakeFinish)(BOOL finished); // 礼物数字跳动动画结束回调


@interface SLSmallGiftView : UIView

@property (nonatomic, copy) SLDoubleClickFinish finishCb; //结束回调
@property (nonatomic, copy) SLShakeFinish shakeFinishCb; //礼物数字跳动动画结束回调

@property (nonatomic, assign, readonly) BOOL isShow; // 是否在展示

/**
 初始化视图
 
 @param frame frame
 
 @return 返回一个试图实例
 */
- (instancetype)initWithFrame:(CGRect)frame;

/**
 显示礼物视图
 
 @param giftModel 礼物数据模型
 */
- (void)showGiftWithModel:(SLReceivedGiftModel *)giftModel;

@end

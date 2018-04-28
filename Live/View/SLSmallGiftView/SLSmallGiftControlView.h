//
//  SLSmallGiftControlView.h
//  ShowLive
//
//  Created by WorkNew on 2018/4/17.
//  Copyright © 2018年 VNing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SLReceivedGiftModel.h"

@interface SLSmallGiftControlView : UIView

/**
 初始化视图
 
 @param frame frame
 
 @return 返回一个试图实例
 */
- (instancetype)initWithFrame:(CGRect)frame;


/**
 添加礼物模型
 
 @param model 礼物模型
 */
- (void)addGift2QueueWithModel:(SLReceivedGiftModel*)model;

@end

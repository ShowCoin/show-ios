//
//  SLComboButton.h
//  ShowLive
//
//  Created by WorkNew on 2018/4/16.
//  Copyright © 2018年 VNing. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^SLComboButtonEvent)(void);
@interface SLComboButton : UIView

/**
 连击button 点击回调
 */
@property (nonatomic, copy) SLComboButtonEvent clickBlock;


/**
 点击完成回调
 */
@property (nonatomic, copy) SLComboButtonEvent finishBlock;


/**
 显示
 */
- (void)show;


/**
 隐藏
 */
- (void)hide;
@end

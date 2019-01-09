//
//  SLRPLabel.h
//  ShowLive
//
//  Created by chenyh on 2018/8/9.
//  Copyright © 2018年 vning. All rights reserved.
//

#import <UIKit/UIKit.h>

UIKIT_EXTERN CGFloat const kRPMaskLRMargin;
/// 获取 mask label 大小
FOUNDATION_EXPORT CGSize SLFuncGetRPLabelSize(UILabel *label);

@interface SLRPLabel : UILabel
/// 是否显示背景遮罩
@property (nonatomic, assign) BOOL showMask;
/// 字体加阴影
@property (nonatomic, assign) BOOL showShadow;

@end

/// 带颜色边框的字体label
@interface SLRPShadowLabel : UILabel

@property (nonatomic, strong) UIColor *borderColor;

@end

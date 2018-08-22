//
//  SLQRScanViewController.h
//  Edu
//
//  Created by chenyh on 2018/8/8.
//  Copyright © 2018年 chuxia. All rights reserved.
//

#import <UIKit/UIKit.h>

UIKIT_EXTERN NSString * const kInviteCodePrefix;

@interface SLQRScanViewController : BaseViewController

@property (nonatomic, copy) SLOneBlock scanBlock;

@end

@interface SLQRScanView : UIView

/// 扫描区大小
@property (nonatomic, assign) CGRect scanRect;
/// 四个角的lineWidth lineHeight
@property (nonatomic, assign) CGSize size;
/// 四个角的线颜色
@property (nonatomic, strong) UIColor *cornerLineColor;
/// 边框线颜色
@property (nonatomic, strong) UIColor *borderColor;

@end

@interface SLQRBottomView : UIView

@property (nonatomic, strong) id target;

@end

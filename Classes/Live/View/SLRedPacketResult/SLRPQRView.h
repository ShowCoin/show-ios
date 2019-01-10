//
//  SLRPQRView.h
//  ShowLive
//
//  Created by chenyh on 2018/9/25.
//  Copyright © 2018年 vning. All rights reserved.
//

#import <UIKit/UIKit.h>

UIKIT_EXTERN CGFloat const kQRViewWH;

NS_ASSUME_NONNULL_BEGIN

@interface SLRPQRView : UIView

@property (nonatomic, strong, readonly) UILabel *showLabel;
@property (nonatomic, strong, readonly) UIImageView *qrView;

@end

NS_ASSUME_NONNULL_END

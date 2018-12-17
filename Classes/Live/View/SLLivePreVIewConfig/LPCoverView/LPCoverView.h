//
//  LPCoverView.h
//  Edu
//
//  Created by chenyh on 2018/9/19.
//  Copyright © 2018年 chuxia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LPConfigHeader.h"

NS_ASSUME_NONNULL_BEGIN

@interface LPCoverView : UIView

@property (nonatomic, strong, readonly) UIImageView *imageView;

@property (nonatomic, strong) NSString *coverUrl;

@property (nonatomic, copy) SLSimpleBlock changeCoverBlock;

/// 更新标题
- (void)sl_updateTitle:(NSString *)text;
/// 更新观众分成
- (void)sl_updateWatch:(NSString *)text;
/// 更新 show 总数
- (void)sl_updateCoin:(NSString *)text;
/// 放大
- (void)sl_showShare;

/// subclass use
- (void)sl_shareConfig;

@end

NS_ASSUME_NONNULL_END

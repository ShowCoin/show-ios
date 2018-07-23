//
//  UIImage+MSVagueEffect.h
//  MyShowFoundation
//
//  Created by JingZhongJie on 16/5/13.
//  Copyright © 2016年 Beijing JinHangZhuoLe Network Technology Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (MSVagueEffect)

- (UIImage *)applyLightEffect;
- (UIImage *)applyExtraLightEffect;
- (UIImage *)applyDarkEffect;
- (UIImage *)applyClearEffect;
- (UIImage *)applyClear1Effect;

- (UIImage *)applyTintEffectWithColor:(UIColor *)tintColor;

@end

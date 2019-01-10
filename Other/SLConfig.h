//
//  SLConfig.h
//  ShowLive
//
//  Created by chenyh on 2018/5/25.
//  Copyright © 2018年 vning. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^SLSimpleBlock)(void);
typedef void(^SLOneBlock)(id);
typedef void(^SLIntBlock)(NSInteger);

UIKIT_EXTERN NSTimeInterval const kHomeHeaderAniDelay;
UIKIT_EXTERN NSTimeInterval const kHomeLeftAniDelay;
UIKIT_EXTERN NSTimeInterval const kHomeRightAniDelay;
UIKIT_EXTERN CGFloat const kTitleViewH;
UIKIT_EXTERN CGFloat const kMargin10;

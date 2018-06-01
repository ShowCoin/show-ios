//
//  SLMoreActionView.h
//  Animation
//
//  Created by 陈英豪 on 2018/5/28.
//  Copyright © 2018年 chuxia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SLPauseView.h"
#import "SLVerticalButton.h"

UIKIT_EXTERN CGFloat const kSLMoreActionViewH;

@interface SLMoreActionView : SLBaseModalView

@property (nonatomic, copy) SLIntBlock clickBlock;

@end


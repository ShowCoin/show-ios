//
//  SLPauseView.h
//  Animation
//
//  Created by 陈英豪 on 2018/5/27.
//  Copyright © 2018年 chuxia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SLPauseView : UIView

@property (nonatomic, copy) SLSimpleBlock hiddenBlock;

+ (instancetype)shared;

- (void)show:(BOOL)isShow;

@end

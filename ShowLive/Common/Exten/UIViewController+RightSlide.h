//
//  UIViewController+RightSlide.h
//  ShowLive
//
//  Created by 周华 on 2018/4/6.
//  Copyright © 2018年 vning. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (RightSlide)<UIGestureRecognizerDelegate>
@property (nonatomic,strong) UIView *maskView;
@property (nonatomic,assign) BOOL isOpen;

-(void)show;
-(void)hide;
-(void)initSlideFoundation;

@end

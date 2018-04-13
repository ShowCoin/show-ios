//
//  RootViewController.h
//  ShowLive
//
//  Created by 周华 on 2018/4/10.
//  Copyright © 2018年 vning. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootViewController : UIViewController
@property (nonatomic, strong) BaseTabBarController *  tabBarController;
@property (nonatomic, strong) UINavigationController *recordNavController;
// 是否开启多个手势识别，默认NO,对于一些需要左滑删除等手势的controller，可设置为YES
@property (assign, nonatomic) BOOL enableSimultaneouslyGesture;

@end

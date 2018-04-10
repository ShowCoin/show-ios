//
//  ShowTabBar.h
//  ShowLive
//
//  Created by zhangxinggong on 2018/3/29.
//  Copyright © 2018年 vning. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,MyTabelBarStyle) {
   MyTabelBarStyle_Text = 1 ,
   MyTabelBarStyle_Button = 2
};

@class ShowTabBar;

@protocol ShowTabBarDelegate<NSObject>

-(void)addButtonClick:(ShowTabBar *)tabBar;

@end

@interface ShowTabBar : UITabBar

@property (nonatomic,weak) id<ShowTabBarDelegate> myTabBarDelegate;

@property (nonatomic,weak) UIButton *addButton;
@property (nonatomic,weak) UILabel *addLabel;

- (instancetype)initWithFrame:(CGRect)frame Style:(MyTabelBarStyle)style ;

@end

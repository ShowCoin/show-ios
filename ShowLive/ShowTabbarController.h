//
//  ShowTabbarController.h
//  ShowLive
//
//  Created by zhangxinggong on 2018/3/29.
//  Copyright © 2018年 vning. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, BaseTabBarControllerIndexType) {
    BaseTabBarControllerIndexTypeHome = 0,
    BaseTabBarControllerIndexTypeCircle,
    BaseTabBarControllerIndexTypeMessage,
    BaseTabBarControllerIndexTypeUserCenter
};

@interface ShowTabbarController : UITabBarController<UITabBarControllerDelegate,UIAlertViewDelegate>

@property (nonatomic,assign)NSInteger seeuMsgUnreadCount;    //消息页官方消息未读数量

+(instancetype)shareTabBarController;

-(void)setTabBarSelectedIndex:(BaseTabBarControllerIndexType)index;

-(void)showOrderRedDocWithCount:(NSInteger)count;

-(NSArray *)tabBarTopController;

@end

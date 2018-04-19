//
//  BaseTabBarController.h
//  ShowLive
//
//  Created by iori_chou on 18/4/1.
//  Copyright © 2018年 show. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, BaseTabBarControllerIndexType) {
    BaseTabBarControllerIndexTypeHome = 0,
    BaseTabBarControllerIndexTypeCircle,
    BaseTabBarControllerIndexTypeMessage,
    BaseTabBarControllerIndexTypeUserCenter
};


@interface BaseTabBarController : UITabBarController<UITabBarControllerDelegate,UIAlertViewDelegate>

@property (nonatomic,assign)NSInteger slMsgUnreadCount;    //消息页官方消息未读数量

+(instancetype)shareTabBarController;

-(void)setTabBarSelectedIndex:(BaseTabBarControllerIndexType)index;

-(void)showOrderRedDocWithCount:(NSInteger)count;

-(NSArray *)tabBarTopController;

@end


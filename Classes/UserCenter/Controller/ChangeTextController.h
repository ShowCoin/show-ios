//
//  ChangeTextController.h
//  ShowLive
//
//  Created by vning on 2018/4/6.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "BaseViewController.h"
typedef NS_ENUM(NSInteger,textViewType) {//列样式
    textViewType_name  = 1,
    textViewType_city  = 2,
    textViewType_sign  = 3,
};

typedef void (^inputblock)(NSString * changeText);

@interface ChangeTextController : BaseViewController<UIAlertViewDelegate>
@property(strong,nonatomic)NSString * navtitle;
@property (nonatomic, copy)inputblock block;
@property (nonatomic, assign)textViewType type;

@end

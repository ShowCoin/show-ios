//
//  ChangeTextController.h
//  ShowLive
//
//  Created by vning on 2018/4/6.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "BaseViewController.h"
typedef NS_ENUM(NSInteger,textViewType) {//列样式
    textViewType_name  = 1, //名字
    textViewType_city  = 2, //城市
    textViewType_sign  = 3, //签名
};

typedef void (^inputblock)(NSString * changeText);

@interface ChangeTextController : BaseViewController<UIAlertViewDelegate>
//标题
@property(strong,nonatomic)NSString * navtitle;
//回调
@property (nonatomic, copy)inputblock block;
//类型
@property (nonatomic, assign)textViewType type;

@end

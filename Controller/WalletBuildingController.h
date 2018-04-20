//
//  WalletBuildingController.h
//  ShowLive
//
//  Created by vning on 2018/4/4.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "BaseViewController.h"

@interface WalletBuildingController : BaseViewController<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,copy)NSString * password;
@property (nonatomic,copy)NSString * nickName;

@end

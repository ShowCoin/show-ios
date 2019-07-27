//
//  ShowAccountViewController.h
//  ShowLive
//
//  Created by 周华 on 2018/3/29.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "BaseViewController.h"

@interface ShowAccountViewController : BaseViewController

@property (nonatomic, copy) NSString *address;
@property (nonatomic, strong) ShowUserModel *user;
@property (nonatomic, assign) BOOL Stored;

@end

//
//  SLWalletHomePageViewController.h
//  ShowLive
//
//  Created by vning on 2018/10/11.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface SLWalletHomePageViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) ShowUserModel *user;
@property (nonatomic, strong) UIView *naviView;




@end

NS_ASSUME_NONNULL_END

//
//  CoinDetailVC.h
//  ShowLive
//
//  Created by zhangxinggong on 2018/4/2.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "BaseTableVC.h"
#import "SLWalletModel.h"


@interface CoinDetailVC : BaseTableVC


@property (nonatomic, strong) SLWalletCoinModel *walletModel;
@property (nonatomic, strong) ShowUserModel *user;

@end

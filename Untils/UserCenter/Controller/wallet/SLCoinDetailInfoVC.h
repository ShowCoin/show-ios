//
//  SLCoinDetailInfoVC.h
//  ShowLive
//
//  Created by vning on 2018/5/4.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "BaseViewController.h"
#import "TransactionRecordsModel.h"
@interface SLCoinDetailInfoVC : BaseViewController
@property (nonatomic, strong)TransactionRecordsModel * tModel;
@property (nonatomic, strong) ShowUserModel *user;
@property (nonatomic, strong) SLWalletCoinModel *walletModel;

@end

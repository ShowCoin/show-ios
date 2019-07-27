//
//  ShowAccountTableHeader.h
//  ShowLive
//
//  Created by iori_chou on 2018/4/2.
//  Copyright © 2018年 vning. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SLWalletModel.h"

@interface ShowAccountTableHeader : UIView
@property (nonatomic, strong) UILabel *  coinNumLabel;
@property (nonatomic, strong) UILabel *  RmbNumLabel;
@property (nonatomic, strong)SLWalletCoinModel * walletModel;
@property (nonatomic, strong) ShowUserModel *user;

@end

//
//  ShowAccountHead.h
//  ShowLive
//
//  Created by iori_chou on 2018/3/29.
//  Copyright © 2018年 vning. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SLWalletModel.h"
@interface ShowAccountHead : UIView
@property (nonatomic, strong) UILabel *  exchangeLabel;
@property (nonatomic, strong)SLWalletModel * walletModel;
@property (nonatomic, strong) ShowUserModel *user;

@end

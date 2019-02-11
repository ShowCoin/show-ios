//
//  WithdrawViewController.h
//  ShowLive
//
//  Created by vning on 2018/4/3.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "BaseViewController.h"
#import "SLWithdrawAction.h"
#import "SLWithdrawFeeAction.h"
@interface WithdrawViewController : BaseViewController<UITextFieldDelegate,UIGestureRecognizerDelegate>
@property(nonatomic,strong)SLWithdrawAction * withdrawAction;
@property (nonatomic, strong) ShowUserModel *user;
@property (nonatomic, strong) SLWalletCoinModel *walletModel;

@end

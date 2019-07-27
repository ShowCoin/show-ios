//
//  SLWithdrawAlert.h
//  ShowLive
//
//  Created by vning on 2018/7/10.
//  Copyright © 2018年 vning. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SLWithdrawAlertDelegate <NSObject>

- (void)SLWithdrawAlertCancelClick;

- (void)SLWithdrawAlertsureClick;

- (void)SLWithdrawGoToPhoneVC;
- (void)SLWithdrawGoToKYC;
- (void)SLWithdrawGoToSecret;

@end

@interface SLWithdrawAlert : UIView<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, weak) id<SLWithdrawAlertDelegate> delegate;

@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UIView *mainView;

@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UITableView *TabelView;
@property (nonatomic, strong) UIButton *closeBtn;
@property (nonatomic, strong) UIButton *sureBtn;

+ (instancetype)authView;
- (void)checkSafeStatue;

@end

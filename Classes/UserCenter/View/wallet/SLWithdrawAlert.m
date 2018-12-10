//
//  SLWithdrawAlert.m
//  ShowLive
//
//  Created by vning on 2018/7/10.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "SLWithdrawAlert.h"
#import "SLWithDrawIndentifyCell.h"
#import "SLPhoneBindVC.h"

@interface SLWithdrawAlert ()
@property(assign,nonatomic)BOOL  PhoneSafe;
@property(assign,nonatomic)BOOL  KYCSafe;
@property(assign,nonatomic)BOOL  secretSafe;
@end

@implementation SLWithdrawAlert

+ (instancetype)authView
{
    SLWithdrawAlert * view = [[SLWithdrawAlert alloc]initWithFrame:CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight)];
    return view;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self checkSafeStatue];
        [self setupViews];
    }
    return self;
}
- (void)checkSafeStatue
{
    if (IsValidString([AccountModel shared].phoneNumber)) {
        _PhoneSafe = YES;
    }else{
        _PhoneSafe = NO;
    }
    
    if (AccountUserInfoModel.authStatus.integerValue == 3) {
        _KYCSafe = YES;
    } else {
        _KYCSafe = NO;
    }
    if (AccountUserInfoModel.is_cashPassword.integerValue == 1) {
        _secretSafe = YES;
    } else {
        _secretSafe = NO;
    }
    if (_PhoneSafe&&_KYCSafe&&_secretSafe) {
        [self performSelector:@selector(cancelClick) withObject:nil afterDelay:0.5];
//        [self cancelClick];
    }
}
- (void)setupViews{
    _backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight)];
    _backView.backgroundColor = HexRGBAlpha(0x000000, 0.5);
    [self addSubview:_backView];
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancelClick)];
    [_backView addGestureRecognizer:tap];
    
    _mainView = [[UIView alloc] initWithFrame:CGRectMake(58*Proportion375, 163*Proportion375, 253*Proportion375, 300*Proportion375)];
    _mainView.userInteractionEnabled = YES;
    _mainView.centerY = kMainScreenHeight/2;
    _mainView.layer.cornerRadius = 6*Proportion375;
    _mainView.layer.masksToBounds = YES;
    _mainView.clipsToBounds = YES;
    _mainView.userInteractionEnabled = YES;
    [_mainView setBackgroundColor:kThemeWhiteColor];
    [self addSubview:_mainView];
    
    _titleLab = [[UILabel alloc] initWithFrame:CGRectMake(35*Proportion375, 0*Proportion375, 100*Proportion375, 60*Proportion375)];
    _titleLab.font = Font_Medium(18*WScale);
    _titleLab.textColor = kthemeBlackColor;
    _titleLab.textAlignment = NSTextAlignmentCenter;
    _titleLab.text = @"安全设置";
    _titleLab.centerX = 253/2*Proportion375;
    [_mainView addSubview:_titleLab];

    _TabelView = [[UITableView alloc] initWithFrame:CGRectMake(0, 60*Proportion375, _mainView.width, 180*Proportion375)];
    _TabelView.delegate = self;
    _TabelView.dataSource = self;
    _TabelView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _TabelView.scrollEnabled = NO;
    [_mainView addSubview:_TabelView];

    UIView * line = [[UIView alloc] initWithFrame:CGRectMake(0, 59*Proportion375, _mainView.width, 1*Proportion375)];
    line.backgroundColor = kGrayWithd7d7d7;
    [_mainView addSubview:line];
    
    _closeBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 253/2*Proportion375, 60*Proportion375)];
    _closeBtn.left = 0;
    _closeBtn.centerY = _TabelView.bottom + 30*Proportion375;
//    _closeBtn.layer.cornerRadius = 35*Proportion375/2;
//    _closeBtn.clipsToBounds = YES;
    [_closeBtn setTitle:@"取消" forState:UIControlStateNormal];
    [_closeBtn setTitleColor:kthemeBlackColor forState:UIControlStateNormal];
    _closeBtn.titleLabel.font = Font_Medium(17*Proportion375);
//    [_closeBtn setBackgroundColor:kGrayWithdddddd forState:UIControlStateNormal];
//    [_closeBtn setImage:adImage forState:UIControlStateNormal];
    [_closeBtn addTarget:self action:@selector(cancelClick) forControlEvents:UIControlEventTouchUpInside];
    [_mainView addSubview:_closeBtn];
    
    _sureBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 253/2*Proportion375, 60*Proportion375)];
    _sureBtn.right = 253*Proportion375;
    _sureBtn.centerY = _TabelView.bottom + 30*Proportion375;
//    _sureBtn.layer.cornerRadius = 35*Proportion375/2;
//    _sureBtn.clipsToBounds = YES;
    [_sureBtn setTitle:@"设置" forState:UIControlStateNormal];
    [_sureBtn setTitleColor:kthemeBlackColor forState:UIControlStateNormal];
    _sureBtn.titleLabel.font = Font_Medium(17*Proportion375);
//    [_sureBtn setBackgroundColor:kThemeRedColor forState:UIControlStateNormal];
//    [_sureBtn setImage:adImage forState:UIControlStateNormal];
    [_sureBtn addTarget:self action:@selector(sureClick) forControlEvents:UIControlEventTouchUpInside];
    [_mainView addSubview:_sureBtn];
    
    UIView * sline = [[UIView alloc] initWithFrame:CGRectMake(253/2*Proportion375, _sureBtn.top, 1*Proportion375, 60*Proportion375)];
    sline.backgroundColor = kGrayWithd7d7d7;
    [_mainView addSubview:sline];
//    [[_sureBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
//
//    }];

}
- (void)setupAnimation {
    self.mainView.transform = CGAffineTransformMakeScale(0.0, 0.0);
    __weak SLWithdrawAlert *weakSelf = self;
    [UIView animateWithDuration:0.55 delay:0.2 usingSpringWithDamping:0.7 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        weakSelf.mainView.transform = CGAffineTransformMakeScale(1.0, 1.0);
    } completion:^(BOOL finished) {
        weakSelf.mainView.frame = CGRectMake(58*Proportion375, 163*Proportion375, 250*Proportion375, 300*Proportion375);
    }];
}
- (void)cancelClick {
    __weak SLWithdrawAlert *weakSelf = self;
    [UIView animateWithDuration:0.25 delay:0.1 usingSpringWithDamping:1.0 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        weakSelf.mainView.alpha = 0.0;
    } completion:^(BOOL finished) {
        if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(SLWithdrawAlertCancelClick)]) {
            [weakSelf.delegate SLWithdrawAlertCancelClick];
        }
    }];
}
- (void)sureClick {
//    if (UserProfile.isTourist) {
//        [PageMgr presentLoginViewController];
//        return;
//    }
    
    if (!_PhoneSafe) {//没手机
        [self.delegate SLWithdrawGoToPhoneVC];
    }else if (AccountUserInfoModel.authStatus.integerValue == 1 || AccountUserInfoModel.authStatus.integerValue == 4){//没KYC
        [self.delegate SLWithdrawGoToKYC];

    }else if (!_secretSafe){//没资金密码
        [self.delegate SLWithdrawGoToSecret];

    }else{//都完成
        __weak SLWithdrawAlert *weakSelf = self;
        [UIView animateWithDuration:0.25 delay:0.0 usingSpringWithDamping:1.0 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            weakSelf.mainView.alpha = 0.0;
        } completion:^(BOOL finished) {
            if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(SLWithdrawAlertsureClick)]) {
                [weakSelf.delegate SLWithdrawAlertsureClick];
            }
        }];
    }
}


//tableview
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60*Proportion375;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SLWithDrawIndentifyCell * Cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!Cell) {
        Cell = [[SLWithDrawIndentifyCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        Cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    switch (indexPath.row) {//title
        case 0:{
            Cell.titleLab.text = @"手机绑定";
        }
            break;
        case 1:{
            Cell.titleLab.text = @"KYC认证";
        }
            break;
        case 2:{
            Cell.titleLab.text = @"资金密码";

        }
            break;
            
        default:
            break;
    }
    Cell.userInteractionEnabled = NO;
    if (_PhoneSafe) {//手机绑定完成
        if (AccountUserInfoModel.authStatus.integerValue == 3) {//kyc完成
            if (_secretSafe) {//自己密码完成    （非正常情况）
                switch (indexPath.row) {//完成-完成-完成
                    case 0:{
                        Cell.statueLab.text = @"已完成";
                        Cell.statueLab.textColor = kthemeBlackColor;
                        Cell.contentView.backgroundColor = kThemeWhiteColor;
                        Cell.arrowIma.hidden = YES;
                    }
                        break;
                    case 1:{
                        Cell.statueLab.text = @"已完成";
                        Cell.statueLab.textColor = kthemeBlackColor;
                        Cell.contentView.backgroundColor = kThemeWhiteColor;
                        Cell.arrowIma.hidden = YES;

                    }
                        break;
                    case 2:{
                        Cell.statueLab.text = @"已完成";
                        Cell.statueLab.textColor = kthemeBlackColor;
                        Cell.contentView.backgroundColor = kThemeWhiteColor;
                        Cell.arrowIma.hidden = YES;

                    }

                        break;
                        
                    default:
                        break;
                }
            } else {//资金密码未完成
                switch (indexPath.row) {//完成-完成-未完成
                    case 0:{
                        Cell.statueLab.text = @"已完成";
                        Cell.statueLab.textColor = kthemeBlackColor;
                        Cell.contentView.backgroundColor = kThemeWhiteColor;
                        Cell.arrowIma.hidden = YES;

                    }
                        break;
                    case 1:{
                        Cell.statueLab.text = @"已完成";
                        Cell.statueLab.textColor = kthemeBlackColor;
                        Cell.contentView.backgroundColor = kThemeWhiteColor;
                        Cell.arrowIma.hidden = YES;

                    }
                        break;
                    case 2:{
                        Cell.statueLab.text = @"未设置";
                        Cell.statueLab.textColor = kthemeBlackColor;
                        Cell.contentView.backgroundColor = kBlackThemetextColor;
                        Cell.arrowIma.hidden = NO;
                        Cell.userInteractionEnabled = YES;
                    }
                        break;
                        
                    default:
                        break;
                }
            }
        }else if (AccountUserInfoModel.authStatus.integerValue == 2){//kyc认证中
            if (_secretSafe) {//资金密码完成
                switch (indexPath.row) {//完成-中-完成
                    case 0:{
                        Cell.statueLab.text = @"已完成";
                        Cell.statueLab.textColor = kthemeBlackColor;
                        Cell.contentView.backgroundColor = kThemeWhiteColor;
                        Cell.arrowIma.hidden = YES;

                    }
                        break;
                    case 1:{
                        Cell.statueLab.text = @"审核中";
                        Cell.statueLab.textColor = kThemeRedColor;
                        Cell.contentView.backgroundColor = kBlackThemetextColor;
                        Cell.arrowIma.hidden = YES;
                        Cell.userInteractionEnabled = YES;
                    }
                        break;
                    case 2:{
                        Cell.statueLab.text = @"已完成";
                        Cell.statueLab.textColor = kthemeBlackColor;
                        Cell.contentView.backgroundColor = kThemeWhiteColor;
                        Cell.arrowIma.hidden = YES;

                    }
                        break;
                        
                    default:
                        break;
                }
            } else {//资金密码未完成
                switch (indexPath.row) {//完成-中-未完成
                    case 0:{
                        Cell.statueLab.text = @"已完成";
                        Cell.statueLab.textColor = kthemeBlackColor;
                        Cell.contentView.backgroundColor = kThemeWhiteColor;
                        Cell.arrowIma.hidden = YES;

                    }
                        break;
                    case 1:{
                        Cell.statueLab.text = @"审核中";
                        Cell.statueLab.textColor = kThemeRedColor;
                        Cell.contentView.backgroundColor = kThemeWhiteColor;
                        Cell.arrowIma.hidden = YES;

                    }
                        break;
                    case 2:{
                        Cell.statueLab.text = @"未设置";
                        Cell.statueLab.textColor = kthemeBlackColor;
                        Cell.contentView.backgroundColor = kBlackThemetextColor;
                        Cell.arrowIma.hidden = NO;
                        Cell.userInteractionEnabled = YES;
                    }
                        break;
                        
                    default:
                        break;
                }
            }
        } else if (AccountUserInfoModel.authStatus.integerValue == 1){//kyc未认证
            if (_secretSafe) {//资金密码完成
                switch (indexPath.row) {//完成-未完成-完成
                    case 0:{
                        Cell.statueLab.text = @"已完成";
                        Cell.statueLab.textColor = kthemeBlackColor;
                        Cell.contentView.backgroundColor = kThemeWhiteColor;
                        Cell.arrowIma.hidden = YES;

                    }
                        break;
                    case 1:{
                        Cell.statueLab.text = @"未设置";
                        Cell.statueLab.textColor = kthemeBlackColor;
                        Cell.contentView.backgroundColor = kBlackThemetextColor;
                        Cell.arrowIma.hidden = NO;
                        Cell.userInteractionEnabled = YES;
                    }
                        break;
                    case 2:{
                        Cell.statueLab.text = @"已完成";
                        Cell.statueLab.textColor = kthemeBlackColor;
                        Cell.contentView.backgroundColor = kThemeWhiteColor;
                        Cell.arrowIma.hidden = YES;

                    }
                        break;
                        
                    default:
                        break;
                }
            } else {//资金密码未完成
                switch (indexPath.row) {//完成-未完成-未完成
                    case 0:{
                        Cell.statueLab.text = @"已完成";
                        Cell.statueLab.textColor = kthemeBlackColor;
                        Cell.contentView.backgroundColor = kThemeWhiteColor;
                        Cell.arrowIma.hidden = YES;

                    }
                        break;
                    case 1:{
                        Cell.statueLab.text = @"未设置";
                        Cell.statueLab.textColor = kthemeBlackColor;
                        Cell.contentView.backgroundColor = kBlackThemetextColor;
                        Cell.arrowIma.hidden = NO;
                        Cell.userInteractionEnabled = YES;
                    }
                        break;
                    case 2:{
                        Cell.statueLab.text = @"未完成";
                        Cell.statueLab.textColor = kthemeBlackColor;
                        Cell.contentView.backgroundColor = kThemeWhiteColor;
                        Cell.arrowIma.hidden = YES;

                    }
                        break;
                        
                    default:
                        break;
                }
            }
        }else{
            //kyc认证失败
                if (_secretSafe) {//资金密码完成
                    switch (indexPath.row) {//完成-失败-完成
                        case 0:{
                            Cell.statueLab.text = @"已完成";
                            Cell.statueLab.textColor = kthemeBlackColor;
                            Cell.contentView.backgroundColor = kThemeWhiteColor;
                            Cell.arrowIma.hidden = YES;

                        }
                            break;
                        case 1:{
                            Cell.statueLab.text = @"失败";
                            Cell.statueLab.textColor = kThemeRedColor;
                            Cell.contentView.backgroundColor = kBlackThemetextColor;
                            Cell.arrowIma.hidden = NO;
                            Cell.userInteractionEnabled = YES;
                        }
                            break;
                        case 2:{
                            Cell.statueLab.text = @"已完成";
                            Cell.statueLab.textColor = kthemeBlackColor;
                            Cell.contentView.backgroundColor = kThemeWhiteColor;
                            Cell.arrowIma.hidden = YES;

                        }
                            break;
                            
                        default:
                            break;
                    }
                } else {//资金密码未完成
                    switch (indexPath.row) {//完成-失败-未完成
                        case 0:{
                            Cell.statueLab.text = @"已完成";
                            Cell.statueLab.textColor = kthemeBlackColor;
                            Cell.contentView.backgroundColor = kThemeWhiteColor;
                            Cell.arrowIma.hidden = YES;

                        }
                            break;
                        case 1:{
                            Cell.statueLab.text = @"失败";
                            Cell.statueLab.textColor = kThemeRedColor;
                            Cell.contentView.backgroundColor = kBlackThemetextColor;
                            Cell.arrowIma.hidden = NO;
                            Cell.userInteractionEnabled = YES;
                        }
                            break;
                        case 2:{
                            Cell.statueLab.text = @"未完成";
                            Cell.statueLab.textColor = kthemeBlackColor;
                            Cell.contentView.backgroundColor = kThemeWhiteColor;
                            Cell.arrowIma.hidden = YES;

                        }
                            break;
                        default:
                            break;
                    }
                }
        }
    } else {//手机绑定未完成
        switch (indexPath.row) {//未完成-未完成-未完成
            case 0:{
                Cell.statueLab.text = @"未完成";
                Cell.statueLab.textColor = kthemeBlackColor;
                Cell.contentView.backgroundColor = kBlackThemetextColor;
                Cell.arrowIma.hidden = NO;
                Cell.userInteractionEnabled = YES;
            }
                break;
            case 1:{
                Cell.statueLab.text = @"未完成";
                Cell.statueLab.textColor = kthemeBlackColor;
                Cell.contentView.backgroundColor = kThemeWhiteColor;
                Cell.arrowIma.hidden = YES;

            }
                break;
            case 2:{
                Cell.statueLab.text = @"未完成";
                Cell.statueLab.textColor = kthemeBlackColor;
                Cell.contentView.backgroundColor = kThemeWhiteColor;
                Cell.arrowIma.hidden = YES;

            }
                break;
                
            default:
                break;
        }
    }
    return Cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self sureClick];
}

@end

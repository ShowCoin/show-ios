//
//  ShowAddressTextCell.h
//  ShowLive
//
//  Created by iori_chou on 2018/4/2.
//  Copyright © 2018年 vning. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTableViewCell.h"
typedef void (^inputNameBlock)(NSString * name);
typedef void (^inputAddressbBlock)(NSString * address);
typedef void (^inputPasswordBlock)(NSString * password);
typedef void (^SwitchBlock)(BOOL on);
typedef void (^SendCodeBlock)(BOOL on);

@interface ShowAddressTextCell : BaseTableViewCell
// cell的标题文字
@property (nonatomic, strong) UILabel *  titlelabel;
@property (nonatomic, strong) UILabel *  bottomLabel;
@property (nonatomic, strong) UIView *   lineView;
@property (nonatomic, strong)UITextField * name;
@property (nonatomic, strong)UITextField * address;
@property (nonatomic, strong)UITextField * password;
@property (nonatomic, strong)UIButton * sendCodeBtn;
@property (nonatomic, strong)UISwitch * certificationSwitch;
@property (nonatomic, copy)inputNameBlock nameBlock;
@property (nonatomic, copy)inputAddressbBlock addressbBlock;
@property (nonatomic, copy)inputPasswordBlock passwordBlock;
@property (nonatomic, copy)SwitchBlock switchBlock;
@property (nonatomic, copy)SendCodeBlock sendCodeBlock;

@property (nonatomic,assign)NSInteger cutDownTimerSeconds;
@property (nonatomic,strong)NSTimer *cutDownTimer;

@end

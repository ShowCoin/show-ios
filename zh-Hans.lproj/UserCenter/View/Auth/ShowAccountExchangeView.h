//
//  ShowAccountExchangView.h
//  ShowLive
//
//  Created by iori_chou on 2018/3/29.
//  Copyright © 2018年 vning. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShowAccountExchangeView : UIView
@property (nonatomic, strong) UILabel *  namelabel;
@property (nonatomic, strong) UILabel *  coinNumLabel;
@property (nonatomic, strong) UILabel *  ethLabel;
@property (nonatomic, strong) UILabel *  RmbLabel;
@property (nonatomic, strong) UIImageView * backimage;
@property (nonatomic, strong) UIButton * coverBtn;
@property (nonatomic, strong) NSDictionary * pay_config;

@end

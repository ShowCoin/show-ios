//
//  AddressChooseCell.h
//  ShowLive
//
//  Created by vning on 2018/4/3.
//  Copyright © 2018年 vning. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SLAddressList.h"

@interface AddressChooseCell : UITableViewCell
@property (nonatomic, strong) SLHeadPortrait *  headportrait;
@property (nonatomic, strong) UILabel *  nameLab;
@property (nonatomic, strong) UILabel *  addressLab;
@property (nonatomic, strong) UILabel *  statuLab;
@property (nonatomic, strong) UIImageView *  statuImg;
@property (nonatomic, strong) UIView *  lineView;
@property (nonatomic,strong) SLAddressList * model;

@end

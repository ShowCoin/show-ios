//
//  CoinDetailCell.h
//  ShowLive
//
//  Created by zhangxinggong on 2018/4/2.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "TransactionRecordsModel.h"

@interface CoinDetailCell : BaseTableViewCell

@property (nonatomic,strong) TransactionRecordsModel * model;
@property (nonatomic,strong) BaseViewController * Controller;

@end

//
//  SLGetWithdrawListAction.h
//  ShowLive
//
//  Created by iori_chou on 2018/5/12.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "ShowAction.h"


@interface SLGetWithdrawListAction : ShowAction

@property (nonatomic,strong)NSString * cursor;
@property (nonatomic,strong)NSString * count;
@property (nonatomic,strong)NSString * coin_type;

@end

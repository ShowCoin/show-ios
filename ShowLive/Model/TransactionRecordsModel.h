//
//  TransactionRecordsModel.h
//  ShowLive
//
//  Created by  JokeSmileZhang on 2018/4/2.
//  Copyright © 2018年 VNing. All rights reserved.
//

#import "BaseModel.h"

@interface TransactionRecordsModel : BaseModel

@property (copy,nonatomic) NSString * name;

@property (copy,nonatomic) NSString *address;

@property (copy,nonatomic) NSString *count ;

@property (copy,nonatomic) NSString *data;

@end

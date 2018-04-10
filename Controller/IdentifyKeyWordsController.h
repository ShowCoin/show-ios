//
//  IdentifyKeyWordsController.h
//  ShowLive
//
//  Created by vning on 2018/4/4.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "BaseViewController.h"

@interface IdentifyKeyWordsController : BaseViewController
@property (nonatomic,strong)Account * account;
@property (nonatomic,copy)NSString * password;
@property (nonatomic, copy) NSString *json;
@end

@interface IdentifyKeyWordsTask :UIButton

@end;

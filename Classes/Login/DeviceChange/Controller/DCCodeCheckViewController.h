//
//  DCCodeCheckViewController.h
//  ShowLive
//
//  Created by chenyh on 2019/1/26.
//  Copyright © 2019 vning. All rights reserved.
//

#import "BaseViewController.h"
#import "DCSafetyIDModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface DCCodeCheckViewController : BaseViewController

@property (nonatomic, strong) DCSafetyIDModel *model;
@property (nonatomic, strong) NSDictionary *codeParam;

@property (nonatomic, copy) SLSimpleBlock refreshBlock;

@end

NS_ASSUME_NONNULL_END

//
//  SLEffectManager.m
//  ShowLive
//
//  Created by WorkNew on 2018/4/17.
//  Copyright © 2018年 VNing. All rights reserved.
//

#import "SLEffectManager.h"
#import "SLGiftListManager.h"
#import "SLGiftListModel.h"

static SLEffectManager *instance = nil;

@interface SLEffectManager ()

@end

@implementation SLEffectManager

/**
 单例
 
 @return 返回实例
 */
+(instancetype)shareInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        instance = [[SLEffectManager alloc]init];
    });
    
    return instance;
}

- (instancetype)init
{
    self = [super init];
    
    if (self) {
        
        [self initData];
    }
    
    return self;
}

-(void)initData
{
    
}

-(void)updateGift
{
    [[SLGiftListManager shareInstance] requestGiftListSuccess:^(NSArray *giftList) {
        

        //执行下载逻辑
    }];
}


@end

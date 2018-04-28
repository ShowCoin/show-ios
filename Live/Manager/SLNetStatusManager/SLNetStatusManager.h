//
//  SLNetStatusManager.h
//  ShowLive
//
//  Created by gongxin on 2018/4/23.
//  Copyright © 2018年 vning. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SLNetStatusManager : NSObject

+(instancetype)shareInstance;

-(void)getNetWorkStausAndIsContinue:(void (^)(BOOL isContinue))isContinue;


@end

//
//  SLConfigAction.m
//  ShowLive
//
//  Created by iori_chou on 2018/4/12.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "SLConfigAction.h"

@implementation SLConfigAction
- (NSString *)interface{
    return  @"config";
}
-(ShowRequestData *)requestData{
    ShowRequestData *rd = [[ShowRequestData alloc] init];
    rd.interface = [self interface];
    return rd ;
}


@end

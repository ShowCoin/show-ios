//
//  SLGetRyTokenAction.m
//  ShowLive
//
//  Created by iori_chou on 2018/4/11.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "SLGetRyTokenAction.h"

@implementation SLGetRyTokenAction
- (NSString *)interface{
    return  @"getRyToken";
}
-(ShowRequestData *)requestData{
    ShowRequestData *rd = [[ShowRequestData alloc] init];
    rd.interface = [self interface];
    return rd ;
}
@end

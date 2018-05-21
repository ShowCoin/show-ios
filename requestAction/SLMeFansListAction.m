//
//  SLMeFansListAction.m
//  ShowLive
//
//  Created by iori_chou on 2018/4/13.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "SLMeFansListAction.h"

@implementation SLMeFansListAction
-(ShowRequestData *)requestData{
    ShowRequestData *rd = [[ShowRequestData alloc] init];
    rd.interface = [self interface];
    [rd appendPostValue:self.uid key:@"uid"];
    [rd appendPostValue:self.cursor key:@"cursor"];
    [rd appendPostValue:self.count key:@"count"];
    return rd ;
}

-(NSString *)interface{
    return @"user_fans_list";
}


@end

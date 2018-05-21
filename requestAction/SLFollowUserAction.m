//
//  SLFollowUsersAction.m
//  ShowLive
//
//  Created by iori_chou on 2018/4/13.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "SLFollowUserAction.h"

@implementation SLFollowUserAction
- (ShowRequestData *)requestData {
    ShowRequestData *rd = [[ShowRequestData alloc] init];
    rd.interface = @"follow_user";
    [rd appendPostValue:self.to_uid key:@"to_uid"];
    [rd appendPostValue:[self getTypeString:self.type]  key:@"type"];
    return rd;
}

-(NSString *)getTypeString:(FollowType)type{
    NSString *str = @"";
    if (type == FollowTypeAdd) {
        str = @"add";
    }else if(type == FollowTypeDelete){
        str = @"delete";
    }
    return str;
}

@end

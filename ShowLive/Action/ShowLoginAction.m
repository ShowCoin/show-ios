//
//  ShowLoginAction.m
//  ShowLive
//
//  Created by 周华 on 2018/3/28.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "ShowLoginAction.h"

@implementation ShowLoginAction
- (void)start {
    ShowRequestData *rd = [[ShowRequestData alloc] init];
    rd.interface = @"login";
    [rd appendPostValue:self.phone key:@"phone"];
    [rd appendPostValue:self.pwd key:@"pwd"];
    
    __weak typeof(self) wself = self;
    [ShowRequest requestWithData:MainURL requestData:rd
                       succeed:^(ShowRequest *request, NSDictionary *respDic) {
                           [wself throwResult:respDic];
                       } failed:^(ShowRequest *request, NSError *error) {
                           [wself throwError:error];
                       } cancelled:^(ShowRequest *request) {
                           [wself throwCancel];
                       }];
}
@end

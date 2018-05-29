//
//  SLChatViewController+BlankView.m
//  ShowLive
//
//  Created by iori_chou on 2018/4/10.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "SLChatViewController+BlankView.h"

@implementation SLChatViewController (BlankView)
- (void)showBlankViewWithType:(SLMessageBlankViewType)type
{
    if (!self.blankView) {
        self.blankView = [[SLBlankView alloc] initWithFrame:self.tableView.frame];
        [self.view addSubview:self.blankView];
        [self.view bringSubviewToFront:self.blankView];
    }
    self.blankView.hidden = NO;
    [self.blankView setType:type];
    [self.blankView setDidTappedLoginBtnAction:^{
        [PageMgr presentLoginViewController];
    }];
}

- (void)hideBlankView
{
    self.blankView.hidden = YES;
}
@end

//
//  SLChatViewController+BlankView.h
//  ShowLive
//
//  Created by iori_chou on 2018/4/10.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "SLChatViewController.h"
#import "SLBlankView.h"
@interface SLChatViewController()
@property (strong, nonatomic) SLBlankView *blankView;
@end

@interface SLChatViewController (BlankView)
//根据类型展示
- (void)showBlankViewWithType:(SLMessageBlankViewType)type;
//隐藏blankView
- (void)hideBlankView;

@end

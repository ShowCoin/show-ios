//
//  SLChatViewController+BlankView.h
//  ShowLive
//
//  Created by Mac on 2018/4/10.
//  Copyright © 2018年 VNing. All rights reserved.
//

#import "SLChatViewController.h"
#import "SLBlankView.h"
@interface SLChatViewController()
@property (strong, nonatomic) SLBlankView *blankView;
@end

@interface SLChatViewController (BlankView)
- (void)showBlankViewWithType:(SLMessageBlankViewType)type;
- (void)hideBlankView;

@end

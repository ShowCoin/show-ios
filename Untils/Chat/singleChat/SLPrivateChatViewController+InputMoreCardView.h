//
//  SLPrivateChatViewController+InputMoreCardView.h
//  ShowLive
//
//  Created by iori_chou on 2018/4/11.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "SLPrivateChatViewController.h"
#import "SLConversationInputMoreCardView.h"

@interface SLPrivateChatViewController (InputMoreCardView)<SLConversationInputMoreCardViewDelegate>
@property (nonatomic, assign) BOOL isInputMoreCardViewShow;
@property (strong, nonatomic) SLConversationInputMoreCardView *inputMoreCardView;

@end

//
//  SLPrivateChatViewController+Gesture.h
//  ShowLive
//
//  Created by iori_chou on 2018/4/11.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "SLPrivateChatViewController.h"
@interface SLPrivateChatViewController()
@property (nonatomic, strong)NSIndexPath *curMenuIndex;
@end

@interface SLPrivateChatViewController (Gesture)
- (void)setupGestures;
- (void)setupMenuItems;

@end

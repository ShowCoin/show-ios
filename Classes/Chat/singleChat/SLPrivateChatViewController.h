//
//  SLPrivateChatViewController.h
//  ShowLive
//
//  Created by iori_chou on 2018/4/10.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "BaseViewController.h"
#import "ShowUserModel.h"

static inline CGFloat _GetChatInputViewHeight(void){
    return 50;
}

static inline CGFloat _GetChatInputMoreCardHeight(void){
    return 154;
}


@interface SLPrivateChatViewController : BaseViewController
/// Public 二者设置一个，即更新了另一个
@property (nonatomic, strong) NSString *targetUid;


@end

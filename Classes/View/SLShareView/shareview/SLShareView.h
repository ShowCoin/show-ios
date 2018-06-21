//
//  SLShareView.h
//  ShowLive
//
//  Created by showgx on 2018/4/11.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "SLBaseModalView.h"
#import "SLShareSuccessAction.h"
#import "SLUserShareView.h"
@interface SLShareView : SLBaseModalView
{
    NSString * shareInfo;
    SLShareType shareType;
    NSString* currentWorkId;
}
@property (nonatomic, strong) NSString * uid;
@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) UIImage * userHeader;
@property (nonatomic,strong)NSString * shareUrl;
@property (nonatomic,strong)NSString * share_add;

@property (nonatomic, strong) SLShareSuccessAction *shareSuccessAction;
@property (nonatomic, copy) void (^shareSuccessBlock)(void);

-(void)setShareType:(SLShareType)sType andInfo:(NSString*)info andUID:(NSString *)uid;
+ (instancetype)shared;
@end

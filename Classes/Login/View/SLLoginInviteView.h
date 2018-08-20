//
//  SLLoginInviteView.h
//  ShowLive
//
//  Created by chenyh on 2018/8/13.
//  Copyright © 2018年 vning. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SLLoginInviteView : UIView

@property (nonatomic, assign, readonly) CGFloat viewH;
/// 邀请码
@property (nonatomic, strong, readonly) NSString *inviteCode;
/// 分成比例
@property (nonatomic, strong, readonly) NSString *inviteRatio;

@property (nonatomic, copy) SLSimpleBlock refreshBlock;

@end

/**
 注册即您同意分成协议。
 
 @param isAlert 是否是alert
 @return 富文本
 */
FOUNDATION_EXPORT NSAttributedString *SLFuncServerAttributedString(BOOL isAlert);

/**
 注册即您同意分成协议。
 邀请您注册SHOW 的用户名为：胡震生，使用此邀请码，意味着您在SHOW直播的收入的1%定期奖励给 “胡震生”。不可更改不可取消。
 
 @param text 邀请人
 @param r 分成比例
 @param isAlert 是否是alert 字体大小颜色不同
 @return 固定富文本
 */
FOUNDATION_EXPORT NSAttributedString *SLFuncInvitaAttributedString(NSString *text, NSString *r, BOOL isAlert);

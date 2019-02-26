//
//  SLBlankView.h
//  ShowLive
//
//  Created by iori_chou on 2018/4/10.
//  Copyright © 2018年 vning. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, SLMessageBlankViewType) {
    SLMessageBlankViewTypeMessageListTouristMode,
    SLMessageBlankViewTypeMessageListSearchNotFound,
    SLMessageBlankViewTypeMessageListSearchNoData,
    SLMessageBlankViewTypeMineLikeWork,
    SLMessageBlankViewTypeMyWork
};

@interface SLBlankView : UIView

//设置类型
- (void)setType:(SLMessageBlankViewType)type;
//点击登录事件
@property (copy, nonatomic) void (^didTappedLoginBtnAction)(void);

@end

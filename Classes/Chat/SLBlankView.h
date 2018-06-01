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
- (void)setType:(SLMessageBlankViewType)type;
@property (copy, nonatomic) void (^didTappedLoginBtnAction)(void);

@end

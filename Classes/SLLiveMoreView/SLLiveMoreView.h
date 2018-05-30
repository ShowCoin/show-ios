//
//  SLLiveMoreView.h
//  ShowLive
//
//  Created by gongxin on 2018/4/24.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "SLBaseModalView.h"

@protocol SLLiveMoreViewProtocol <NSObject>

@optional

- (void)moreViewClickMessage;
- (void)moreViewScreenShoot;

@end

UIKIT_EXTERN CGFloat const kSLLiveMoreViewH;

@interface SLLiveMoreView : SLBaseModalView

@property (nonatomic, weak) id <SLLiveMoreViewProtocol> protocol;

@end

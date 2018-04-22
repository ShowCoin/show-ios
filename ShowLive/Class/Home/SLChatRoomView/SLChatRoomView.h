//
//  SLChatRoomView.h
//  ShowLive
//
//  Created by zhangxinggong on 2018/4/10.
//  Copyright © 2018年 vning. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SLChatIMManager.h"

@interface SLChatRoomView : UIView

@property (strong,nonatomic)NSMutableArray *dataSource;

+(instancetype)showInView:(UIView *)fatherView Paramters:(NSDictionary *)paramters;

- (void)changeFrameYConstraints:(CGFloat)YConstraints UIView:(UIView *)fatherView;

- (void)quiteChatRoomSucess:(void(^)(void))sucess faild:(void(^)(RCErrorCode status))faild;

- (void)sendText:(NSString *)text;

@end

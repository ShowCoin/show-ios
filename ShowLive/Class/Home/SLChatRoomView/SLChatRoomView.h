//
//  SLChatRoomView.h
//  ShowLive
//
//  Created by  JokeSmileZhang on 2018/4/10.
//  Copyright © 2018年 VNing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SLChatIMManager.h"

typedef void (^ShareBlock)(void);

@interface SLChatRoomView : UIView

@property (strong,nonatomic)NSMutableArray *dataSource;

@property (copy,nonatomic)ShareBlock shareBlock;

+(instancetype)showInView:(UIView *)fatherView Paramters:(NSDictionary *)paramters;

- (void)changeFrameYConstraints:(CGFloat)YConstraints UIView:(UIView *)fatherView;

- (void)quiteChatRoomSucess:(void(^)(void))sucess faild:(void(^)(RCErrorCode status))faild;

@property (strong,nonatomic)SLChatIMManager *chatIMMangger;

- (void)sendText:(NSString *)text;

@end

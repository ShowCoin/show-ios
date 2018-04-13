//
//  SLChatRoomView.h
//  ShowLive
//
//  Created by zhangxinggong on 2018/4/10.
//  Copyright © 2018年 vning. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SLChatRoomView : UIView

@property (strong,nonatomic)NSMutableArray *dataSource;

+(instancetype)showInView:(UIView *)fatherView;

- (void)changeFrameYConstraints:(CGFloat)YConstraints UIView:(UIView *)fatherView;

@end

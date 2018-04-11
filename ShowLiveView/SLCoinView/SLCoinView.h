//
//  SLCoinView.h
//  ShowLive
//
//  Created by 巩鑫 on 2018/4/9.
//  Copyright © 2018年 vning. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SLCoinView : UIView

//初始化后调去 去拉初始数据
-(void)updateViewWithUserId:(NSString *)uid;

//更新数据
-(void)updateTicketWithCount:(NSInteger)count;

@end

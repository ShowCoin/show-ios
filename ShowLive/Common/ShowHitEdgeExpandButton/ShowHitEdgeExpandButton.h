//
//  ShowHitEdgeExpandButton.h
//  ShowLive
//
//  Created by Mac on 2018/3/21.
//  Copyright © 2018年 VNing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShowHitEdgeExpandButton : UIButton
/**
 扩大button为中心四个边的点击区域，正大负小
 */
@property (assign, nonatomic) UIEdgeInsets expandHitEdge;

@end

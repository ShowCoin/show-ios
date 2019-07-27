//
//  SLConvListSystemTableViewCell.h
//  ShowLive
//
//  Created by iori_chou on 2018/4/30.
//  Copyright © 2018年 vning. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SLConvListSystemTableViewCell : UITableViewCell

@property (nonatomic, strong)UIImageView * iconImage; //左侧的图标
@property (nonatomic, strong)UIImageView * iconVImage; //v标志
@property (nonatomic, strong)UIView *redPoint;      //新消息标识的小红点

@property (nonatomic, strong)UILabel * titleLab;    //标题
@property (nonatomic, strong)UILabel *contentLabel; //消息内容

@property (nonatomic, copy) void (^selectedBlock)(SLConvListSystemTableViewCell *sendr);//按钮点击事件
@property (nonatomic, copy) void (^didTapHeadBlock)(SLConvListSystemTableViewCell *sendr);

@end

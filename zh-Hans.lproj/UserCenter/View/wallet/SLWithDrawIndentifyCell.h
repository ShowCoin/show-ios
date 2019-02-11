//
//  SLWithDrawIndentifyCell.h
//  ShowLive
//
//  Created by vning on 2018/7/10.
//  Copyright © 2018年 vning. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SLWithDrawIndentifyCell : UITableViewCell
@property (nonatomic, strong) UILabel * titleLab;
@property (nonatomic, strong) UILabel * statueLab;
@property (nonatomic, strong) UIImageView * arrowIma;
-(void)setType:(NSInteger)type;//1：未完成   2 已完成   3认证中

@end

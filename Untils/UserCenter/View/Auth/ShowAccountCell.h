//
//  ShowAccountCell.h
//  ShowLive
//
//  Created by 周华 on 2018/3/29.
//  Copyright © 2018年 vning. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTableViewCell.h"

@interface ShowAccountCell : BaseTableViewCell
// cell的标题文字
@property (nonatomic, strong) UILabel *  coinNamelabel;
@property (nonatomic, strong) UILabel *  coinDetailNamelabel;
// cell右侧的数字
@property (nonatomic, strong) UILabel *  coinNumLabel;

@property (nonatomic, strong) UILabel *  RmbNumLabel;

@property (nonatomic, strong) UILabel *  FreezeNumLabel;

@property (nonatomic, strong) UIView *   lineView;

@property (nonatomic, strong) UIImageView * coinImage;

@property (nonatomic, strong) UILabel * percentBgView;
@property (nonatomic, strong) UIView * percentView;
@property (nonatomic, strong) UILabel * percentTextView;

@property (nonatomic, assign) CGFloat  percent;
@property (nonatomic, assign) NSInteger  type;


- (void)bindModel:(NSString *)object;
@end

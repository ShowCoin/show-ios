//
//  SLRightMemberTableViewCell.h
//  ShowLive
//
//  Created by gongxin on 2018/4/25.
//  Copyright © 2018年 vning. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SLHeadPortrait.h"
#import "SLMemberListModel.h"
@interface SLRightMemberTableViewCell : UITableViewCell

@property(nonatomic,strong)SLMemberListModel * model;
@property(nonatomic,strong)SLHeadPortrait * avatarView;

@end

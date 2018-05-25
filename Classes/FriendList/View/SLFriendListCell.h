//
//  SLFriendListCell.h
//  ShowLive
//
//  Created by iori_chou on 2018/4/13.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "SLFansModel.h"
#import "SLHeadPortrait.h"
#import "UIView+ACMediaExt.h"
#import "UIView+Extend.h"
#import "UILabel+Additional.h"
@protocol SLFriendListCellelegate <NSObject>
- (void)onClickUser:(SLFansModel*)data;
- (void)onClickChat:(SLFansModel*)data;
- (void)onClickFollow:(SuccessBlock)block withData:(SLFansModel*)data;
- (void)onClickAt:(SLFansModel*)data button:(UIButton *)sender;

@end

@interface SLFriendListCell : BaseTableViewCell
+(id)cellWithTableView:(UITableView*)tableView;
+(id)cellWithTableView:(UITableView*)tableView separatorLineFull:(BOOL)separatorLineFull;
@property(nonatomic,strong)SLFansModel * userListModel;
@property(nonatomic,strong)ShowUserModel * userModel;
@property(nonatomic,strong)UILabel          * moneyLabel; //未读消息数量

@property (nonatomic,weak)id<SLFriendListCellelegate>  functionDelegate;
@property (nonatomic,assign)BOOL isAt;

@end

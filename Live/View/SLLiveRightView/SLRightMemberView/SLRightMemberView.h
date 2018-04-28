//
//  SLRightMemberView.h
//  ShowLive
//
//  Created by WorkNew on 2018/4/25.
//  Copyright © 2018年 VNing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SLRightMemberTableViewCell.h"
#import "SLMemberListModel.h"
@protocol SLRightMemberViewProtocol <NSObject>

@required

- (void)selectMember:(SLMemberListModel*)model;


@end
@interface SLRightMemberView : UITableView

@property (nonatomic, weak) id<SLRightMemberViewProtocol>protocol;



@property(nonatomic,strong)NSArray * memberArray;

@end

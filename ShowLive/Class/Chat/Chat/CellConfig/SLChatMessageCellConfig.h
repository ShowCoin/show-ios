//
//  SLChatMessageCellConfig.h
//  ShowLive
//
//  Created by 周华 on 2018/4/10.
//  Copyright © 2018年 vning. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SLChatMessageBaseCellViewModel.h"
#import "SLChatMessageCellTypeMap.h"
#import "SLChatMessageCellHeader.h"

@interface SLChatMessageCellConfig : NSObject
- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithTableView:(UITableView *)tableView NS_DESIGNATED_INITIALIZER;
+ (instancetype)configWithTableView:(UITableView *)tableview;
- (NSString *)reusableIdentifierWithViewModel:(id<SLChatMessageBaseCellViewModel>)viewModel;
- (CGFloat)getCellHeightWithViewModel:(id<SLChatMessageBaseCellViewModel>)viewModel;
+ (NSString *)cellNameWithCellType:(SLChatMessageCellType)cellType;
+ (NSString *)cellViewModelImpClassNameWithRCMessage:(RCMessage *)rcMessage;


@end

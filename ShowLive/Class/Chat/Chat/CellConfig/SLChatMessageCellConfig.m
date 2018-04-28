//
//  SLChatMessageCellConfig.m
//  ShowLive
//
//  Created by Mac on 2018/4/10.
//  Copyright © 2018年 VNing. All rights reserved.
//

#import "SLChatMessageCellConfig.h"

@implementation SLChatMessageCellConfig
#pragma mark - Init
- (instancetype)init
{
    NSAssert(0, @"Use: initWithTableView:");
    return nil;
}

- (instancetype)initWithTableView:(UITableView *)tableView
{
    self = [super init];
    if (self) {
        [self registerSubCells:tableView];
    }
    return self;
}

#pragma mark - Public
#pragma mark - Public
+ (instancetype)configWithTableView:(UITableView *)tableview
{
    return [[self alloc] initWithTableView:tableview];
}

- (NSString *)reusableIdentifierWithViewModel:(id<SLChatMessageBaseCellViewModel>)viewModel
{
    NSString *cellName = [SLChatMessageCellTypeMap cellNameWithCellType:viewModel.cellType];
    return cellName;
}

- (CGFloat)getCellHeightWithViewModel:(id<SLChatMessageBaseCellViewModel>)viewModel
{
    NSString *cellName = [SLChatMessageCellTypeMap cellNameWithCellType:viewModel.cellType];
    return [NSClassFromString(cellName) getCellHeightWithViewModel:viewModel];
}

+ (NSString *)cellNameWithCellType:(SLChatMessageCellType)cellType
{
    return [SLChatMessageCellTypeMap cellNameWithCellType:cellType];
}

+ (NSString *)cellViewModelImpClassNameWithRCMessage:(RCMessage *)rcMessage
{
    return [SLChatMessageCellTypeMap cellViewModelImpClassNameWithRCMessage:rcMessage];
}


#pragma mark - Private
- (void)registerSubCells:(UITableView *)tableView
{
    for (NSInteger i = 0; i < ChatMessageCellTypeCount; i++) {
        NSString *cellName = [SLChatMessageCellTypeMap cellNameWithCellType:i];
        [tableView registerClass:NSClassFromString(cellName) forCellReuseIdentifier:cellName];
    }
}
@end

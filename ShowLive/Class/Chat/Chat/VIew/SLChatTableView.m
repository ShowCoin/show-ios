//
//  SLChatTableView.m
//  ShowLive
//
//  Created by Mac on 2018/4/10.
//  Copyright © 2018年 VNing. All rights reserved.
//

#import "SLChatTableView.h"
#import "SLChatMessageCellConfig.h"
#import "SLChatMessageCellProtocol.h"
#import "SLChatMessageBaseCell.h"
@interface SLChatTableView()
@property (strong, nonatomic) SLChatMessageCellConfig *config;
@end
@implementation SLChatTableView
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.backgroundColor = RGBCOLOR(247, 247, 247);
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.allowsSelection = NO;
        self.dataSource = self;
        self.delegate = self;
        self.contentInset = UIEdgeInsetsMake(10, 0, 20, 0);
        _config = [SLChatMessageCellConfig configWithTableView:self];
    }
    return self;
}
//
#pragma mark - UITableViewDataSource
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id<SLChatMessageBaseCellViewModel> viewModel = self.dataArray[indexPath.row];
    if (viewModel.sizeCache.cellHeight > 0 ) {
        return viewModel.sizeCache.cellHeight;
    } else {
        return [self.config getCellHeightWithViewModel:viewModel];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id<SLChatMessageBaseCellViewModel> viewModel = self.dataArray[indexPath.row];
    NSString *reusableIdentifier = [self.config reusableIdentifierWithViewModel:viewModel];
    
    SLChatMessageBaseCell *cell = [self dequeueReusableCellWithIdentifier:reusableIdentifier];
    cell.delegate = self.chatMessageCellDelegate;
    //    cell.viewModel = viewModel;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    id<SLChatMessageBaseCellViewModel> viewModel = self.dataArray[indexPath.row];
    //    NSString *reusableIdentifier = [self.config reusableIdentifierWithViewModel:viewModel];
    SLChatMessageBaseCell *acell = (SLChatMessageBaseCell *)cell;
    acell.viewModel = viewModel;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if (self.tableViewWillBeginDragging) {
        self.tableViewWillBeginDragging();
    }
}

@end

@implementation SLChatTableView(Behavior)

- (void)scrollToBottomAnimated:(BOOL)animated
{
    NSInteger lastRow = [self numberOfRowsInSection:0] - 1;
    [self scrollToRow:lastRow animated:animated position:UITableViewScrollPositionNone];
}

- (void)scrollToRow:(NSInteger)row animated:(BOOL)animated position:(UITableViewScrollPosition)position
{
    if (row > 0) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:0];
        [self scrollToRowAtIndexPath:indexPath atScrollPosition:position animated:animated];
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

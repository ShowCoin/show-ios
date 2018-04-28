//
//  SLChatTableView.h
//  ShowLive
//
//  Created by Mac on 2018/4/10.
//  Copyright © 2018年 VNing. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol SLChatMessageBaseCellViewModel;
@protocol SLChatMessageCellDelegate;

@interface SLChatTableView : UITableView<UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) NSArray<id<SLChatMessageBaseCellViewModel>> *dataArray;
@property (weak, nonatomic) id<SLChatMessageCellDelegate> chatMessageCellDelegate;
@property (copy, nonatomic) void(^tableViewWillBeginDragging)(void);
@end

@interface SLChatTableView(Behavior)
- (void)scrollToBottomAnimated:(BOOL)animated;
- (void)scrollToRow:(NSInteger)row animated:(BOOL)animated position:(UITableViewScrollPosition)position;
@end



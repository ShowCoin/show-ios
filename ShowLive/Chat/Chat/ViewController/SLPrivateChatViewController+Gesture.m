//
//  SLPrivateChatViewController+Gesture.m
//  ShowLive
//
//  Created by 周华 on 2018/4/11.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "SLPrivateChatViewController+Gesture.h"
#import "SLPrivateChatViewController+InputView.h"
#import "SLPrivateChatViewController+TableView.h"
#import "SLPrivateChatViewController+Business.h"
#import "SLPrivateChatViewController+MessageSend.h"
#import "SLPrivateChatViewController+Common.h"
#import "SLPrivateChatViewController+Emoji.h"
#import "SLPrivateChatViewController+InputMoreCardView.h"
#import "SLChatMessageCellHeader.h"

@implementation SLPrivateChatViewController (Gesture)
#pragma mark - Override
- (BOOL)canBecomeFirstResponder
{
    return YES;
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    if ([self isChatViewFirstResponder]) {
        return ( action == @selector(paste:) );
    }
    
    if (!self.curMenuIndex) {
        return NO;
    }
    
    BOOL isCopy = ( action == @selector(copy:) );
    BOOL isDelete = ( action == @selector(delete:) );
    BOOL isRecall = ( action == @selector(recallMessage:) );
    
    SLChatMessageBaseCell *cell = [self.tableView cellForRowAtIndexPath:self.curMenuIndex];
    SLChatMessageCellType cellType = cell.viewModel.cellType;
    if (isCopy) {
        return ( cellType == SLChatMessageCellTypeText );
    } else if (isDelete) {
        return YES;
    } else if (isRecall) {
        BOOL isSend = ( cell.viewModel.messageDirection == SLChatMessageDirectionSend );
        if (!isSend) {
            return NO;
        }
        
        BOOL supportType = [self isSupportRecallWithCellType:cellType];
        if (!supportType) {
            return NO;
        }
        
        // after 2 min will return NO.
        NSTimeInterval timeInterval = cell.viewModel.sentTimeIntervalSinceNow;
        NSTimeInterval seconds = 2*60;
        return ( timeInterval < seconds );
    }
    return NO;
}

#pragma mark - setUp

- (void)setupMenuItems
{
    UIMenuItem *recallMenuItem = [[UIMenuItem alloc] initWithTitle:@"撤回" action:@selector(recallMessage:)];
    [[UIMenuController sharedMenuController] setMenuItems: @[recallMenuItem]];
    [[UIMenuController sharedMenuController] update];
}

- (void)setupGestures
{
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapAction:)];
    [self.tableView addGestureRecognizer:tapGes];
    tapGes.cancelsTouchesInView = NO;
    
    UILongPressGestureRecognizer *longPressGes = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)];
    longPressGes.numberOfTouchesRequired = 1;
    longPressGes.minimumPressDuration = 0.5;
    [self.tableView addGestureRecognizer:longPressGes];
    //    longPressGes.cancelsTouchesInView = NO;
}

#pragma mark - Action
-(void)handleTapAction:(UIGestureRecognizer *)tap
{
    [self cleanMenu];
    self.isInputMoreCardViewShow = NO;
    self.isEmojiViewShow = NO;
    if (UIGestureRecognizerStateEnded == tap.state) {
        [self resignChatViewFirstResponder];
    }
}

-(void)handleLongPress:(UIGestureRecognizer *)ges
{
    [self resignChatViewFirstResponder];
    self.isInputMoreCardViewShow = NO;
    self.isEmojiViewShow = NO;
    if (UIGestureRecognizerStateBegan == ges.state) {
        [self cleanMenu];
        self.tableView.scrollEnabled = NO;
        
        CGPoint point = [ges locationInView:self.tableView];
        NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:point];
        if (indexPath) {
            SLChatMessageBaseCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
            CGPoint pointInCell = [ges locationInView:cell];
            
            if (CGRectContainsPoint(cell.middleContainerView.frame, pointInCell)) {
                self.curMenuIndex = indexPath;
                [self.tableView becomeFirstResponder];
                
                CGRect rectMenu = [cell.contentView convertRect:cell.middleContainerView.frame toView:self.tableView];
                [[UIMenuController sharedMenuController] setTargetRect:rectMenu inView:self.tableView];
                
                [self setupMenuItems];
                [[UIMenuController sharedMenuController] setMenuVisible:YES animated:YES];
            }
        }
    } else if (UIGestureRecognizerStateChanged == ges.state) {
        
    } else {
        self.tableView.scrollEnabled = YES;
    }
}

- (void)cleanMenu
{
    self.tableView.scrollEnabled = YES;
    self.curMenuIndex = nil;
    if ([UIMenuController sharedMenuController].menuVisible) {
        [[UIMenuController sharedMenuController] setMenuVisible:NO animated:YES];
    }
}

#pragma mark - Menu Item Action

- (void)copy:(id)sender {
    SLChatMessageBaseCell *cell = [self.tableView cellForRowAtIndexPath:self.curMenuIndex];
    if (!cell) {
        return;
    }
    if (cell.viewModel.cellType != SLChatMessageCellTypeText) {
        return;
    }
    
    id<SLChatTextMessageCellViewModel> viewModel = (id<SLChatTextMessageCellViewModel>)cell.viewModel;
    UIPasteboard* pasteboard = [UIPasteboard generalPasteboard];
    [pasteboard setString:viewModel.contentString];
    self.curMenuIndex = nil;
}

- (void)recallMessage:(id)sender
{
    SLChatMessageBaseCell *cell = [self.tableView cellForRowAtIndexPath:self.curMenuIndex];
    if (!cell) {
        return;
    }
    if (![self isSupportRecallWithCellType:cell.viewModel.cellType]) {
        return;
    }
    
    [self recallRCMessage:cell.viewModel.rcMessage atIndexPath:self.curMenuIndex];
}

- (void)delete:(id)sender
{
    [self deleteCellDataAndMessageAtRow:self.curMenuIndex.row animation:YES];
    self.curMenuIndex = nil;
}

- (void)paste:(id)sender
{
    if ([self isChatViewFirstResponder]) {
        [ShowWaringView waringView:@"粘贴内容格式不符，只支持文本" style:WaringStyleRed];
    }
}

#pragma mark - Private
- (BOOL)isSupportRecallWithCellType:(SLChatMessageCellType)cellType
{
    BOOL supportType = (cellType == SLChatMessageCellTypeText ||
                        cellType == SLChatMessageCellTypeVoice ||
                        cellType == SLChatMessageCellTypeDice );
    return supportType;
}

@end

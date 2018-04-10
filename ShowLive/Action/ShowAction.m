//
//  ShowAction.m
//  ShowLive
//
//  Created by 周华 on 2018/3/21.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "ShowAction.h"
@implementation ShowAction
{
    BOOL _finished;
}

/**
 * 开始
 */
- (void)start {
    [self throwResult:nil];
}

/**
 * 取消
 */
- (void)cancel {
    [self throwCancel];
}

+ (instancetype)action {
    id obj = [[self alloc] init];
    return obj;
}

- (void)throwResult:(id)result {
    @synchronized (self) {
        if (_finished) {
            return;
        }
        _finished = YES;
        __weak typeof(self) weaks = self;
        dispatch_block_t block = ^{
            if (weaks.finishedBlock) {
                weaks.finishedBlock(result);
            }
        };
        dispatch_main_sync_safe(block);
    }
}

- (void)throwError:(NSError *)error {
    @synchronized (self) {
        if (_finished) {
            return;
        }
        _finished = YES;
        __weak typeof(self) weaks = self;
        dispatch_block_t block = ^{
            if (weaks.failedBlock) {
                weaks.failedBlock(error);
            }
        };
        dispatch_main_sync_safe(block);
    }
}

- (void)throwCancel {
    @synchronized (self) {
        if (_finished) {
            return;
        }
        _finished = YES;
        __weak typeof(self) weaks = self;
        dispatch_block_t block = ^{
            if (weaks.cancelledBlock) {
                weaks.cancelledBlock();
            }
        };
        dispatch_main_sync_safe(block);
    }
}

-(void)dealloc{
    //    NSLog(@"---%s---",__func__);
}
@end

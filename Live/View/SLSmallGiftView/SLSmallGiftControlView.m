//
//  SLSmallGiftControlView.m
//  ShowLive
//
//  Created by WorkNew on 2018/4/17.
//  Copyright © 2018年 VNing. All rights reserved.
//

#import "SLSmallGiftControlView.h"
#import "SLSmallGiftView.h"
#import "NSTimer+MSBlock.h"

@class SLReceivedGiftModel;

@interface SLSmallGiftControlView ()

@property (nonatomic, strong) NSMutableArray<SLReceivedGiftModel*> *giftMessageQueue; // 管理小礼物的队列
@property (nonatomic, strong) NSMutableArray<SLReceivedGiftModel*> *giftMessageQueueTwo; // 第二个小礼物队列

@property (nonatomic, weak) SLSmallGiftView *giftView_1;
@property (nonatomic, weak) SLSmallGiftView *giftView_2;

@property (nonatomic, strong) SLReceivedGiftModel *giftModel_1; // 记录通道一的Model;
@property (nonatomic, strong) SLReceivedGiftModel *giftModel_2; // 记录通道二的Model;

@property (nonatomic,assign) BOOL isUpdateOne;
@property (nonatomic,assign) BOOL isUpdateTwo;


@end

@implementation SLSmallGiftControlView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        // init
        [self initData];
        [self initView];
    }
    
    return self;
}


- (void)initData
{
    _giftMessageQueue      = [NSMutableArray array];
    _giftMessageQueueTwo    = [NSMutableArray array];
    
    [self addObServers];
}


- (void)dealloc
{
    // 移除所有元素
    [self.giftMessageQueue removeAllObjects];
    self.giftMessageQueue = nil;
    
    [self.giftMessageQueueTwo removeAllObjects];
    self.giftMessageQueueTwo = nil;
    
    
    [self.giftView_1 removeFromSuperview];
    [self.giftView_2 removeFromSuperview];
    
    self.giftView_2 = nil;
    self.giftView_1 = nil;
    
    [self removeObs];
}


- (void)updatGifts
{
    
    @synchronized (self) {
        
        NSMutableArray<SLReceivedGiftModel*> *queue = _giftMessageQueue;
        if (!queue) return;
        
        if (queue.count <= 0 ) {
            return;
        }
        
        SLReceivedGiftModel *model = [queue objectAtIndex:0];
        if (model.num > 0) {
            _isUpdateOne = YES;
            [self showGiftView1:model];
            
        } else {
            [queue removeObject:model];
            [self updatGifts];
        }
       NSLog(@"[gx] updateGifts %d, %d, channel %d", model.num, model.double_hit, model.channel);
    }
}

- (void)updatGiftsTwo
{
    
    @synchronized (self) {
        NSMutableArray<SLReceivedGiftModel*> *queue = _giftMessageQueueTwo;
        if (!queue) return;
        
        if (queue.count <= 0 ) {
            return;
        }
        
        SLReceivedGiftModel *model = [queue objectAtIndex:0];
        if (model.num > 0) {
            _isUpdateTwo = YES;
            [self showGiftView2:model];
            
        } else {
            [queue removeObject:model];
            [self updatGiftsTwo];
        }
        
        NSLog(@"[gx] updatGiftsTwo %d, %d, channel %d", model.num, model.double_hit, model.channel);
    }
}


- (SLReceivedGiftModel *)getLastModel:(NSMutableArray<SLReceivedGiftModel*> *)queue
{
    if (queue == nil) {
        return nil;
    }
    
    if (queue.count == 0) {
        return nil;
    }
    
    SLReceivedGiftModel *model = [queue objectAtIndex:queue.count - 1];
    return model;
}


-(int) getQueueGiftCount:(NSMutableArray<SLReceivedGiftModel*> *)queue
{
    int giftCount = 0;
    if (queue == nil) {
        return 0;
    }
    
    for (int i = 0; i < queue.count; i++) {
        SLReceivedGiftModel *model = [queue objectAtIndex:i];
        giftCount += model.num;
    }
    
    return giftCount;
}

// 添加
- (void)addGift2QueueWithModel:(SLReceivedGiftModel *)model{
    
    @synchronized (self) {
        
        NSLog(@"[gx] model.double click, %ld",(long)model.double_hit);
        SLReceivedGiftModel *model1 = [self getLastModel:_giftMessageQueue];
        SLReceivedGiftModel *model2 = [self getLastModel:_giftMessageQueueTwo];
        
        if (model1 == nil && model2 == nil) {
            model.channel = 1;
            [_giftMessageQueue addObject:model];
        } else if (model1 != nil && [model.giftUniTag isEqualToString :model1.giftUniTag]) {
            model1.num += model.num;
        } else if (model2 != nil && [model.giftUniTag isEqualToString :model2.giftUniTag]) {
            model2.num += model.num;
        } else {
            int channel1 = [self getQueueGiftCount:_giftMessageQueue];
            int channel2 = [self getQueueGiftCount:_giftMessageQueueTwo];
            
            if (channel1 < channel2) {
                model.channel = 1;
                [_giftMessageQueue addObject:model];
            } else {
                model.channel = 2;
                [_giftMessageQueueTwo addObject:model];
            }
        }
        
        if (!_isUpdateOne) {
            [self updatGifts];
        }
        
        if (!_isUpdateTwo) {
            [self updatGiftsTwo];
        }
        
        int delay = 2 + 0.5 * MAX([self getQueueGiftCount:_giftMessageQueue], [self getQueueGiftCount:_giftMessageQueueTwo]);
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(checkChannelState) object:nil];//可以取消成功。
        [self performSelector:@selector(checkChannelState) withObject:nil afterDelay:delay];
    }
}


- (void)checkChannelState {
    
    @synchronized (self) {
        int channel1 = [self getQueueGiftCount:_giftMessageQueue];
        int channel2 = [self getQueueGiftCount:_giftMessageQueueTwo];
        
        if (channel1 <= 0) {
            _isUpdateOne = NO;
        }
        
        if (channel2 <= 0) {
            _isUpdateTwo = NO;
        }
        
        NSLog(@"cj check small gift channel state %d, %d\n", channel1, channel2);
    }
    
}


- (void)addObServers  // 注册监听
{
    
    [[NSNotificationCenter defaultCenter] addObserver:self
     
                                             selector:@selector(keyboardWasShown:)
     
                                                 name:UIKeyboardWillShowNotification object:nil];
    
    //注册键盘消失的通知
    [[NSNotificationCenter defaultCenter] addObserver:self
     
                                             selector:@selector(keyboardWillBeHidden:)
     
                                                 name:UIKeyboardWillHideNotification object:nil];
}


- (void)removeObs  // 移除监听
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)initView
{
    [self initGiftView1];
    [self initGiftView2];
}

- (void)initGiftView1
{
    __weak SLSmallGiftControlView *WeakSelf = self;
    SLSmallGiftView *view = [[SLSmallGiftView alloc]initWithFrame:CGRectMake(-180, KScreenHeight * 0.40 + 39,178, 80/2.0)];  // 15
    
    self.giftView_1 = view;
    
    WeakSelf.giftView_1.shakeFinishCb = [self getGiftView1ShakeFinish];
    
    [self addSubview:self.giftView_1];
}

- (void)initGiftView2
{
    __weak SLSmallGiftControlView *WeakSelf = self;
    
    SLSmallGiftView *view = [[SLSmallGiftView alloc]initWithFrame:CGRectMake(-180, KScreenHeight * 0.40 + 40 + 46,178,80/2.0)];
    
    self.giftView_2 = view;
    WeakSelf.giftView_2.shakeFinishCb = [self getGiftView2ShakeFinish];
    
    [self addSubview:self.giftView_2];
    
}


- (void)removeObjectFromGiftMessageQueue:(NSMutableArray<SLReceivedGiftModel*> *)queue
{
    if (!queue) return;
    
    if (queue.count > 0)
        [queue removeObjectAtIndex:0];
}


/**
 展示礼物1️⃣
 
 @param model 礼物模型
 */
- (void)showGiftView1:(SLReceivedGiftModel *)model
{
    
    //    NSLog(@"ant3: view1 doubleHit = %d",model.double_hit);
    
    if (model.num >= 0) {
        // NSLog(@"通道1");
        self.giftModel_1 = model;
        [self.giftView_1 showGiftWithModel:_giftModel_1];
    }
    
    model.num -= 1;
    model.double_hit ++;
    
}

/**
 展示礼物2️⃣
 
 @param model 礼物模型
 */
- (void)showGiftView2:(SLReceivedGiftModel *)model
{
    NSLog(@"ant: view1 doubleHit = %ld",(long)model.double_hit);
    
    if (model.num >= 0) {
        // NSLog(@"通道2");
        self.giftModel_2 = model;
        [self.giftView_2 showGiftWithModel:_giftModel_2];
        
    }
    
    model.num -= 1;
    model.double_hit ++;
    
}


// 礼物通道一的label 动画结束回调
- (SLShakeFinish)getGiftView1ShakeFinish
{
    __weak SLSmallGiftControlView *WeakSelf = self;
    SLShakeFinish finish = ^(BOOL isFinish)
    {
        WeakSelf.isUpdateOne = NO;
        [WeakSelf updatGifts];
        
    };
    
    return finish;
}

// 礼物通道二的label 动画结束回调
- (SLShakeFinish)getGiftView2ShakeFinish
{
    __weak SLSmallGiftControlView *WeakSelf = self;
    SLShakeFinish finish = ^(BOOL isFinish)
    {
       WeakSelf.isUpdateTwo = NO;
        [WeakSelf updatGiftsTwo];
        
    };
    
    return finish;
}

#pragma mark -- 监听键盘事件

- (void)keyboardWasShown:(NSNotification*)aNotification
{
    self.giftView_1.mj_y = KScreenHeight * 0.45 + 15 - 258;
    
    self.giftView_2.mj_y = KScreenHeight * 0.45 + 15 + 47 - 258;
}


-(void)keyboardWillBeHidden:(NSNotification*)aNotification

{
    self.giftView_1.mj_y = KScreenHeight * 0.45 + 15;
    
    self.giftView_2.mj_y = KScreenHeight * 0.45 + 15 + 47;
}

@end

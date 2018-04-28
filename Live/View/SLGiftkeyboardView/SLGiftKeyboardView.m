//
//  SLGiftKeyboardView.m
//  ShowLive
//
//  Created by WorkNew on 2018/4/16.
//  Copyright © 2018年 VNing. All rights reserved.
//

#import "SLGiftKeyboardView.h"
#import "SLComboButton.h"
#import "SLTimeProduceTool.h"
#import "SLTagGiftsView.h"
#import "SLGiftButtonView.h"
#import "SLGiftListModel.h"

// 当前时间戳字符串
static NSString *currentTimeStr;

@interface SLGiftKeyboardView ()<SLTagGiftsViewDelegate>

/**
 待发送队列
 */
@property (nonatomic,strong) NSMutableArray *giftQueue;

@property(nonatomic,strong)UIView * bgView;

@property(nonatomic,strong)SLTagGiftsView * tagGiftView;

@property(nonatomic,strong)UIButton * sendButton;

@property(nonatomic,strong)SLComboButton * comboButton;

@property (nonatomic,strong)SLGiftButtonView *selectButton;

@property(nonatomic,strong)UIButton * topupButton;

@property(nonatomic,strong)UILabel * coinLabel;


//是否在发送
@property (nonatomic,assign) BOOL isSending;
//记录连击数量
@property (nonatomic,assign) int doubleHit;


@end
@implementation SLGiftKeyboardView

- (instancetype)init
{
    self = [super init];
    
    if (self) {

    }
    
    return self;
    
}

- (void)dealloc
{
    NSLog(@"[gx] giftkeyboard dealloc");
}


- (void)initData
{
    _isSending = NO;
    _doubleHit = 1;
    _giftQueue     = [[NSMutableArray alloc]init];
    
    [[NSUserDefaults standardUserDefaults] setObject:@(0) forKey:@"hall_flag"];

}


// 初始化子视图
- (void)initView
{
    [super initView];
    
    [self initData];
    [self addSubview:self.bgView];
    [self addSubview:self.tagGiftView];
    [self addSubview:self.sendButton];
    [self addSubview:self.comboButton];
    [self addSubview:self.topupButton];
    [self addSubview:self.coinLabel];

}

-(void)show
{
    [super show];
    
    [self refreshCoin:[NSString stringWithFormat:@"%@",[AccountModel shared].showCoinNum]];
}

-(void)topupClick:(UIButton*)sender
{
    [self hide];
    [PageMgr pushToWalletController];
}

//首先检查用户的资金是否够消费
-(void)sendButtonClick
{
    if (IsStrEmpty([AccountModel shared].showCoinNum)) {
        return;
    }
    
    if ([self isHaveEnoughCoin:1]) { // 账户余额为零
        
        UIAlertView * alert =[[UIAlertView alloc]initWithTitle:@"提示" message:@"余额不足,前往充值" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"立刻充值", nil];
        [alert show];
#pragma clang diagnostic pop
        
        return;
    }
    [self canSendGift];
}

-(void)canSendGift
{

    if (self.selectButton.giftModel.type == 1) {
        currentTimeStr = [NSString stringWithFormat:@"%lld",[SLTimeProduceTool getCurrentTimestamp]];
        [self sendSingle];
        self.sendButton.hidden = YES;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^
                       {
                           [self.comboButton show];
                       });
        
    }else
    {
        [self sendSingle];
    }
    
}

-(void)sendSingle
{
    if (!_selectButton.tag) return;
    SLGiftListModel *model = [[SLGiftListModel alloc] init];
    [model analysisGiftInfowithModel:_selectButton.giftModel];
    model.giftUniTag       = [NSString stringWithFormat:@"%@%ld",[AccountModel shared].uid,(long)model.id];
    model.doubleHit        = self.doubleHit;
  
    _isSending = YES;
    [self addGiftToQueue:model];
    if (_giftQueue.count >= 1) {
        
        [self sendGiftFormGiftQueue];
    }
}

- (BOOL)isHaveEnoughCoin:(NSInteger)number {
    
    return  [AccountUserInfoModel.showCoinNum integerValue] == 0 ||  [AccountUserInfoModel.showCoinNum integerValue] < self.selectButton.giftModel.price*number;
}

- (void)addGiftToQueue:(SLGiftListModel *)model {
    
    [_giftQueue addObject:model];
 
}

- (void)sendGiftFormGiftQueue{
    

    SLGiftListModel *model = _giftQueue[0];
    if (!model) {
        _isSending = NO;
    }
    
    [self sendGift:model];
    
}

- (void)sendGift:(SLGiftListModel *)model {
    
    NSLog(@"[gx] model. double hit %ldd",(long)model.doubleHit);
    __weak SLGiftKeyboardView *WeakSelf = self;
    [[SLGiftListManager shareInstance] sendGift:model liveModel:self.liveModel success:^(id obj) {
        
        NSString * currentCoin =[NSString stringWithFormat:@"%ld",[self calculationCoin:model.price*1]];
        [self refreshCoin:currentCoin];
        [AccountModel shared].showCoinNum = currentCoin;
        [[AccountModel shared] save];
        [WeakSelf removeGiftFromQueue];
        
        
    } faile:^(NSError * error) {
        [WeakSelf sendGiftError:error];
    }];

    
}

-(NSInteger)calculationCoin:(NSInteger)price
{
    NSInteger current = [[AccountModel shared].showCoinNum integerValue];
    NSInteger result = current - price;
    return (result>0)?result:0;
}

- (void)sendGiftError:(NSError *)error {
    
    [self removeGiftFromQueue];

}

//- (void)sendLocalmessage:(SLGiftListModel *)model num:(NSInteger) successNum doubleHit:(NSInteger)successDoubleHit{
//    
//
//    if (self.delegate && [self.delegate respondsToSelector:@selector(sendOutGiftSuccess:)]) {
//        
//        SLReceivedGiftModel *infoModel = [[SLReceivedGiftModel alloc]init];
//        infoModel.goods_id   = [NSString stringWithFormat:@"%ld",(long)model.id];
//        infoModel.head_photo = [AccountModel shared].avatar;
//        infoModel.level      = [[AccountModel shared].masterLevel integerValue];
//        infoModel.nickname   = [AccountModel shared].nickname;
//        infoModel.user_id    = [AccountModel shared].uid;
//        infoModel.goods_name = model.name;
//        infoModel.goods_pic  = model.image;
//        infoModel.num            = successNum;
//        infoModel.giftUniTag     = model.giftUniTag;
//        infoModel.animating_type = model.type;
//        infoModel.double_hit     = successDoubleHit;
//        infoModel.totlePrice     = model.price * successNum;
//        infoModel.price          = model.price;
//        [self.delegate sendOutGiftSuccess:infoModel];
//
//    }
//    
//}

- (void)removeGiftFromQueue{
    

    if (_giftQueue.count > 0) {
        
        [_giftQueue removeObjectAtIndex:0];
    }
    
    if (_giftQueue.count > 0){
        
        [self sendGiftFormGiftQueue];
        
    }else {
        
        _isSending = NO;
    }
}


- (void)removeAllFromQueue {
    if (_giftQueue.count > 0) {
        
        [_giftQueue removeAllObjects];
    }
}


- (SLComboButtonEvent)getFinishBlock {
    
    __weak SLGiftKeyboardView *WeakSelf = self;
    SLComboButtonEvent block = ^() {
        
        WeakSelf.doubleHit = 1;
        WeakSelf.sendButton.hidden = NO;
        NSLog(@"[gx] double hit hide %d",WeakSelf.doubleHit);
    };
    
    return block;
}

- (SLComboButtonEvent)getClickBlock {
    
    __weak SLGiftKeyboardView *WeakSelf = self;
    SLComboButtonEvent block = ^(){
        
        [WeakSelf jitterView:WeakSelf.comboButton];

        WeakSelf.doubleHit ++;
        NSLog(@"[gx] double hit %d",WeakSelf.doubleHit);
        if (!WeakSelf.selectButton.tag) return;
        
        SLGiftListModel *model = [[SLGiftListModel alloc]init];
        [model analysisGiftInfowithModel: WeakSelf.selectButton.giftModel];
        
        model.doubleHit        = WeakSelf.doubleHit;
        model.giftUniTag       = [NSString stringWithFormat:@"%@%ld",[AccountModel shared].uid,(long)model.id];
 
        [self addGiftToQueue:model];
   
        if (WeakSelf.giftQueue.count >0 && !WeakSelf.isSending) {
        
            WeakSelf.isSending = YES;
            [self sendGiftFormGiftQueue];
            
        }
        
    };
    
    return block;
}

//视图抖动效果
-(void)jitterView:(id)view {
    
    CABasicAnimation*pulse = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    pulse.timingFunction= [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    pulse.duration = 0.15;
    pulse.repeatCount= 1;
    pulse.autoreverses= YES;
    pulse.fromValue= [NSNumber numberWithFloat:1.1];
    pulse.byValue = [NSNumber numberWithFloat:0.97];
    pulse.byValue = [NSNumber numberWithFloat:1.02];
    pulse.byValue = [NSNumber numberWithFloat:0.98];
    pulse.toValue = [NSNumber numberWithFloat:0.7];
    [[view layer]addAnimation:pulse forKey:nil];
}

- (void)selectedGift:(SLGiftButtonView*)sender
{
    _sendButton.enabled  = YES;
   
    [_sendButton setBackgroundColor:[UIColor orangeColor]
                           forState:UIControlStateNormal];
    
    [self.comboButton hide];
    
    if (self.selectButton.tag != sender.tag) {
        sender.isSelected        = YES;
        _selectButton.isSelected = NO;
        _selectButton            = sender;
    }

    [[NSUserDefaults standardUserDefaults] setObject:@(0) forKey:@"hall_flag"];
    
}

-(void)refreshCoin:(NSString*)coin
{

    self.coinLabel.text = [NSString stringWithFormat:@"%@秀币",coin];
}


-(UIView*)bgView
{
    if (!_bgView) {
        _bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.width, 268+KTabbarSafeBottomMargin)];
        _bgView.backgroundColor = [Color(@"000000") colorWithAlphaComponent:0.7];
        _bgView.clipsToBounds = NO;
       
    }
    return _bgView;
}
-(SLTagGiftsView*)tagGiftView
{
    if (!_tagGiftView) {
        _tagGiftView =  [[SLTagGiftsView alloc]initWithFrame:CGRectMake(0, 40, KScreenWidth, 188)];
        
        _tagGiftView.delegate = self;
    }
    return _tagGiftView;
}

-(UIButton*)topupButton
{
    if (!_topupButton) {
        _topupButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _topupButton.frame = CGRectMake(10,228,64, 36);
        _topupButton.titleLabel.font = [UIFont systemFontOfSize:13];
        [_topupButton setTitle:@"首冲 >" forState:UIControlStateNormal];
        [_topupButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_topupButton setBackgroundColor:[UIColor clearColor] forState:UIControlStateNormal];
        [_topupButton addTarget:self action:@selector(topupClick:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _topupButton;
}

-(UILabel*)coinLabel
{
    if (!_coinLabel) {
        _coinLabel = [[UILabel alloc]initWithFrame:CGRectMake(84, 228, 100, 36)];
        _coinLabel.font = [UIFont systemFontOfSize:13];
        _coinLabel.textColor = [UIColor whiteColor];
        _coinLabel.textAlignment = NSTextAlignmentLeft;
        _coinLabel.backgroundColor = [UIColor clearColor];
   
    }
    return _coinLabel;
}


-(UIButton*)sendButton
{
    if (!_sendButton) {
        _sendButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _sendButton.frame = CGRectMake(self.width - 15 - 64,228,64, 36);
        _sendButton.titleLabel.font = [UIFont systemFontOfSize:13];
        [_sendButton setTitle:@"发送" forState:UIControlStateNormal];
        [_sendButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_sendButton setBackgroundColor:[UIColor orangeColor] forState:UIControlStateHighlighted];
        [_sendButton setBackgroundColor:[UIColor orangeColor] forState:UIControlStateDisabled];
        [_sendButton setBackgroundColor:[UIColor orangeColor] forState:UIControlStateNormal];
         _sendButton.enabled = NO;
         _sendButton.layer.cornerRadius = 18;
         _sendButton.clipsToBounds  = YES;
        [_sendButton addTarget:self action:@selector(sendButtonClick) forControlEvents:UIControlEventTouchUpInside];
  
    }
    return _sendButton;
}

-(SLComboButton*)comboButton
{
    if (!_comboButton) {
        _comboButton = [[SLComboButton alloc]initWithFrame:CGRectMake(self.width - 84 -10 ,
                                                                     268 - 84 - 7,
                                                                      0,
                                                                      0)];
        _comboButton.clickBlock  = [self getClickBlock];
        _comboButton.finishBlock = [self getFinishBlock];
      
    }
    return _comboButton;
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        [self hide];
        [PageMgr pushToWalletController];
    }
}
@end

//
//  SLLiveBaseViewController.m
//  ShowLive
//
//  Created by gongxin on 2018/4/13.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "SLLiveBaseViewController.h"
#import "SLLiveMoreView.h"

#import "SLChatRoomView.h"
#import "SLShareView.h"
#import "SLInputView.h"
#import "SLSmallGiftControlView.h"
#import "SLLiveChatVC.h"
#import "SLGiveLikeAction.h"
#import "SLPiaoAction.h"
#import "SLPushManager.h"

@interface SLLiveBaseViewController ()<UIGestureRecognizerDelegate,SLLiveBottomViewProtocol,SLInputDelegate,SLGiftKeyBoardSendDelegate>

@property(nonatomic,assign)BOOL fullScreen; //是否横屏显示
@property(nonatomic,assign)BOOL screenClear; //是否清屏

@property(nonatomic,strong)SLLiveMoreView * moreView;
@property(nonatomic,strong)SLShareView * shareView;
@property(nonatomic,strong)SLInputView * inputView;
@property(nonatomic,strong)SLSmallGiftControlView * smallGiftView;


@property(nonatomic,copy)NSString * liveId;
@property(nonatomic,copy)NSString * anchorId;

@end

@implementation SLLiveBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}
- (void)dealloc
{
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}
- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];

}
-(void)initConfig
{
    // 保持屏幕常亮
    [[UIApplication sharedApplication] setIdleTimerDisabled:YES];
    //隐藏顶部视图
    [self.navigationBarView setNavigationBarHidden:YES animted:NO];
    
}
-(void)addChildView
{
  
    [self.controlView addSubview:self.smallGiftView];
    [self.controlView addSubview:self.barrageView];
    [self.controlView addSubview:self.rightView];
    [self.controlView addSubview:self.bottomView];
    [self.controlView addSubview:self.inputView];
    self.inputView.delegate = self ;
    [self.view addSubview:self.controlView];
    [self.view addSubview:self.backButton];
    
}

-(void)removeChildView
{
    [self.smallGiftView removeFromSuperview];
    [self.barrageView removeFromSuperview];
    [self.rightView removeFromSuperview];
    [self.bottomView removeFromSuperview];
    [self.inputView removeFromSuperview];
    self.smallGiftView = nil;
    self.barrageView= nil;
    self.rightView= nil;
    self.bottomView= nil;
    self.inputView= nil;

}

-(void)disMissView
{
    [self.moreView disMiss];
    [self.keyboardView disMiss];
    [self.shareView disMiss];
    [self.rightView disMissMemberListView];
    [self.privateChatVC hideWithAnimation:NO];
    
    [self.inputView endEditing:YES];
}

//清屏
-(void)clearScreen
{
    UIPanGestureRecognizer * panGesture = [[UIPanGestureRecognizer alloc]
                                           initWithTarget:self action:@selector(panGestureAction:)];
    panGesture.delegate = self;
    [self.view addGestureRecognizer:panGesture];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    [self.inputView endEditing:YES];
}
-(void)setliveId:(NSString*)liveId
        anchorId:(NSString*)anchorId
{
    _liveId = liveId;
    _anchorId = anchorId;
}

#pragma mark -- BottomViewDelegate
-(void)selectBottomViewAtIndex:(SLBottomButtonClickType)type
{
    switch (type) {
        case SLBottomButtonClickTypeChat:
        {
            [self.inputView beginChat];
        }
            break;
        case SLBottomButtonClickTypeGift:
        {
            [self.keyboardView show];
       
        }
            break;
            case SLBottomButtonClickTypeBeauty:
        {
            if ([[SLPushManager shareInstance] beautifyOpen]) {
                [[SLPushManager shareInstance] clearBeautify];
            }else
            {
                [[SLPushManager shareInstance] startBeautify];
            }
        }
            break;
            case SLBottomButtonClickTypeShare:
        {
            [self.shareView show];
        }
            break;
        case SLBottomButtonClickTypeMessage:
        {
            [self.privateChatVC show];
        }
            break;
        case SLBottomButtonClickTypeLike:
        {
            [self like];
        }
            break;
            case SLBottomButtonClickTypeMore:
        {
            [self.moreView show];
        }
            break;
        default:
            break;
    }
}

-(void)like
{
    SLGiveLikeAction * action = [SLGiveLikeAction action];
    action.tId = self.anchorId;
    action.roomId = self.liveId;
    [self sl_startRequestAction:action Sucess:^(id result) {

    } FaildBlock:^(NSError *error) {
   
    }];
    
}

-(void)sendBarrage:(NSString*)content
{
    SLPiaoAction * action = [SLPiaoAction action];
    action.content = content;
    action.roomId = self.liveId;
    [self sl_startRequestAction:action Sucess:^(id result) {
     
    } FaildBlock:^(NSError *error) {
        
    }];
}

-(void)danmu:(SLShoutModel*)model
{
    [self.barrageView addShout2QueueWithModel:model];
    [self.barrageView showShout];
}

- (SLLiveChatVC *)privateChatVC{
    if(!_privateChatVC){
        _privateChatVC = [SLLiveChatVC showInView:self];
    }
    return _privateChatVC;
}

- (void)giftAnimation:(SLReceivedGiftModel *)model
{
    switch (model.animating_type) {
        case SLAnimatingTypeDoubleHit:
        {
             [self.smallGiftView addGift2QueueWithModel:model];
        }
            break;
            
        default:
            break;
    }
}
#pragma mark -- inputView Delegate
- (void)showInputView
{
    [self.rightView setRightViewHide:YES];
}
- (void)hideInputView
{
    [self.rightView setRightViewHide:NO];
}
#pragma mark -- Gift Delegate
- (void)sendOutGiftSuccess:(SLReceivedGiftModel *)model
{
     [self giftAnimation:model];
}
#pragma mark GestureRecognizer

- (void)panGestureAction:(UIPanGestureRecognizer *)sender
{
    if (_fullScreen==YES) {
        return;
    }
    
    UIPanGestureRecognizer *pan = (UIPanGestureRecognizer *)sender;
    static CGPoint benginPanPoint;
    static CGFloat panViewX;
    
    switch (sender.state) {
        case UIGestureRecognizerStateBegan:
        {
            benginPanPoint = [pan locationInView:self.view.window];
            panViewX = self.controlView.frame.origin.x;
        }
            break;
        case UIGestureRecognizerStateChanged:
        {
            CGPoint translation =  [pan translationInView:self.view.window];
            CGFloat tx = fabs(translation.x);
            CGFloat ty = fabs(translation.y);
            if (tx > ty) {
                
                if (translation.x > 0 ||(_screenClear==YES&&translation.x<0) ) {
                    CGPoint endPanPoint = [pan locationInView:self.view.window];
                    CGFloat detalx = endPanPoint.x - benginPanPoint.x;
                    CGFloat destX = panViewX + detalx;
                    CGRect frame = self.controlView.frame;
                    frame.origin.x = destX;
                    self.controlView.frame = frame;
                }
            }
            
            
        }
            break;
        case UIGestureRecognizerStateEnded:
        {
            CGPoint point =  [pan translationInView:self.view.window];
            
            //1 偏移量满足，并且没有清屏
            //2 偏移量不满足 并且已经清屏
            //以上两种情况执行清屏，反之执行还原视图
            if (([self offsetMeet:point]&&point.x>0)||([self offsetMeet:point]==NO&&_screenClear==YES)) {
                
                //清屏
                [self clearTheScreen];
                
            }else
            {
                //视图还原
                [self reductionTheScreen];
            }
            
        }
            break;
        default:
            break;
    }
    
    
}

-(BOOL)offsetMeet:(CGPoint)point;
{
    return (point.x>kScreenWidth/4||point.x<-kScreenWidth/4||point.x==kScreenWidth/4||point.x==-kScreenWidth/4)?YES:NO;
}

//清屏动画
-(void)clearTheScreen
{
    @weakify(self);
    [UIView animateWithDuration:0.25 animations:^{
        @strongify(self);
        self.controlView.frame = CGRectMake(kScreenWidth, 0, kScreenWidth, kScreenHeight);
       
        
    } completion:^(BOOL finished) {
        @strongify(self);
        self.screenClear = YES;
    }];
}

//还原动画
-(void)reductionTheScreen
{
    @weakify(self);
    [UIView animateWithDuration:0.25 animations:^{
        @strongify(self);
        self.controlView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
   
        
    } completion:^(BOOL finished) {
        @strongify(self);
        self.screenClear = NO;
    }];
}

#pragma mark -- setter getter 
-(void)setControllerType:(SLLiveContollerType)controllerType
{
    _controllerType = controllerType;
    self.rightView.controllerType = controllerType;
    self.bottomView.controllerType = controllerType;
}
-(UIButton*)backButton
{
    if (!_backButton) {
        
        _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _backButton.frame = CGRectMake(10,KNaviBarSafeBottomMargin+20,44, 44);
        [_backButton setImage:[UIImage imageNamed:@"live_finish_back"] forState:UIControlStateNormal];
        
    }
    
    return _backButton;
}

-(SLLiveRightView*)rightView
{
    if (!_rightView) {
        _rightView=[[SLLiveRightView alloc]initWithFrame:CGRectMake(KScreenWidth-60,KScreenHeight-KTabbarSafeBottomMargin-520, 60,390)];
    }
    return _rightView;
}

-(SLLiveBottomView*)bottomView
{
    if (!_bottomView) {
        _bottomView = [[SLLiveBottomView alloc]initWithFrame:CGRectMake(0, kScreenHeight-100-KTabbarSafeBottomMargin,KScreenWidth,100+KTabbarSafeBottomMargin)];
        _bottomView.protocol= self;
        
    }
    return _bottomView;
}

-(SLControlView*)controlView
{
    if (!_controlView) {
        _controlView = [[SLControlView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    }
    return _controlView;
}

-(SLInputView*)inputView
{
    if (!_inputView) {
        
        CGRect inputViewRect = CGRectMake(0,kScreenHeight, kScreenWidth, 50);
        _inputView   = [[SLInputView alloc]initWithFrame:inputViewRect];
        _inputView.delegate = self;
        
    }
    return _inputView;
}

-(SLLiveMoreView*)moreView
{
    if (!_moreView) {
        _moreView = [[SLLiveMoreView alloc]initWithSuperView:self.view
                                           animationTravel:0.1
                                                viewHeight:184+KTabbarSafeBottomMargin];
    }
    return _moreView;
}

-(SLShareView*)shareView
{
    if (!_shareView) {
        _shareView = [[SLShareView alloc]initWithSuperView:self.view
                                           animationTravel:0.1
                                                viewHeight:236+KTabbarSafeBottomMargin];
    }
    return _shareView;
}


-(SLGiftKeyboardView*)keyboardView
{
    if(!_keyboardView)
    {
        _keyboardView = [[SLGiftKeyboardView alloc]initWithSuperView:self.view
                                                     animationTravel:0.1
                                                          viewHeight:268+KTabbarSafeBottomMargin];
        _keyboardView.delegate =self;
    }
    return _keyboardView;
}

-(SLSmallGiftControlView*)smallGiftView
{
    if (!_smallGiftView) {
        _smallGiftView = [[SLSmallGiftControlView alloc]initWithFrame:self.view.bounds];
    
    }
    return _smallGiftView;
}

-(SLBarrageView*)barrageView
{
    if (!_barrageView) {
        _barrageView = [[SLBarrageView alloc]initWithFrame:self.view.bounds];
    
    }
    return _barrageView;
}


/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end

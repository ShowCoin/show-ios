//
//  SLLiveViewController.m
//  ShowLive
//
//  Created by WorkNew on 2018/4/12.
//  Copyright © 2018年 VNing. All rights reserved.
//

#import "SLLiveViewController.h"
#import "SLLiveViewController+Notification.h"
#import "SLLiveViewController+Request.h"
#import "SLLivePreView.h"

#import "SLLiveFinishView.h"
#import "SLChatRoomView.h"

#import "SLPushManager.h"
#import "SLMemberListSortManager.h"
#import "SLPiaoAction.h"
#import "SLShutUpAction.h"

#import "SLChatRoomMessageManager.h"

@interface SLLiveViewController ()<SLLivePreViewDelete,SLPushManagerProtocol,SLChatRoomMessageDelegate>

@property(nonatomic,strong)SLLivePreView *  preView;
@property(nonatomic,strong)SLLiveFinishView * finishView;
@property(nonatomic,assign)SLLivePushState  pushState;
@property(nonatomic,assign)SLLiveFinishType finishType;
@property(nonatomic,strong)SLChatRoomView * chatView;
@end

@implementation SLLiveViewController
- (void)dealloc
{
    
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if(!(PageMgr.currentRootIndex ==RootIndexCamera ||( PageMgr.isRootScrolling && PageMgr.currentRootIndex !=RootIndexCamera))){
        return;
    }
    NSLog(@"##### ----------2222---------");
    if(PageMgr.currentRootIndex ==RootIndexCamera ||( PageMgr.isRootScrolling && PageMgr.currentRootIndex !=RootIndexCamera ) ||self.presentingViewController){
        [[UIApplication sharedApplication] setStatusBarHidden:YES];
    }else{
        if (!([PageMgr hasNoNextControllerInCurrentTab] && PageMgr.currentRootIndex ==RootIndexTab)) {
            [[UIApplication sharedApplication] setStatusBarHidden:NO];
        }
    }
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    if(!(PageMgr.currentRootIndex ==RootIndexCamera ||( PageMgr.isRootScrolling && PageMgr.currentRootIndex !=RootIndexCamera))){
        return;
    }

}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initConfig];
    [self initPusher];
    
}
-(void)sendText:(NSString*)text
isPay:(BOOL)isPay{
    
    if(IsStrEmpty(text))
    {
        [HDHud _showMessageInView:[UIApplication sharedApplication].keyWindow title:@"禁止发送空白消息"];
        return  ;
    }
    
    if(text.length >40){
        [HDHud _showMessageInView:[UIApplication sharedApplication].keyWindow title:@"最多只允许输入40个字"];
        return  ;
    }
    
    if(isPay){
        
        [self sendBarrage:text];
        
    }else{
        [self.chatView sendText:text];
    }
    
}

-(void)inputViewHeightChange:(CGFloat)height{
    [self.chatView changeFrameYConstraints:height UIView:self.controlView];
    [self.barrageView showToBottomHeight:height-49];
    
}

#pragma mark -- Work
-(void)initPusher
{
    self.pushState = SLLivePushStatePrepare;
    [self.view addSubview:self.preView];
    [[SLPushManager shareInstance] startCarema];
    [[SLPushManager shareInstance] startPreview:self.preView];
    
    
}
-(void)startPush:(NSString*)url
{
    if(IsStrEmpty(url))
    {
        [HDHud showHUDInView:self.view title:@"error rtmp is nil"];
        return;
    }
    //设置推流配置
    [[SLPushManager shareInstance] setupConfig:url];
    [[SLPushManager shareInstance] startPush];
    [SLPushManager shareInstance].protocol = self;
}

-(void)LinkSusses
{
    self.pushState = SLLivePushStateStart;
    
    [self addLiveNotification]; //切换后台的监听
    
    @weakify(self);
    [self liveOpen:self.startModel.streamName success:^(id obj) {
        @strongify(self);
        [self.rightView getMemberList:self.startModel.roomId];
    } faile:^(NSError * error) {
        @strongify(self);
        self.finishType = SLLiveFinishTypeLiveOpenFail;
        [self stopLive];
    }];
    
}

-(void)stopLive
{
    _living = NO;
    
    
    [[SLPushManager shareInstance] stopCarema];
    [[SLPushManager shareInstance] stopPush];
    
    [self.chatView quiteChatRoomSucess:nil faild:nil];
    [self.chatView.chatIMMangger removeLastObjeserver];
    [[SLChatRoomMessageManager shareInstance] removeChatRoomMessageNotification];
    [self removeLiveNotification];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        self.preView = nil;
        [self disMissView];
        [self removeChildView];
        [self.finishView showOnView:self.view reason:self.finishType model:self.startModel];
    });
    
    
}

-(void)addTouchEvent
{
    [self.backButton addTarget:self action:@selector(confirmStopLive) forControlEvents:UIControlEventTouchUpInside];
    [self.finishView.backButton addTarget:self action:@selector(closeLive) forControlEvents:UIControlEventTouchUpInside];
}

-(void)closeLive
{
    [[SLPushManager shareInstance] stopCarema];
    [self.navigationController popViewControllerAnimated:NO];
}

-(void)confirmStopLive
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"确定结束直播吗?" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSLog(@"The \"Okay/Cancel\" alert's cancel action occured.");
    }];
    @weakify(self);
    UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        @strongify(self);
        self.finishType = SLLiveFinishTypeNormal;
        [self stopLive];
        
    }];
    
    [alertController addAction:cancelAction];
    [alertController addAction:otherAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

-(void)startLive:(NSString*)theme
{
    self.controllerType = SLLiveContollerTypeLive;
    [self addChildView];
    [self clearScreen];
    [self addTouchEvent];
    [self.rightView setAvatar:[AccountModel shared].avatar];
    [self.rightView updateWatches:@"0"];
    [self.rightView setAnchorId:[AccountModel shared].popularNo];
    [self.rightView updateCoin:[AccountModel shared].receive];
    [self.bottomView setAnchorNickName:[AccountModel shared].nickname liveTheme:theme];
}
-(void)startLiveSussces:(SLLiveStartModel*)model;
{
    _living = YES;
    self.startModel = model;
    [self startPush:model.rtmp];
    [self joinChatRoom:model.roomId];
    [self setliveId:model.roomId anchorId:[AccountModel shared].uid];
    
}

-(void)joinChatRoom:(NSString*)liveid
{
    NSDictionary *dict = @{@"vid":liveid,
                           @"live":@"1",
                           @"roomId":liveid,
                           @"ismaster":@(YES)
                           };
    [SLChatRoomMessageManager shareInstance].roomId = liveid;
    //注册聊天室消息监听
    [[SLChatRoomMessageManager shareInstance] addChatRoomMessageNotification];
    [SLChatRoomMessageManager shareInstance].delegate = self;
    //加入聊天
    self.chatView = [SLChatRoomView showInView:self.controlView Paramters:dict];
}


#pragma mark -- pushState delegate
-(void)pushEvent:(CNC_Ret_Code)code
{
    
    switch (code) {
        case CNC_RCode_Pushstream_Success:
        {
            NSLog(@"[gx] 连接成功");
            if (self.pushState == SLLivePushStatePrepare) {
                [self LinkSusses];
            }
            
        }
            break;
        case  CNC_RCode_Push_Disconnect:
        {
            NSLog(@"[gx] 推流断开连接");
            if (self.pushState==SLLivePushStateStart) {
                self.finishType = SLLiveFinishTypeConnectFail;
                [self stopLive];
            }
            
        }
            break;
            case CNC_RCode_Push_Connect_Fail:
        {
            if (self.pushState==SLLivePushStateStart) {
                self.finishType = SLLiveFinishTypeConnectFail;
                [self stopLive];
            }
        }
            break;

        default:
            break;
    }
}

#pragma mark --聊天室消息
-(void)updateWatches:(NSString*)watches
{
    [self.rightView updateWatches:watches];
}
-(void)updateCoin:(NSString*)coin
{
    [self.rightView updateCoin:coin];
}

-(void)updateMemberList:(NSArray*)memberList
total:(NSString*)total
{
    [self.rightView updateMemberList:memberList];
    [self.rightView updateWatches:total];
}

- (void)receiveGift:(SLReceivedGiftModel *)giftModel {
    
    [self giftAnimation:giftModel];
    [self.rightView addCoin:giftModel.totlePrice];
    
}

-(void)showShout:(SLShoutModel *)model
{
    [self danmu:model];
}
-(void)notice:(NSString*)content
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"通知" message:content preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {}];
    [alertController addAction:cancelAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark --setter getter
-(SLLivePreView*)preView
{
    if (!_preView) {
        _preView = [[SLLivePreView alloc]initWithFrame:self.view.bounds];
        _preView.delegate = self;
    }
    return _preView;
}

-(SLLiveFinishView*)finishView
{
    if (!_finishView) {
        _finishView = [[SLLiveFinishView alloc]initWithFrame:self.view.bounds];
    }
    return _finishView;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

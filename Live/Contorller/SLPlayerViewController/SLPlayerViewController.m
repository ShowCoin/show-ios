//
//  SLPlayerViewController.m
//  ShowLive
//
//  Created by WorkNew on 2018/4/9.
//  Copyright © 2018年 VNing. All rights reserved.
//

#import "SLPlayerViewController.h"
#import "SLPlayerManager.h"

#import "SLLiveFinishView.h"
#import "SLLiveLoadingView.h"

#import "SLLiveStatusAction.h"
#import "SLLiveStatusModel.h"
#import "SLChatRoomView.h"

#import "SLGiftAction.h"
#import "SLGiftListModel.h"
#import "SLPiaoAction.h"

#import "SLGiftListManager.h"
#import "SLChatRoomMessageManager.h"
#import "SLNetStatusManager.h"
#import "SLBaseModalView.h"
@interface SLPlayerViewController ()<SLPlayerStateProtocol,SLChatRoomMessageDelegate>

@property(nonatomic,strong)SLLiveFinishView * finishView;
@property(nonatomic,strong)SLLiveLoadingView * loadingView;
@property(nonatomic,strong)SLChatRoomView *chatRoomView;

@property (nonatomic,assign) BOOL isPlaySuccess; //拉流成功标志

@end

@implementation SLPlayerViewController
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    [SLChatRoomMessageManager shareInstance].delegate = nil;
    [SLPlayerManager shareManager].protocol = nil;
    NSLog(@"[gx] playervc dealloc");
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationBarView setNavigationBarHidden:YES animted:NO] ;
    
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = kThemeWhiteColor;
    //添加子视图
    self.controllerType = SLLiveContollerTypePlayer;
    [self addChildView];
    [self addTouchEvent];
    [self showLoadinView:@"加载中..."];
}

-(void)netWorkCheck
{
    @weakify(self);
    [[SLNetStatusManager shareInstance] getNetWorkStausAndIsContinue:^(BOOL isContinue) {
        @strongify(self);
        if (isContinue==NO) {
            [self closeButtonClick:nil];
        }else
        {
            [[SLPlayerManager shareManager] reloadUrl:[NSURL URLWithString:self.listModel.stream_addr]];
        }
    }];
}

-(void)showLoadinView:(NSString*)text
{
    
    [self.loadingView showLoadingCover:self.listModel.master.avatar text:text view:self.view];
    [self.loadingView.closeButton addTarget:self action:@selector(closeButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)hideLoadingView
{
    [self.loadingView removeLoading];
}


-(void)getLiveStatus:(NSString*)anchorid
{
    SLLiveStatusAction * action = [SLLiveStatusAction action];
    action.uid = anchorid; //主播id
    action.modelClass =SLLiveStatusModel.self;
    @weakify(self);
    [self sl_startRequestAction:action Sucess:^(SLLiveStatusModel *model) {
        @strongify(self);
        switch (model.status) {
            case 0: //直播关闭
            {
                //直播结束
                [self livefinish:model];
            }
                break;
            case 1: //直播结束
            {
                switch (model.stream_status) {
                    case 1:  //直播正常
                    {
                        [self joinChatRoom];
                    }
                        break;
                    case 2: //直播中断
                    {
                        [self joinChatRoom];
                        [self showLoadinView:@"主播暂时离开"];
                    }
                        break;
                    case 3: //直播恢复
                        
                    {
                        [self joinChatRoom];
                    }
                        break;
                    case 4: //流结束
                    {
                        //直播结束
                        [self livefinish:model];
                    }
                        break;
                    default:
                        break;
                }
            }
                break;
            default:
                break;
        }
        
    } FaildBlock:^(NSError *error) {
        
    }];
}

-(void)livefinish:(SLLiveStatusModel *)model
{
    [self leavaRoom];
    SLFinishModel * finishModel = [[SLFinishModel alloc]init];
    finishModel.duration = model.duration;
    finishModel.viewed = model.viewed;
    finishModel.liked   = model.liked;
    finishModel.receive = model.receive;
    [self.finishView showOnView:self.view finishModel:finishModel liveModel:self.listModel];
}

-(void)joinChatRoom
{
    NSDictionary *dict = @{@"vid":self.listModel.room_id,
                           @"live":self.listModel.is_live,
                           @"roomId":self.listModel.room_id,
                           @"ismaster":@(NO),
                           @"master":self.listModel.master
                           };
    //注册聊天室消息监听
    [SLChatRoomMessageManager shareInstance].roomId = self.listModel.room_id;
    [[SLChatRoomMessageManager shareInstance] addChatRoomMessageNotification];
    [SLChatRoomMessageManager shareInstance].delegate = self;
    self.chatRoomView = [SLChatRoomView showInView:self.controlView Paramters:dict];
    @weakify(self);
    self.chatRoomView.shareBlock  =^{
        @strongify(self);
        [self selectBottomViewAtIndex:SLBottomButtonClickTypeShare];
    };
    
}


-(void)sendText:(NSString*)text
          isPay:(BOOL)isPay{
    
    if(isPay){
        
        [self sendBarrage:text];
        
    }else{
        [self.chatRoomView sendText:text];
    }
    
}

-(void)inputViewHeightChange:(CGFloat)height{
    
    [self.chatRoomView changeFrameYConstraints:height UIView:self.controlView];
    [self.barrageView showToBottomHeight:height-49];
}

-(void)addTouchEvent
{
    [self.backButton addTarget:self action:@selector(closeButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.finishView.backButton addTarget:self action:@selector(closeButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)leavaRoom
{
    [self disMissView];
    [self.chatRoomView quiteChatRoomSucess:nil faild:nil];
    [self.chatRoomView.chatIMMangger removeLastObjeserver];
    [[SLPlayerManager shareManager] destroyPlayer];
}


#pragma mark Player methods
-(void)playVideoWithUrl:(NSString*)url
{
    if(IsStrEmpty(url))
    {
        [HDHud showHUDInView:self.view title:@"error rtmp is nil"];
        return;
    }
    [[SLPlayerManager shareManager] initPlayerWithView:self.view url:[NSURL URLWithString:url]];
    [[SLPlayerManager shareManager] installMovieNotificationObservers];
    [SLPlayerManager shareManager].protocol = self;
    [[SLPlayerManager shareManager] prepareToPlay];
    
}
#pragma mark -- chatroom message
-(void)anchorOut
{
    [self showLoadinView:@"主播暂时离开"];
}
-(void)anchorBack
{
    [self hideLoadingView];
}
-(void)finishLive:(SLFinishModel*)finishModel
{
    [self leavaRoom];
    [self.finishView showOnView:self.view finishModel:finishModel liveModel:self.listModel];
}

-(void)updateMemberList:(NSArray*)memberList
                  total:(NSString*)total
{
    [self.rightView updateMemberList:memberList];
    [self.rightView updateWatches:total];
    
}
-(void)receiveGift:(SLReceivedGiftModel*)giftModel
{
    [self giftAnimation:giftModel];
    [self.rightView addCoin:giftModel.totlePrice];
}

-(void)showShout:(SLShoutModel *)model
{
    [self danmu:model];
}
#pragma mark player delegate
-(void)firstVideoFrameRendered
{
    NSLog(@"[gx] firstVideoFrameRendered");
    _isPlaySuccess = YES;
    
    [self hideLoadingView];
    [self clearScreen];
    
}
#pragma mark -- tap  click
-(void)closeButtonClick:(UIButton*)sender;
{
    [self leavaRoom];
    [self.navigationController popViewControllerAnimated:NO];
}


#pragma mark -- setter and getter
-(void)setListModel:(SLLiveListModel *)listModel
{
    _listModel = listModel;
    self.masterModel = listModel.master;
    self.keyboardView.liveModel = listModel;
    
    [self setliveId:listModel.room_id anchorId:listModel.master.uid];
    //拉流
    [self playVideoWithUrl:listModel.stream_addr];
    [self.rightView updateData:listModel];
    [self getLiveStatus:listModel.master.uid];
    [self.rightView getMemberList:listModel.room_id];
    [self.bottomView setAnchorNickName:listModel.master.nickname liveTheme:listModel.title];
    
}

-(SLLiveLoadingView*)loadingView
{
    if (!_loadingView) {
        _loadingView = [[SLLiveLoadingView alloc]initWithFrame:self.view.bounds];
        _loadingView.backgroundColor = randomColor;
    }
    return _loadingView;
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

//
//  SLLiveChatVC.m
//  ShowLive
//
//  Created by zhangxinggong on 2018/4/19.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "SLLiveChatVC.h"
#import "SLMessageListCell.h"
#import "SLPrivateChatViewController.h"
#import "SLPrivateChatViewController+SLAdjustLiveChatPrivate.h"
#import "SLLiveListModel.h"
#import "SLPrivateChatViewController+InputView.h"

static UIWindow *currentWindow ;

@interface SLLiveChatVC ()

@property (strong,nonatomic)UIView *headerView;
@property (strong,nonatomic)UIWindow *window ;
@property (strong,nonatomic)ShowUserModel *master;
@property (strong,nonatomic)SLPrivateChatViewController *privateVC;
@property (assign,nonatomic)BOOL isShowing;

@end

@implementation SLLiveChatVC

+ (instancetype )showInView:(UIViewController *)fatherVC model:(ShowUserModel *)master{

    if(!currentWindow){
        currentWindow = [UIApplication sharedApplication].keyWindow;
    }
    
    SLLiveChatVC *chatVC = [[SLLiveChatVC alloc]init];
    UIWindow *myWindow = [[UIWindow alloc]initWithFrame:CGRectMake(0, KScreenHeight, KScreenWidth, KScreenHeight/2)];
    chatVC.master = master ;
    myWindow.windowLevel = currentWindow.windowLevel +1;
    [myWindow makeKeyAndVisible];
    [IQKeyboardManager sharedManager].enable = YES;
    myWindow.rootViewController =[[UINavigationController alloc]initWithRootViewController:chatVC];
    chatVC.window = myWindow ;
    return chatVC ;
}

- (void)show {
    self.isShowing = YES ;
    [UIView animateWithDuration:0.3 delay:0 options:0 animations:^{
        self.window.transform = CGAffineTransformMakeTranslation(0, -self.window.height);
    } completion:nil];
    UIView *backGroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight)];
    [currentWindow addSubview:backGroundView];
    backGroundView.userInteractionEnabled = YES ;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]init];
    [backGroundView addGestureRecognizer:tap];
    [[tap rac_gestureSignal] subscribeNext:^(id x) {
        [self hideWithAnimation:YES];
        [backGroundView removeFromSuperview];
    }];
}

+ (instancetype )showInView:(UIViewController *)fatherVC{
    return   [self showInView:fatherVC model:nil];
}
-(void)loadConversationList{
    NSArray *historyMsgArray = [IMSer conversationList];
    self.dataSource =  @[[NSMutableArray arrayWithArray:historyMsgArray]];
    [self.tableView.mj_footer  endRefreshing];
#if KMMessageList_Show_Online_Status
    [self startOnlineStatusAction];
#else
    [self.tableView reloadData];
#endif
}
- (void)hideWithAnimation:(BOOL)animation{
    self.isShowing = NO ;
        if(animation)
            [UIView animateWithDuration:0.3 animations:^{
                [self.window resignKeyWindow];
                self.window.transform=CGAffineTransformIdentity;
            } completion:^(BOOL finished) {
                [self.privateVC.navigationController popViewControllerAnimated:NO];
            }];
        else{
            [self.privateVC removeKeyBoardObserver];
            [self.window resignKeyWindow];
            [self.window setRootViewController:nil];
            self.window = nil ;
        }
    [IQKeyboardManager sharedManager].enable = YES;
    [currentWindow makeKeyAndVisible];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationBarView.hidden = YES ;
    [self loadConversationList];
    self.tableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.headerView];
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headerView.mas_bottom);
        make.left.width.bottom.equalTo(self.view);
    }];
    
    [self addKeyBoardObserver];
    @weakify(self);
    //下拉刷新统一处理
    if ([self shouldInfiniteScrolling]) {
        self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            @strongify(self)
            [self loadConversationList];
        }];
    }
    if(self.master){//如果有master说明是看播端
        [self chatWithMaterView];
    }
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadConversationList];
}

- (void)chatWithMaterView{
    SLMessageListCell *livemaster = [[SLMessageListCell alloc]init];
    [self.view addSubview:livemaster];
    [livemaster mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headerView.mas_bottom);
        make.height.equalTo(@75);
        make.left.width.equalTo(self.view);
    }];
    livemaster.timeLabel.hidden = YES ;
    livemaster.contentLabel.text = @"Hi,我是主播,快来和我聊天吧";
    livemaster.nickNameLabel.text = self.master.nickname;
    [livemaster.headPortrait setRoundStyle:YES imageUrl:self.master.avatar imageHeight:45  vip:(self.master.isVip.integerValue==1) attestation:0];
    livemaster.unreadLabel.hidden = YES ;
    
    UIButton *sendMessageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [sendMessageBtn setTitle:@"聊天" forState:UIControlStateNormal];
    [sendMessageBtn setBackgroundColor:[UIColor redColor] forState:UIControlStateNormal];
    sendMessageBtn.titleLabel.font = [UIFont systemFontOfSize:12.0f];
    sendMessageBtn.layer.masksToBounds = YES;
    sendMessageBtn.layer.cornerRadius = 15;
    [livemaster addSubview:sendMessageBtn];
    [sendMessageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@30);
        make.centerY.equalTo(livemaster);
        make.right.equalTo(livemaster).with.offset(-15);
        make.width.equalTo(@65);
    }];
    @weakify(self);
    [[sendMessageBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        self.privateVC = [[SLPrivateChatViewController alloc] init];
        self.privateVC.targetUid = self.master.uid;
        self.privateVC.isLiveChatRoom = YES;
        [IQKeyboardManager sharedManager].enable = YES ;
        [self.privateVC adjustLiveChatView];
        @weakify(self);
        [self pushViewController:self.privateVC callBackBlock:^(RACTuple *tupe) {
            @strongify(self);
            [self hideWithAnimation:YES];
        } animated:YES];
    }];
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(livemaster.mas_bottom);
        make.left.width.bottom.equalTo(self.view);
    }];
}

#pragma mark - Keyboard Observer
- (void)addKeyBoardObserver
{
    [self removeKeyBoardObserver];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)removeKeyBoardObserver
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

-(void)keyboardShow:(NSNotification *)note
{
    CGRect keyBoardRect=[note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat deltaY=keyBoardRect.size.height;
    [self bottomViewAnmimation:YES duration:[note.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue] distance:deltaY option:[note.userInfo[UIKeyboardAnimationCurveUserInfoKey] intValue]];
}

-(void)keyboardHide:(NSNotification *)note
{
    [self bottomViewAnmimation:NO duration:[note.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue] distance:0 option:[note.userInfo[UIKeyboardAnimationCurveUserInfoKey] intValue]];
}

-(void)bottomViewAnmimation:(BOOL)isShow duration:(CGFloat)duration distance:(CGFloat)distance option:(int)option{
    
    if(!self.isShowing){
        return ;
    }
    if (isShow) {
        
        CGFloat bottomH = _GetChatInputViewHeight();
        // minH 形变后 高度
        CGFloat minH =  kScreenHeight - kNaviBarHeight  - bottomH - distance ;
        // maxH 未形变 高度
        CGFloat maxH = kScreenHeight- kNaviBarHeight - bottomH;
        
        // content 高度
        CGFloat contentH = self.tableView.contentSize.height + self.tableView.contentInset.top + self.tableView.contentInset.bottom;
        
        CGFloat move = 0;
        CGFloat newH = minH;
        if (contentH > minH) {
            move = contentH - minH ;
            move = move > distance ? distance : move;
            newH = contentH < maxH ? contentH : maxH;
        }
        CGRect frame = self.tableView.frame;
        frame.size.height = newH ;
        @weakify(self);
        [UIView animateWithDuration:duration delay:0 options:option animations:^{
            @strongify(self) ;
            self.window.transform=CGAffineTransformMakeTranslation(0, -distance + KTabbarSafeBottomMargin-self.window.height);
            
        } completion:nil];
    }else{
        [UIView animateWithDuration:duration delay:0 options:option animations:^{
            self.window.transform = CGAffineTransformMakeTranslation(0, -self.window.height);
        } completion:nil];
    }
}
-(SLMessageListCell *)tableView:(UITableView *)tableView dequeueReusableCellWithIdentifier:(NSString *)identifier forIndexPath:(NSIndexPath *)indexPath{
    return [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SLMessageListCell class])];
}

- (CGFloat)configureCellHeightWithTableViewCell:(UITableViewCell *)cell AtIndexPath:(NSIndexPath *)indexPath withObject:(id)object{
    return 75.0f;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SLMessageListCell *cell = [self tableView:tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SLMessageListCell class]) forIndexPath:indexPath];
    if(!cell){
        cell = [[SLMessageListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([SLMessageListCell class])];
    }
    id object = self.dataSource[indexPath.section][indexPath.row];
    [self configureCell:cell atIndexPath:indexPath withObject:(id)object];
    return cell;
}
- (void)configureCell:(SLMessageListCell *)cell atIndexPath:(NSIndexPath *)indexPath withObject:(id)object {
    
    RCConversation *conv = self.dataSource[indexPath.section][indexPath.row];
    cell.cellData = conv;
    
    @weakify_old(self)
    [cell setLongPressBlock:^(SLMessageListCell *sender){
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil
                                                                       message:nil
                                                                preferredStyle:UIAlertControllerStyleActionSheet];
        NSString* topTitle=conv.isTop ? @"取消置顶" : @"置顶";
        UIAlertAction *actionTop = [UIAlertAction actionWithTitle:topTitle style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            [IMSer setConversationToTop:ConversationType_PRIVATE targetId:conv.targetId isTop:!conv.isTop];
            [weak_self loadConversationList];
            
        }];
        UIAlertAction *actionDel = [UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            [IMSer removeConversation:ConversationType_PRIVATE targetId:conv.targetId];
            [IMSer clearMessages:ConversationType_PRIVATE targetId:conv.targetId];
            
            [weak_self loadConversationList];
            
        }];
        UIAlertAction *actionCancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [alert addAction:actionTop];
        [alert addAction:actionDel];
        [alert addAction:actionCancle];
        [weak_self presentViewController:alert animated:YES completion:nil];
        
    }];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    RCConversation *conv = self.dataSource[indexPath.section][indexPath.row];
    
    if (![conv isKindOfClass:[RCConversation class]]) {
        return;
    }
    
    self.privateVC = [[SLPrivateChatViewController alloc] init];
    self.privateVC.targetUid = conv.targetId;
    self.privateVC.isLiveChatRoom = YES;
    [IQKeyboardManager sharedManager].enable = YES ;
    [self.privateVC adjustLiveChatView];
    @weakify(self);
    [self pushViewController:self.privateVC callBackBlock:^(RACTuple *tupe) {
        @strongify(self);
        [self hideWithAnimation:YES];
    } animated:YES];
    
    if (conv.unreadMessageCount > 0) {
        SLMessageListCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
        if (cell && [cell isKindOfClass:[SLMessageListCell class]]) {
            cell.unreadCount = 0;
        }
    }
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO ;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)shouldRequestWhenViewDidLoad{
    return NO ;
}

-(BOOL)shouldPullToRefresh{
    return NO ;
}

- (UIView *)headerView{
    if(!_headerView){
        _headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0,KScreenWidth, 35)];
        _headerView.backgroundColor = HexRGBAlpha(0xeeeeee, 1);
        UILabel *headerLabel = [[UILabel alloc]init];
        headerLabel.text = @"私信";
        headerLabel.font = [UIFont systemFontOfSize:16.0f];
        headerLabel.textColor = [UIColor grayColor];
        [_headerView addSubview:headerLabel];
        [headerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_headerView).with.offset(10);
            make.centerY.equalTo(_headerView);
        }];
    }
    return _headerView;
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
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

//
//  SLChatRoomView.m
//  ShowLive
//
//  Created by zhangxinggong on 2018/4/10.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "SLChatRoomView.h"
#import "SLChatRoomTableViewCell.h"
#import "SLCharRoomContentHelp.h"
#import "YYText.h"
#import "SLChatIMManager.h"
#import "AccountModel.h"
#import "SLTextTableViewCell.h"
#import "SLMessageInfo.h"

@interface SLChatRoomView()<UITableViewDelegate,UITableViewDataSource>

@property (copy,nonatomic) NSString *roomId;
@property (strong,nonatomic)UITableView *chatTableView;
@property (strong,nonatomic)UIView *chatTableHeaderView;
@property (strong,nonatomic)UIView *chatTableFooterView;

@property (assign,nonatomic) BOOL scrollerToBottom;
@property (weak,nonatomic)YYLabel *footerLabel ;
@property (strong,nonatomic) UILabel *noReadView;

@property (assign,nonatomic) NSInteger unReadCount;
@property (weak,nonatomic) NSTimer *timer ;

@property (strong,nonatomic)MASConstraint *bottomConstraint;
@property (strong,nonatomic)SLChatIMManager *chatIMMangger;

@property (strong,nonatomic)NSDictionary *paramDic;

@property (assign,nonatomic)BOOL responseKeyboard;

@property (assign,nonatomic)BOOL isMaster;

@end

@implementation SLChatRoomView

+(instancetype)showInView:(UIView *)fatherView Paramters:(NSDictionary *)paramters{
    SLChatRoomView *chatRoomView = [[SLChatRoomView alloc]initWithParamters:paramters];
    chatRoomView.responseKeyboard = YES ;
    [chatRoomView chatIMManggerWithParamters:paramters];
    [fatherView addSubview:chatRoomView];
    [chatRoomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(fatherView);
        chatRoomView.bottomConstraint =  make.bottom.equalTo(fatherView).with.offset(-KTabBarHeight);
        make.width.equalTo(fatherView).multipliedBy(0.64);
        make.height.equalTo(@200);
    }];
    return chatRoomView;
}

- (void)changeFrameYConstraints:(CGFloat)YConstraints UIView:(UIView *)fatherView{
    if(!self.responseKeyboard){
        return;
    }  //x 的高度341 ，83.0f ,7的高度 276，  49.0f
    if(YConstraints <=80){ //键盘回收的动作
        self.transform  = CGAffineTransformIdentity;
    }else{
        self.transform  = CGAffineTransformMakeTranslation(0, -(YConstraints - 2*KTabBarHeight + KTabbarSafeBottomMargin -44));
    }
    
    [UIView animateWithDuration:0.8 animations:^{
        [fatherView layoutIfNeeded];
    }];
}

- (instancetype)initWithParamters:(NSDictionary *)paramters{
    if(self = [super init]){
        self.paramDic = paramters ;
        self.scrollerToBottom = YES ;
        [self chatIMMangger];
        [self configSubView];
        @weakify(self);
        [[[NSNotificationCenter defaultCenter] rac_addObserverForName:kNotificationChatRoomInput object:nil] subscribeNext:^(NSNotification * x) {
            @strongify(self);
            self.responseKeyboard = [x.object boolValue];
        }];
    }
    return self ;
}

- (void)chatIMManggerWithParamters:(NSDictionary *)dic{
  self.chatIMMangger = [[SLChatIMManager alloc]initWithchatRoomParamters:self.paramDic];
  [self.chatIMMangger joinChatRoom:self.roomId];
}

- (void)quiteChatRoomSucess:(void(^)(void))sucess faild:(void(^)(RCErrorCode status))faild{
    [[ShowCIoundIMService sharedManager] quitChatRoom:self.roomId  success:sucess error:faild];
    [self.timer invalidate];
}
- (void)sendText:(NSString *)text{
    [self.chatIMMangger sendMessage:text Type:SLChatRoomMessageTypeText];
}


- (void)configSubView{
    
    self.dataSource = [NSMutableArray arrayWithCapacity:0];
    
    [self addSubview:self.chatTableView];
    [self.chatTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    self.footerLabel.attributedText =[[NSAttributedString alloc]initWithString:@"欢迎大土豪进入房间"];
    if([self.paramDic.allKeys containsObject:@"ismaster"]){
        if([self.paramDic[@"ismaster"] boolValue]){
            self.chatTableView.tableHeaderView = nil;
        }else{
            self.chatTableView.tableHeaderView = self.chatTableHeaderView;
        }
    }
    self.chatTableView.tableFooterView = self.chatTableFooterView;
    
    [self addSubview:self.noReadView];
    [self.noReadView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self);
        make.centerX.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(100, 24));
    }];
    
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:0.1f target:self selector:@selector(refreshTableData) userInfo:nil repeats:YES];
    [timer fire];
    self.timer = timer ;
    
    @weakify(self);
    [[RACObserve(self,chatTableView.contentOffset) zipWith:self.chatTableView.panGestureRecognizer.rac_gestureSignal] subscribeNext:^(id x) {
        @strongify(self);
        if((fabs(self.chatTableView.contentOffset.y)+self.chatTableView.height) <= self.chatTableView.contentSize.height -20){
            self.scrollerToBottom = NO;
        }
    }];
    [[RACObserve(self, chatTableView.contentOffset) distinctUntilChanged] subscribeNext:^(id x) {
        @strongify(self);
        if((fabs(self.chatTableView.contentOffset.y)+self.chatTableView.height) > self.chatTableView.contentSize.height -30){
            self.scrollerToBottom = YES;
            self.unReadCount = 0 ;
        }
    }];
    
    [[RACObserve(self, unReadCount) distinctUntilChanged] subscribeNext:^(id x) {
        @strongify(self);
        if(self.unReadCount > 0){
            self.noReadView.text = [NSString stringWithFormat: @"v %ld条新消息",self.unReadCount];
            self.noReadView.hidden = NO ;
        }else{
            self.noReadView.hidden = YES ;
            [self.timer setFireDate:[NSDate date]];
        }
    }];
}


- (void)refreshTableData{
    if(!self.chatIMMangger.messageArray.count){
        return ;
    }
    NSInteger unReadMessageCount = self.chatIMMangger.messageArray.count;
    [self.chatIMMangger addMessageFromDataSourceWithChatArray:self.dataSource]; 
    [self reloadTableViewWithCount:unReadMessageCount];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    SLMessageInfo *info = self.dataSource[indexPath.row];
    return info.height ;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  self.dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString * identifier = NSStringFromClass([SLChatRoomTableViewCell class]);
    NSString * textIdentifier = NSStringFromClass([SLTextTableViewCell class]);
    SLMessageInfo *info = self.dataSource[indexPath.row];
    BaseTableViewCell *cell = nil ;
    if(!info.type){
        cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if(!cell){
            cell = [[SLChatRoomTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
    }else{
        cell = [tableView dequeueReusableCellWithIdentifier:textIdentifier];
        if(!cell){
            cell = [[SLTextTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:textIdentifier];
        }
    }
    [cell bindModel:self.dataSource[indexPath.row]];
    return cell ;
}


- (UITableView *)chatTableView{
    if(!_chatTableView){
        _chatTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.width, self.height) style:UITableViewStylePlain];
        _chatTableView.delegate = self ;
        _chatTableView.dataSource = self ;
        _chatTableView.backgroundColor = [[UIColor clearColor]colorWithAlphaComponent:0.0];
        _chatTableView.estimatedRowHeight = 0;
        _chatTableView.estimatedSectionFooterHeight = 0;
        _chatTableView.estimatedSectionHeaderHeight = 0;
        _chatTableView.showsVerticalScrollIndicator = NO ;
        _chatTableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
        _chatTableView.rowHeight = UITableViewAutomaticDimension;
    }
    return _chatTableView;
}
- (UIView *)chatTableFooterView{
    if(!_chatTableFooterView){
        _chatTableFooterView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.chatTableView.width, 23.5)];
        YYLabel *contentLabel = [[YYLabel alloc]initWithFrame:CGRectMake(0, 0, self.chatTableView.width, 23.5)];
        contentLabel.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.2];
        contentLabel.layer.cornerRadius = 5;
        contentLabel.layer.masksToBounds = YES;
        contentLabel.font = [UIFont systemFontOfSize:15.0f];
        contentLabel.textColor = [UIColor whiteColor];
        contentLabel.numberOfLines = 0;
        contentLabel.textContainerInset = UIEdgeInsetsMake(3, 8, 1, 3);
        contentLabel.preferredMaxLayoutWidth = self.width -50;
        self.footerLabel = contentLabel;
        [_chatTableFooterView addSubview:contentLabel];
        
    }
    return _chatTableFooterView;
}
- (UIView *)chatTableHeaderView{
    if(!_chatTableHeaderView){
        _chatTableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.chatTableView.width, 28)];
        UILabel *headerLabel = [[UILabel alloc]init];
        headerLabel.textColor = [UIColor whiteColor];
        headerLabel.font = [UIFont systemFontOfSize:14.0f];
        headerLabel.textAlignment = NSTextAlignmentCenter;
        headerLabel.text = @"关注主播，不再迷路 >";
        headerLabel.backgroundColor = HexRGBAlpha(0x24A4EB, 1);
        headerLabel.layer.masksToBounds = YES ;
        headerLabel.layer.cornerRadius = 14.0f ;
        [_chatTableHeaderView addSubview:headerLabel];
        [headerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.height.equalTo(self.chatTableHeaderView);
            make.width.equalTo(@180);
            make.left.equalTo(self.chatTableHeaderView).with.offset(10);
        }];
    }
    return _chatTableHeaderView;
}

-(void)reloadTableViewWithCount:(NSInteger)unReadMessageCount{

    [self.chatTableView reloadData];
    if(self.scrollerToBottom){
        self.unReadCount = 0 ;
        if(self.dataSource.count){
            [self.chatTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.dataSource.count-1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
        }
    }else{
        self.unReadCount += unReadMessageCount ;
    }
}

- (UILabel *)noReadView{
    if(!_noReadView){
        _noReadView = [[UILabel alloc]init];
        _noReadView.backgroundColor = [UIColor whiteColor];
        _noReadView.textColor =HexRGBAlpha(0x24A4EB, 1);
        _noReadView.font = [UIFont systemFontOfSize:14.0f];
        _noReadView.text = @"v 1条新消息";
        _noReadView.userInteractionEnabled = YES;
        _noReadView.layer.masksToBounds = YES;
        _noReadView.layer.cornerRadius = 3;
        _noReadView.textAlignment = NSTextAlignmentCenter;
        _noReadView.hidden  = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]init];
        [_noReadView addGestureRecognizer:tap];
        @weakify(self);
        [[tap rac_gestureSignal] subscribeNext:^(id x) {
            @strongify(self)
            [self.timer setFireDate:[NSDate distantFuture]];
            [self.chatTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.dataSource.count-1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
        }];
    }
    return _noReadView;
}

- (void)dealloc{
    [self.timer invalidate];
    self.timer = nil ;
    [[NSNotificationCenter  defaultCenter]removeObserver:self];
}
@end

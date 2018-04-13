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

@interface SLChatRoomView()<UITableViewDelegate,UITableViewDataSource>

@property (strong,nonatomic)UITableView *chatTableView;
@property (strong,nonatomic)UIView *chatTableHeaderView;
@property (strong,nonatomic)UIView *chatTableFooterView;

@property (assign,nonatomic) BOOL scrollerToBottom;
@property (weak,nonatomic)YYLabel *footerLabel ;
@property (strong,nonatomic) UILabel *noReadView;

@property (assign,nonatomic) NSInteger unReadCount;
@property (weak,nonatomic)NSTimer *timer ;

@property (strong,nonatomic)MASConstraint *bottomConstraint;

@end

@implementation SLChatRoomView

+(instancetype)showInView:(UIView *)fatherView{
    SLChatRoomView *chatRoomView = [[SLChatRoomView alloc]init];
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
    [self mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(fatherView);
        make.bottom.equalTo(fatherView).with.offset(-YConstraints);
        make.width.equalTo(fatherView).multipliedBy(0.64);
        make.height.equalTo(@200);
    }];
    [UIView animateWithDuration:0.8 animations:^{
        [fatherView layoutIfNeeded];
    }];
}

- (instancetype)init{
    if(self = [super init]){
        self.scrollerToBottom = YES ;
        [self configSubView];
    }
    return self ;
}

- (void)configSubView{
    
    self.dataSource = [NSMutableArray arrayWithCapacity:0];
    
    [self addSubview:self.chatTableView];
    [self.chatTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    self.footerLabel.attributedText =[[NSAttributedString alloc]initWithString:@"欢迎大土豪进入房间"];
    self.chatTableView.tableHeaderView = self.chatTableHeaderView;
    self.chatTableView.tableFooterView = self.chatTableFooterView;
    
    [self addSubview:self.noReadView];
    [self.noReadView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self);
        make.centerX.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(92.5, 19));
    }];
    
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1.0f repeats:YES block:^(NSTimer * _Nonnull timer) {
        if(self.dataSource.count  >20){
            [timer invalidate ];
            return ;
        }
        int a =  arc4random()%4 ;
        NSMutableString *str = [NSMutableString stringWithString:@"土豪快来，抱抱大腿"];
        
        for (int index = 0; index<a; index ++) {
            [str appendString:str];
        }
        NSAttributedString *att = [SLCharRoomContentHelp contentAttributedString:str];
        [self.dataSource addObject:att];
        [self reloadTableView];
    }];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [timer fire];
    });
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
            self.noReadView.text = [NSString stringWithFormat: @"V %ld条新消息",self.unReadCount];
            self.noReadView.hidden = NO ;
        }else{
            self.noReadView.hidden = YES ;
            [self.timer setFireDate:[NSDate date]];
        }
    }];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSAttributedString *string = self.dataSource [indexPath.row];
    CGSize size = CGSizeMake(self.width-55, CGFLOAT_MAX);
    YYTextLayout *layout = [YYTextLayout layoutWithContainerSize:size text:string];
    CGFloat height = layout.textBoundingSize.height + 15;
    return height ;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  self.dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString * identifier = NSStringFromClass([SLChatRoomTableViewCell class]);
    
    SLChatRoomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if(!cell){
        cell = [[SLChatRoomTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
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
            make.centerY.height.equalTo(_chatTableHeaderView);
            make.width.equalTo(@180);
            make.left.equalTo(_chatTableHeaderView).with.offset(10);
        }];
    }
    return _chatTableHeaderView;
}

-(void)reloadTableView{
    [self.chatTableView reloadData];
    if(self.scrollerToBottom){
        self.unReadCount = 0 ;
        [self.chatTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.dataSource.count-1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
        
    }else{
        self.unReadCount ++ ;
    }
}

- (UILabel *)noReadView{
    if(!_noReadView){
        _noReadView = [[UILabel alloc]init];
        _noReadView.backgroundColor = [UIColor whiteColor];
        _noReadView.textColor =HexRGBAlpha(0x24A4EB, 1);
        _noReadView.font = [UIFont systemFontOfSize:14.0f];
        _noReadView.text = @"V 1条新消息";
        _noReadView.userInteractionEnabled = YES ;
        _noReadView.layer.masksToBounds = YES ;
        _noReadView.layer.cornerRadius = 3 ;
        _noReadView.textAlignment = NSTextAlignmentCenter;
        _noReadView.hidden  = YES ;
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
    [[NSNotificationCenter  defaultCenter]removeObserver:self];
}
@end

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
@property (strong,nonatomic)NSMutableArray *dataSource;

@end

@implementation SLChatRoomView

+(instancetype)showInView:(UIView *)fatherView{
    SLChatRoomView *chatRoomView = [[SLChatRoomView alloc]init];
    [fatherView addSubview:chatRoomView];
    [chatRoomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(fatherView);
        make.bottom.equalTo(fatherView).with.offset(-KTabBarHeight);
        make.width.equalTo(fatherView).multipliedBy(0.64);
        make.height.equalTo(@200);
    }];
    return chatRoomView;
}

- (instancetype)init{
    if(self = [super init]){
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
    
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:0.5 repeats:YES block:^(NSTimer * _Nonnull timer) {
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
    [timer fire];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSAttributedString *string =self.dataSource[indexPath.row];
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

-(void)reloadTableView{
    [self.chatTableView reloadData];
    [self.chatTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.dataSource.count-1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}



@end

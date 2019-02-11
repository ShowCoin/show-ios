//
//  SLFriendListCell.m
//  ShowLive
//
//  Created by iori_chou on 2018/4/13.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "SLFriendListCell.h"
static CGFloat lableMargin = 14;

@interface SLFriendListCell()<HeadPortraitDelegate>

@property (nonatomic, assign) BOOL isFollow;
@property(nonatomic,strong)UIImageView * vipImageView;
@property(nonatomic,strong)UILabel     * nickNameLabel;
@property(nonatomic,strong)UILabel     * lblID;
@property(nonatomic,strong)UIButton    * btnOperation;
@property(nonatomic,strong)UIImageView * sexImageView;
@property(nonatomic,strong)UILabel * ageLabel;
@property(nonatomic,strong)NSArray *  randomArr;
@property(nonatomic,strong)SLHeadPortrait     * headPortrait;
@property (assign, nonatomic) BOOL isSeparatorLineFull;
@property (strong, nonatomic) UIView *line;
@end
@implementation SLFriendListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
+(id)cellWithTableView:(UITableView*)tableView{
    return [SLFriendListCell cellWithTableView:tableView separatorLineFull:YES];
}

+(id)cellWithTableView:(UITableView*)tableView separatorLineFull:(BOOL)separatorLineFull{
    static NSString *CellIdentifier = @"FriendListCell";
    SLFriendListCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[SLFriendListCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.isSeparatorLineFull = separatorLineFull;
    }
    return cell;
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        //        [self.contentView addSubview:self.sexImageView];
        //        [self.contentView addSubview:self.vipImageView];
        
        self.frame = CGRectMake(0, 0, kMainScreenWidth, 72*Proportion375);
        self.backgroundColor = kthemeBlackColor;
        [self setupControls];
    }
    
    return self;
}
-(void)setupControls{
    // 66
    _headPortrait=[[SLHeadPortrait alloc]initWithFrame:CGRectMake(15, 13, 40, 40)];
    _headPortrait.delegate=self;
    [self addSubview:self.headPortrait];
    
    if(IsStrEmpty(_userModel.popularNo)){
        _userModel.popularNo = @"?!!!!";
    }
    
    _nickNameLabel = [UILabel labelWithFrame:CGRectZero text:_userListModel.nickname textColor:kBlackThemetextColor font:Font_Medium(15) backgroundColor:[UIColor clearColor] alignment:NSTextAlignmentLeft];
    [self addSubview:self.nickNameLabel];
    
    _lblID = [UILabel labelWithFrame:CGRectZero text:_userListModel.popularNo textColor:kBlackThemetextColor font:[UIFont systemFontOfSize:12] backgroundColor:[UIColor clearColor] alignment:NSTextAlignmentLeft];
    [self addSubview:self.lblID];
    
    
    _moneyLabel = [UILabel labelWithFrame:CGRectMake(175+_headPortrait.width, lableMargin, 90, 20) text:@"999 秀币" textColor:kBlackThemetextColor font:Font_Regular(16) backgroundColor:[UIColor clearColor] alignment:NSTextAlignmentRight];
    _moneyLabel.attributedText= [SLHelper appendString:@"999 秀币" withColor:kBlackThemetextColor font:Font_Regular(12) lenght:3];
    _moneyLabel.opaque = YES;
    _moneyLabel.centerY = self.headPortrait.centerY;
    [self addSubview:_moneyLabel];
    
    _btnOperation=[UIButton buttonWithType:UIButtonTypeCustom];
    _btnOperation.frame = CGRectMake(kMainScreenWidth-56*Proportion375-15 *Proportion375,22*Proportion375, 60.5*Proportion375, 36.5*Proportion375);
    _btnOperation.centerY = self.centerY;
    _btnOperation.titleLabel.font  = Font_Medium(10);
    [_btnOperation setImage:[UIImage imageNamed:@"friendlistfollow"] forState:UIControlStateNormal];
    [_btnOperation addTarget:self action:@selector(operationClick:) forControlEvents:UIControlEventTouchUpInside];
    //    [_btnOperation setAttributedTitle:[[NSAttributedString alloc] initWithString:@"聊天" attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:12],NSForegroundColorAttributeName:HexRGBAlpha(0xffffff, 1)}] forState:UIControlStateNormal];
    [self addSubview:self.btnOperation];
    
    _moneyLabel.right = _btnOperation.left -10;
    
    UIView * line=[[UIView alloc]initWithFrame:CGRectZero];
    line.backgroundColor=BlackColor;
    [self addSubview:line];
    self.line = line;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    _lblID.frame=CGRectMake(_headPortrait.right + 10, self.height - lableMargin - 15 ,225*Proportion375,15);
    if (self.isSeparatorLineFull) {
        self.line.frame = CGRectMake(0, 65.5, kMainScreenWidth, 0.5);
    }
    else {
        self.line.frame = CGRectMake(_nickNameLabel.left, 65.5, kMainScreenWidth, 0.5);
    }
    if (_isAt)
    {
        self.line.hidden =YES;
    }
}
-(void)setIsAt:(BOOL)isAt
{
    _isAt = isAt;
    if (_isAt) {
        self.backgroundColor = [UIColor clearColor];
        UIColor *nickNameColor = kBlackThemetextColor;
        self.nickNameLabel.textColor = nickNameColor;
        _lblID.text = _userListModel.descriptions?[NSString stringWithFormat:@"%@",_userListModel.descriptions]:@"这个人很懒,没留下任何东西";
        _btnOperation.centerY = self.headPortrait.centerY;
        _moneyLabel.centerY = self.headPortrait.centerY;
        self.line.frame = CGRectMake(0, 65.5, kMainScreenWidth, 0.5);
    }
}
-(void)setUserListModel:(SLFansModel *)userListModel
{
    _userListModel = userListModel;
    UIColor *nickNameColor = kBlackThemetextColor;
    self.nickNameLabel.textColor = nickNameColor;
    self.nickNameLabel.text = userListModel.nickname;
    NSString * imageUrl = userListModel.avatar;
    
    [_headPortrait setRoundStyle:YES imageUrl:imageUrl imageHeight:40*Proportion375 vip:NO attestation:NO];
    
    NSString * follow_state = userListModel.isFollowed;
    _isFollow = [follow_state integerValue]>0;
    if (_isFollow) {
        [_btnOperation setImage:[UIImage imageNamed:@"echFowed"] forState:UIControlStateNormal];
        
    }else{
        [_btnOperation setImage:[UIImage imageNamed:@"friendlistfollow"] forState:UIControlStateNormal];
    }
    
    if (ValidStr(userListModel.localRemarkName)) {
        _nickNameLabel.frame=CGRectMake(_headPortrait.right + 10, lableMargin, 105*Proportion375,20);
        NSMutableAttributedString* attstring=[[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@(%@)",userListModel.localRemarkName,userListModel.nickname]];
        
        [attstring setAttributes:@{NSForegroundColorAttributeName :nickNameColor,NSFontAttributeName:[UIFont systemFontOfSize:14]} range:NSMakeRange(0, [userListModel.localRemarkName length])];
        
        UIColor *nickNameAttriColor = kGrayTextColor;
        [attstring setAttributes:@{NSForegroundColorAttributeName :HexRGBAlpha(0x333333, 1),NSFontAttributeName:[UIFont systemFontOfSize:15]} range:NSMakeRange([userListModel.localRemarkName length], [userListModel.nickname length]+2)];
        [self.nickNameLabel setAttributedText:attstring];
    }else{
        _nickNameLabel.frame=CGRectMake(_headPortrait.right + 10, lableMargin, 105*Proportion375,20);
//        self.nickNameLabel.centerY = _headPortrait.centerY-10;
    }
    
    _lblID.text = userListModel.descriptions?[NSString stringWithFormat:@"%@",userListModel.descriptions]:@"这个人很懒,没留下任何东西";
}

-(void)operationClick:(UIButton*)sender{
    NSString * follow_state = self.userListModel.isFollowed;
    if ([follow_state integerValue]>0) {
        //        if (_isAt)
        //        {
        //            sender.selected = !sender.selected;
        //            if (sender.selected) {
        //                sender.backgroundColor = kGrayTextColor;
        //                [sender setTitleColor:kGrayTextColor forState:UIControlStateNormal];
        //            }
        //            else
        //            {
        //                sender.backgroundColor = RGBACOLOR(100, 194, 248, 1);
        //                [sender setTitleColor:kBlackThemetextColor forState:UIControlStateNormal];
        //            }
        //            if (_functionDelegate && [_functionDelegate respondsToSelector:@selector(onClickAt:button:)])
        //            {
        //                [_functionDelegate onClickAt:self.userListModel button:sender];
        //            }
        //        }
        //        else
        //        {
        if (_functionDelegate && [_functionDelegate respondsToSelector:@selector(onClickChat:)]) {
            [_functionDelegate onClickChat:self.userListModel];
        }
        //        }
    }
    else{
        if (_functionDelegate && [_functionDelegate respondsToSelector:@selector(onClickFollow:withData:)]) {
            @weakify_old(self)
            [sender setEnabled:NO];
            [_functionDelegate onClickFollow:^(BOOL isLastPage) {
                [sender setEnabled:YES];
                if (isLastPage) {
                    @strongify_old(self)
                    strong_self.userListModel.isFollowed=@"1";
                    [strong_self setUserListModel:weak_self.userListModel];
                    
                    if (weak_self.functionDelegate) {
                        UITableView* _tableView=[(UIViewController*)weak_self.functionDelegate valueForKey:@"_tableView"];
                        if (_tableView&&[_tableView isKindOfClass:[UITableView class]]) {
                            [_tableView reloadData];
                        }
                    }
                    [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationChangeFollowStatus object:nil];
                }
            } withData:self.userListModel];
        }
    }
}

#pragma mark HeadPortraitDelegate
-(void)headPortraitClickAuthor{
    if (_functionDelegate && [_functionDelegate respondsToSelector:@selector(onClickUser:)]) {
        [_functionDelegate onClickUser:self.userListModel];
    }
}


@end

//
//  NewTopListCell.m
//  ShowLive
//
//  Created by vning on 2019/1/25.
//  Copyright © 2019 vning. All rights reserved.
//

#import "NewTopListCell.h"
#import "NSString+SLMoney.h"

@implementation NewTopListCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.headPortraitBg];
        [self.contentView addSubview:self.headPortraitIsLiveBg];
        [self.contentView addSubview:self.headPortrait];
        self.headPortraitBg.center = self.headPortrait.center;
        self.headPortraitIsLiveBg.center = self.headPortrait.center;
        [self.contentView addSubview:self.NumImg];
        [self.contentView addSubview:self.NumLab];
        [self.contentView addSubview:self.nickNameLabel];
        [self.contentView addSubview:self.sexImg];
        [self.contentView addSubview:self.detailNameLable];
        [self.contentView addSubview:self.masterLevel];
        [self.contentView addSubview:self.showLevel];
        [self.contentView addSubview:self.LabFir];
        [self.contentView addSubview:self.showCoin];
        [self.contentView addSubview:self.LabSec];
        [self.contentView addSubview:self.LabThird];
        [self.contentView addSubview:self.contentLabel];
        [self.contentView addSubview:self.lineView];
        [self.contentView addSubview:self.attentionButton];

        self.backgroundColor = kBlackWith1c;
        
    }
    
    return self;
}

-(void)setmodel:(ShowUserModel *)model withCellType:(NSInteger)celltype
{
    _type = celltype;
    _model = model;
    
    if ([AccountUserInfoModel.uid isEqualToString:_model.uid]) {
        self.attentionButton.hidden = YES;
    }else{
        self.attentionButton.hidden = NO;
    }
    NSString * imageUrl = _model.avatar;
    if ([_model.islive isEqualToString:@"1"]) {
        _headPortraitIsLiveBg.hidden = NO; 
        _headPortraitBg.hidden = YES;
        [_headPortraitIsLiveBg setImage:[UIImage imageNamed:@"userhome_islive_head"]];
        [_headPortrait setRoundStyle:YES imageUrl:imageUrl imageHeight:11 vip:_model.is_vip attestation:NO];
    }else{
        _headPortraitIsLiveBg.hidden = YES;
        [_headPortrait setRoundStyle:YES imageUrl:imageUrl imageHeight:35 vip:_model.is_vip attestation:NO];
    }
    
    self.nickNameLabel.text = _model.nickname;

    if (_model.gender.integerValue == 1) {
        [_sexImg setImage:[UIImage imageNamed:@"redpacket_sex_man"]];
    }else{
        [_sexImg setImage:[UIImage imageNamed:@"redpacket_sex_woman"]];
    }
//    _detailNameLable.text = [NSString stringWithFormat:@"%@ SHOW / %@ 币天",];
    _detailNameLable.text = [NSString stringWithFormat:@"%@ SHOW / %@ 币天",_model.showCoinStr,_model.coinDay];

    NSString * follow_state = _model.isFollowed;
    _isFollow = [follow_state boolValue];
    if (_isFollow) {
        if (_model.isFans) {
            [self.attentionButton setBackgroundImage:[UIImage imageNamed:@"echFowed"] forState:UIControlStateNormal];
        }else{
            [self.attentionButton setBackgroundImage:[UIImage imageNamed:@"friendlistfollowed"] forState:UIControlStateNormal];
        }
    }else{
        [self.attentionButton setBackgroundImage:[UIImage imageNamed:@"friendlistfollow"] forState:UIControlStateNormal];
    }
    
    [_showLevel setLevel:[NSString stringWithFormat:@"%ld",(long)_model.showLevel]];
    [_masterLevel setLevel:[NSString stringWithFormat:@"%ld",(long)_model.masterLevel]];
    
    switch (_type) {//区分type  重新布置frame UI
        case 1:
            self.LabFir.text = [NSString stringWithFormat:@"礼物价值 %@ CNY",[NSString stringChangeMoneyWithStr:_model.giftShowCnyNum numberStyle:NSNumberFormatterDecimalStyle]];
            self.LabSec.text = [NSString stringWithFormat:@"合计 %@ SHOW",[NSString stringChangeMoneyWithStr:_model.giftShowCoinStr numberStyle:NSNumberFormatterDecimalStyle]];
            self.contentLabel.text = _model.descriptions;
            if ([_model.descriptions isEqualToString:@""] || _model.descriptions == nil) {
                self.contentLabel.text = @"本宝宝还没有签名~";
            }
            self.LabThird.hidden = YES;
            self.contentLabel.centerY = 119*Proportion375;
            self.lineView.bottom = 146*Proportion375;
            break;
        case 2:
            self.LabFir.text = [NSString stringWithFormat:@"获得 %@ SHOW",[NSString stringChangeMoneyWithStr:_model.bonusShowCoinStr numberStyle:NSNumberFormatterDecimalStyle]];
            self.LabSec.text = [NSString stringWithFormat:@"合计 %@ CNY",[NSString stringChangeMoneyWithStr:_model.bonusShowCnyNum numberStyle:NSNumberFormatterDecimalStyle]];
            self.LabThird.text = [NSString stringWithFormat:@"共推荐 %@ 人",[NSString stringChangeMoneyWithStr:_model.inviteCount numberStyle:NSNumberFormatterDecimalStyle]];
            self.contentLabel.text = _model.descriptions;
            if ([_model.descriptions isEqualToString:@""] || _model.descriptions == nil) {
                self.contentLabel.text = @"本宝宝还没有签名~";
            }
            self.LabThird.hidden = NO;
            self.LabThird.centerY = 119*Proportion375;
            self.contentLabel.centerY = 134*Proportion375;
            self.lineView.bottom = 161*Proportion375;

            break;
        case 3:
            self.LabFir.text = [NSString stringWithFormat:@"累计观看%@ 小时",[NSString stringChangeMoneyWithStr:_model.totalTime numberStyle:NSNumberFormatterDecimalStyle]];
            self.LabSec.text = [NSString stringWithFormat:@"价值 %@ CNY",[NSString stringChangeMoneyWithStr:_model.timeShowCnyNum numberStyle:NSNumberFormatterDecimalStyle]];
            self.LabThird.text = [NSString stringWithFormat:@"累计使用 %@ SHOW",[NSString stringChangeMoneyWithStr:_model.timeShowCoinStr numberStyle:NSNumberFormatterDecimalStyle]];
            self.contentLabel.text = _model.descriptions;
            if ([_model.descriptions isEqualToString:@""] || _model.descriptions == nil) {
                self.contentLabel.text = @"本宝宝还没有签名~";
            }
            self.LabThird.hidden = NO;
            self.LabThird.centerY = 119*Proportion375;
            self.contentLabel.centerY = 134*Proportion375;
            self.lineView.bottom = 161*Proportion375;

            break;
        case 4:
            NSLog(@"");
            break;
        case 5:
            NSLog(@"");
            break;

        default:
            break;
    }
}

-(SLHeadPortrait *)headPortrait
{
    if(!_headPortrait)
    {
        _headPortrait=[[SLHeadPortrait alloc]initWithFrame:CGRectMake(49* Proportion375, 17* Proportion375, 45* Proportion375, 45* Proportion375)];
        _headPortrait.delegate=self;
    }
    return _headPortrait;
}
-(UIImageView *)headPortraitBg
{
    if (!_headPortraitBg) {
        _headPortraitBg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 64*Proportion375, 64*Proportion375)];
        _headPortraitBg.clipsToBounds = YES;
        _headPortraitBg.hidden = YES;
    }
    return _headPortraitBg;
}
-(UIImageView *)headPortraitIsLiveBg
{
    if (!_headPortraitIsLiveBg) {
        _headPortraitIsLiveBg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 64*Proportion375, 64*Proportion375)];
        _headPortraitIsLiveBg.clipsToBounds = YES;
        _headPortraitIsLiveBg.hidden = YES;
    }
    return _headPortraitIsLiveBg;
}
-(UILabel*)nickNameLabel
{
    if (!_nickNameLabel) {
        _nickNameLabel = [UILabel labelWithFrame:CGRectMake(self.headPortrait.right + 10*Proportion375 ,_headPortrait.top,200*Proportion375,14*Proportion375) text:@"" textColor:kGrayTextWithb6 font:Font_Regular(14*Proportion375) backgroundColor:[UIColor clearColor] alignment:NSTextAlignmentLeft];
        
        _nickNameLabel.opaque = YES;
    }
    return _nickNameLabel;
}

-(UIImageView *)sexImg
{
    if (!_sexImg) {
        _sexImg = [[UIImageView alloc] initWithFrame:CGRectMake(_nickNameLabel.left, _nickNameLabel.bottom + 5*Proportion375, 10*Proportion375, 10*Proportion375)];
        _sexImg.clipsToBounds = YES;
        _sexImg.centerY = _headPortrait.centerY + 2*Proportion375;
        
    }
    return _sexImg;
}
-(UILabel*)detailNameLable
{
    if (!_detailNameLable) {
        _detailNameLable = [UILabel labelWithFrame:CGRectMake(self.headPortrait.right + 10*Proportion375 ,22*Proportion375,200*Proportion375,10*Proportion375) text:@"" textColor:kGrayWith727272 font:Font_Regular(10*Proportion375) backgroundColor:[UIColor clearColor] alignment:NSTextAlignmentLeft];
        _detailNameLable.bottom = _headPortrait.bottom;
        _detailNameLable.opaque = YES;
    }
    return _detailNameLable;
}
-(UILabel*)NumLab
{
    if (!_NumLab) {
        _NumLab = [UILabel labelWithFrame:CGRectMake(0 ,22*Proportion375,49*Proportion375,9*Proportion375) text:@"" textColor:kGrayWith727272 font:Font_engMedium(9*Proportion375) backgroundColor:[UIColor clearColor] alignment:NSTextAlignmentCenter];
        _NumLab.centerY = _headPortrait.centerY;
        _NumLab.opaque = YES;
    }
    return _NumLab;
}
-(UIImageView *)NumImg
{
    if (!_NumImg) {
        _NumImg = [[UIImageView alloc] initWithFrame:CGRectMake(16*Proportion375, _nickNameLabel.bottom + 10*Proportion375, 18*Proportion375, 22*Proportion375)];
        _NumImg.centerY = _headPortrait.centerY;
        _NumImg.centerX = 49*Proportion375/2;
        _NumImg.clipsToBounds = YES;
        
    }
    return _NumImg;
}
-(SLLevelMarkView *)masterLevel
{
    if (!_masterLevel) {
        _masterLevel = [[SLLevelMarkView alloc]initWithFrame:CGRectMake(_sexImg.right + 3*Proportion375, 0, 25*WScale, 12*WScale) withType:LevelType_Host];
        _masterLevel.level =Int2String(_model.masterLevel);
        _masterLevel.clipsToBounds = YES;
        _masterLevel.centerY = _sexImg.centerY;
    }
    return _masterLevel;
}
-(SLLevelMarkView *)showLevel
{
    if (!_showLevel) {
        _showLevel = [[SLLevelMarkView alloc]initWithFrame:CGRectMake(_masterLevel.right + 3*Proportion375, 0, 25*WScale, 12*WScale) withType:LevelType_ShowCoin];
        _showLevel.level =Int2String(_model.showLevel);
        _showLevel.clipsToBounds = YES;
        _showLevel.centerY = _sexImg.centerY;
        
    }
    return _showLevel;
}
-(UILabel*)LabFir
{
    if (!_LabFir) {
        _LabFir = [UILabel labelWithFrame:CGRectMake(_headPortrait.left ,23,kMainScreenWidth - 50*Proportion375,15*Proportion375) text:@"" textColor:kGrayTextWithb6 font:Font_Medium(14*Proportion375) backgroundColor:[UIColor clearColor] alignment:NSTextAlignmentLeft];
        _LabFir.centerY = 86*Proportion375;
        _LabFir.opaque = YES;
    }
    return _LabFir;
}
-(UILabel*)showCoin
{
    if (!_showCoin) {
        _showCoin = [UILabel labelWithFrame:CGRectMake(self.LabFir.right+ 1,28,225,13) text:@"" textColor:kGrayTextWithb6 font:Font_Medium(17*Proportion375) backgroundColor:[UIColor clearColor] alignment:NSTextAlignmentLeft];
        _showCoin.centerY = self.LabFir.centerY ;
        _showCoin.opaque = YES;
    }
    return _showCoin;
}
-(UILabel*)LabSec
{
    if (!_LabSec) {
        _LabSec = [UILabel labelWithFrame:CGRectMake(_headPortrait.left,0,kMainScreenWidth - 50*Proportion375,9*Proportion375) text:@"合计" textColor:kGrayWith727272 font:Font_Regular(9*Proportion375) backgroundColor:[UIColor clearColor] alignment:NSTextAlignmentLeft];
        _LabSec.opaque = YES;
        _LabSec.centerY = 104*Proportion375;
    }
    return _LabSec;
}
-(UILabel*)LabThird
{
    if (!_LabThird) {
        _LabThird = [UILabel labelWithFrame:CGRectMake(_headPortrait.left,0,kMainScreenWidth - 50*Proportion375,9*Proportion375) text:@"合计" textColor:kGrayWith727272 font:Font_Regular(9*Proportion375) backgroundColor:[UIColor clearColor] alignment:NSTextAlignmentLeft];
        _LabThird.opaque = YES;
        _LabThird.centerY = 110*Proportion375;
    }
    return _LabThird;
}
-(UILabel*)contentLabel
{
    if (!_contentLabel) {
        _contentLabel = [UILabel labelWithFrame:CGRectMake(_headPortrait.left,0,kMainScreenWidth - 50*Proportion375 - 66*Proportion375 - 24*Proportion375,9*Proportion375) text:@"" textColor:kGrayWith727272 font:Font_Medium(9*Proportion375) backgroundColor:[UIColor clearColor] alignment:NSTextAlignmentLeft];
        _contentLabel.opaque = YES;
        _contentLabel.centerY = 119*Proportion375;
    }
    return _contentLabel;
}

-(UIButton*)attentionButton
{
    if (!_attentionButton) {
        _attentionButton = [[UIButton alloc] initWithFrame:CGRectMake(kMainScreenWidth - 66*Proportion375,26*Proportion375, 50*Proportion375, 27*Proportion375)];
        _attentionButton.centerY = _headPortrait.centerY;
        _attentionButton.titleLabel.font  = Font_Medium(10);
        [_attentionButton addTarget:self action:@selector(attentionButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _attentionButton;
}
-(UIView *)lineView
{
    if (!_lineView) {
        _lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 158*Proportion375, kMainScreenWidth, 2)];
        _lineView.backgroundColor = kBlackWith17;
    }
    return _lineView;
}
-(void)deleteAction:(id)sender
{
    if (_delegate) {
        //取消关注
    }
}
- (void)attentionButtonClick:(id)sender {
    [self attentionBtnClick];
}

- (void)attentionBtnClick {
    if (_followUserAction) {
        [_followUserAction cancel];
        _followUserAction = nil;
    }
    @weakify(self);
    _followUserAction = [SLFollowUserAction action];
    _followUserAction.to_uid =_model.uid;
    _followUserAction.type =_isFollow?FollowTypeDelete:FollowTypeAdd;
    
    _followUserAction.finishedBlock = ^(id result) {
        @strongify(self);
        self.isFollow = !self.isFollow;
        if (self.isFollow) {
            if (self.model.isFans) {
                [self.attentionButton setBackgroundImage:[UIImage imageNamed:@"echFowed"] forState:UIControlStateNormal];
            }else{
                [self.attentionButton setBackgroundImage:[UIImage imageNamed:@"friendlistfollowed"] forState:UIControlStateNormal];
            }
        }else{
            [self.attentionButton setBackgroundImage:[UIImage imageNamed:@"friendlistfollow"] forState:UIControlStateNormal];
            
        }
        NSString * type = [result objectForKey:@"isFollowed"];
        NSDictionary * dict = @{@"type":type,@"uid":self->_model.uid};
        [[NSNotificationCenter defaultCenter]postNotificationName:kFollowUserStatusWithUidNotification object:dict];
        
    };
    _followUserAction.failedBlock = ^(NSError *error) {
        @strongify(self);
        if (self) {
            @weakify(self);
            dispatch_async(dispatch_get_main_queue(), ^{
                @strongify(self);
                [self.delegate SLUserlistCellFollowToast:[NSString stringWithFormat:@"%@失败",self.isFollow?@"取消":@"关注"] withIndex:self.attentionButton.tag];
            });
            [HDHud showMessageInView:KeyWindow title:error.userInfo[@"msg"]];
            
        }
    };
    _followUserAction.cancelledBlock = ^{
    };
    [_followUserAction start];
    
}


-(void)toChat{
    if (_delegate) {
        [_delegate SLUserlistCellToChatWithId:[NSString stringWithFormat:@"%@",_model.uid]];
    }
}
-(void)headPortraitClickAuthor
{
    [PageMgr pushToUserCenterControllerWithUserModel:_model viewcontroller:(BaseViewController *)self.viewController];
}
+ (float)rowHeightForObject:(id)object;
{
    return 146*Proportion375;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end

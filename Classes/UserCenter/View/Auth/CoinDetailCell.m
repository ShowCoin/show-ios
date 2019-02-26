//
//  CoinDetailCell.m
//  ShowLive
//
//  Created by zhangxinggong on 2018/4/2.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "CoinDetailCell.h"


@interface CoinDetailCell()<HeadPortraitDelegate>


@property (strong,nonatomic)SLHeadPortrait *logoView;
@property (strong,nonatomic)UILabel *nameLabel ;
@property (strong,nonatomic)UILabel *addressLabel;
@property (strong,nonatomic)UILabel *countLabel;
@property (strong,nonatomic)UILabel *dateLabel;
@property (strong,nonatomic)UILabel *statusLabel;

@end

@implementation CoinDetailCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle =  UITableViewCellSelectionStyleNone;
        
        self.logoView = [[SLHeadPortrait alloc]initWithFrame:CGRectMake(13*WScale, 13*WScale, 39*WScale, 39*WScale)];
        self.logoView.delegate = self;
        [self.contentView addSubview:self.logoView];
        
        self.countLabel = [[UILabel alloc]init];
        self.countLabel.font = Font_Regular(14*WScale);
        self.countLabel.textColor = kthemeBlackColor;
        self.countLabel.textAlignment = NSTextAlignmentRight;
        self.countLabel.text =@"+3.5000 秀币";
        [self.contentView addSubview:self.countLabel];
        [self.countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).with.offset(-21*WScale);
            make.centerY.equalTo(self.logoView).with.offset(1);
        }];
        
        UIView *middleView = [[UIView alloc]init];
        [self.contentView addSubview:middleView];
        [middleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView);
            make.left.equalTo(self.logoView.mas_right).with.offset(8*WScale);
            make.height.equalTo(self.contentView);
            make.right.equalTo(self.countLabel.mas_left).with.offset(-10*WScale);
        }];
        
        self.nameLabel = [[UILabel alloc]init];
        self.nameLabel.font = Font_Regular(12*WScale);
        self.nameLabel.textColor = kthemeBlackColor;
        self.nameLabel.text= @"Binantt Jia";
        [middleView addSubview:self.nameLabel];
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(middleView);
            make.top.equalTo(middleView).with.offset(12*WScale);
            make.height.equalTo(@(12*Proportion375));
        }];
        
        self.addressLabel = [[UILabel alloc]init];
        self.addressLabel.font = Font_Regular(12*WScale);
        self.addressLabel.lineBreakMode = NSLineBreakByTruncatingMiddle;
//        self.addressLabel.text = @"0xs7ehjif8...8jhuhe7h";
        self.addressLabel.textColor = kthemeBlackColor;
        [middleView addSubview:self.addressLabel];
        [self.addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(middleView);
            make.centerY.equalTo(self.logoView).with.offset(3);
            make.height.equalTo(middleView.mas_height).multipliedBy(0.3);
            make.width.equalTo(@(150));
        }];
        
        self.dateLabel = [[UILabel alloc]init];
        self.dateLabel.font = Font_Regular(8*WScale);
        self.dateLabel.textColor = kGrayWith999999;
        self.dateLabel.text= @"3/24/2018";
        [middleView addSubview:self.dateLabel];
        [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(middleView);
            make.height.equalTo(@(8*WScale));
            make.top.equalTo(self.addressLabel.mas_bottom).with.offset(3);
        }];
        
        self.statusLabel = [[UILabel alloc]init];
        
        self.statusLabel.font = Font_Regular(12*WScale);
        self.statusLabel.text= @"";
        self.statusLabel.textAlignment = NSTextAlignmentRight;
        [middleView addSubview:self.statusLabel];
        [self.statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(middleView);
            make.top.equalTo(self.countLabel.mas_bottom).with.offset(3);
        }];
        
    }
    return self ;
}
- (void)setModel:(TransactionRecordsModel *)model
{
    self.countLabel.text =@"+3.5000 秀币";
    self.dateLabel.text= @"3/24/2018";
    self.addressLabel.text = @"0xf416c78de9f3...2f837492a2be6c";
    self.nameLabel.text= @"Binantt Jia";

}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)bindModel:(id)object
{
    _model =(TransactionRecordsModel *)object;
    CGFloat number =  _model.showNumber.floatValue;
    
    self.countLabel.text =number<0?[NSString stringWithFormat:@"%@ 秀币", _model.showNumber]:[NSString stringWithFormat:@"+%@ 秀币", _model.showNumber];
    self.dateLabel.text= _model.date;
    self.addressLabel.text =number<0?_model.to_address:_model.from_address;
    self.nameLabel.text= number<0?_model.to_nickname:_model.from_nickname;
    self.countLabel.textColor =number<0?HexRGBAlpha(0xf54782, 1): HexRGBAlpha(0x69b12d, 1);
    [self.logoView setRoundStyle:YES imageUrl:number<0?_model.to_avatar:_model.from_avatar imageHeight:28 vip:NO attestation:number<0?NO:YES];
    
    if (_model.status) {
        [self.logoView setRoundStyle:YES imageUrl:_model.to_avatar imageHeight:28 vip:_model.status.integerValue==2?:NO attestation:NO];
        [self.countLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).with.offset(-21*WScale);
            make.centerY.equalTo(self.logoView).with.offset(-10);
        }];
        switch (_model.status.integerValue) {
            case 0:
                self.statusLabel.text = @"提现进行中";
                
                break;
            case 1:
                self.statusLabel.text = @"提现成功";
                
                break;
            case 2:
                self.statusLabel.text = @"提现失败";
                
                break;
                
            default:
                break;
        }
        self.countLabel.textColor =HexRGBAlpha(0xf54782, 1);
        self.statusLabel.textColor = HexRGBAlpha(0xf54782, 1);
        
        [self.statusLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.countLabel);
            make.height.equalTo(@(8*WScale));
            make.top.equalTo(self.countLabel.mas_bottom).with.offset(3);
        }];
        
    }

}
- (void)bindModel:(id)object withType:(NSString *)coinType{

    _model =(TransactionRecordsModel *)object;
    CGFloat number =  _model.showNumber.floatValue;
    
    self.countLabel.text =number<0?[NSString stringWithFormat:@"%@ %@", _model.showNumber,coinType]:[NSString stringWithFormat:@"+%@ %@", _model.showNumber,coinType];
    self.dateLabel.text= _model.date;
    self.addressLabel.text =number<0?_model.to_address:_model.from_address;
    self.nameLabel.text= number<0?_model.to_nickname:_model.from_nickname;
    self.countLabel.textColor =number<0?HexRGBAlpha(0xf54782, 1): HexRGBAlpha(0x69b12d, 1);
    [self.logoView setRoundStyle:YES imageUrl:number<0?_model.to_avatar:_model.from_avatar imageHeight:28 vip:NO attestation:number<0?NO:YES];

    if (_model.status) {
        [self.logoView setRoundStyle:YES imageUrl:_model.to_avatar imageHeight:28 vip:_model.status.integerValue==2?:NO attestation:NO];
        [self.countLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).with.offset(-21*WScale);
            make.centerY.equalTo(self.logoView).with.offset(-10);
        }];
        self.countLabel.text = [NSString stringWithFormat:@"%@ %@", _model.showNumber,coinType];
        switch (_model.status.integerValue) {
            case 0:
                self.statusLabel.text = @"提现进行中";
                self.statusLabel.textColor = kThemeGreenColor;

                break;
            case 1:
                self.statusLabel.text = @"提现成功";
                self.statusLabel.textColor = kGrayWith999999;

                break;
            case 2:
                self.statusLabel.text = @"提现失败";
                self.statusLabel.textColor = kThemeRedColor;

                break;

            default:
                break;
        }
//        self.countLabel.textColor =HexRGBAlpha(0xf54782, 1);

        [self.statusLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.countLabel);
            make.height.equalTo(@(8*WScale));
            make.top.equalTo(self.countLabel.mas_bottom).with.offset(3);
        }];

    }

}
- (void)headPortraitClickAuthor
{
    CGFloat number =  _model.showNumber.floatValue;
    ShowUserModel * model = [[ShowUserModel alloc]init];
    if (_model.to_uid.integerValue>0) {
        if (number < 0) {
            model.uid = _model.to_uid;
            model.avatar = _model.to_avatar;
            model.nickname = _model.to_nickname;
        }else{
            model.uid = _model.from_uid;
            model.avatar = _model.from_avatar;
            model.nickname = _model.from_nickname;

        }
        [PageMgr pushToUserCenterControllerWithUserModel:model viewcontroller:(BaseViewController *)self.viewController];
    }

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

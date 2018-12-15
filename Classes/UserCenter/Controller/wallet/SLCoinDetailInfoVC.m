//
//  SLCoinDetailInfoVC.m
//  ShowLive
//
//  Created by vning on 2018/5/4.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "SLCoinDetailInfoVC.h"

@interface SLCoinDetailInfoVC ()<HeadPortraitDelegate>
@end

@implementation SLCoinDetailInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationBarView setNavigationColor:NavigationColor1717];
//    [self.navigationBarView setNavigationTitle:@"交易记录"];
    [self setViews];
}
- (void)setTModel:(TransactionRecordsModel *)tModel
{
    _tModel = tModel;
    CGFloat number =  tModel.showNumber.floatValue;

}
-(void)setViews
{
    self.view.backgroundColor = kBlackWith17;

    UIImageView * bgImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 60*Proportion375 + KNaviBarHeight)];
//    [bgImg setImage:[UIImage imageNamed:@"wallet_bg"]];
    bgImg.backgroundColor = kBlackWith17;
    bgImg.clipsToBounds = YES;
    [self.view addSubview:bgImg];
    [self.view bringSubviewToFront:self.navigationBarView];
    
    UIView * bgView = [[UIView alloc] initWithFrame:CGRectMake(0, KNaviBarHeight, kMainScreenWidth, 60*Proportion375)];
    bgView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:bgView];
    
    UIImageView * sureImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 53*Proportion375, 53*Proportion375)];
    sureImg.centerX = kMainScreenWidth/2;
    sureImg.centerY = KNaviBarHeight + 60*Proportion375;
    [sureImg setImage:[UIImage imageNamed:@"acount_wallet_sure"]];
    [self.view addSubview:sureImg];
    
    UILabel * numLab = [UILabel labelWithFrame:CGRectMake(0, sureImg.bottom + 8*Proportion375, 200, 37*Proportion375) text:_tModel.showNumber textColor:kTextWithF7 font:Font_engRegular(37*Proportion375) backgroundColor:[UIColor clearColor]];
    [numLab sizeToFit];
    numLab.centerX = kMainScreenWidth/2;
    numLab.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:numLab];
    
    
    UILabel * numLabP = [UILabel labelWithFrame:CGRectMake(0, sureImg.bottom + 25*Proportion375, 200, 14*Proportion375) text:self.walletModel.type textColor:kTextWith8b font:Font_Medium(14*Proportion375) backgroundColor:[UIColor clearColor]];
    [numLabP sizeToFit];
    numLabP.centerX = kMainScreenWidth/2;
    numLabP.top = numLab.bottom + 11*Proportion375;
    numLabP.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:numLabP];

//    UIView * lineView1 = [[UIView alloc] initWithFrame:CGRectMake(25*Proportion375, 0, kMainScreenWidth-50*Proportion375, 1)];
//    lineView1.top = bgView.bottom+ 100*Proportion375;
//    lineView1.backgroundColor = kSeparationColor;
//    [self.view addSubview:lineView1];
    
    SLHeadPortrait * senderHeader = [[SLHeadPortrait alloc] initWithFrame:CGRectMake(16*Proportion375, numLabP.bottom + 37*Proportion375, 34*Proportion375, 34*Proportion375)];
    [senderHeader setRoundStyle:YES imageUrl:_tModel.from_avatar imageHeight:28 vip:NO attestation:NO];
    senderHeader.delegate = self;
    senderHeader.tag = 1000;
    [self.view addSubview:senderHeader];
    
    UILabel * senderLab = [UILabel labelWithFrame:CGRectMake(0, sureImg.bottom + 20*Proportion375, 200, 14*Proportion375) text:@"发款方" textColor:kTextWith8b font:Font_Regular(14*Proportion375) backgroundColor:[UIColor clearColor]];
    [senderLab sizeToFit];
    senderLab.left = senderHeader.right + 8*Proportion375;
    senderLab.top = senderHeader.top+ 2*Proportion375;
    senderLab.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:senderLab];
    
    
    UILabel * senderName = [UILabel labelWithFrame:CGRectMake(0, 0, 200, 14*Proportion375) text:_tModel.from_nickname textColor:kTextWithF7 font:Font_Regular(14*Proportion375) backgroundColor:[UIColor clearColor]];
    [senderName sizeToFit];
    senderName.left = senderLab.right + 8*Proportion375;
    senderName.top = senderHeader.top+ 2*Proportion375;
    senderName.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:senderName];
    
    UILabel * idLab = [UILabel labelWithFrame:CGRectMake(0, senderLab.bottom + 3*Proportion375, 200, 11*Proportion375) text:_tModel.from_address textColor:kTextWithF7 font:Font_engRegular(11*Proportion375) backgroundColor:[UIColor clearColor]];
    idLab.lineBreakMode = NSLineBreakByTruncatingMiddle;
    idLab.textAlignment = NSTextAlignmentLeft;
    [idLab sizeToFit];
    idLab.left = senderHeader.right + 8*Proportion375;
    idLab.width = kMainScreenWidth - idLab.left - 10;
    [self.view addSubview:idLab];
    
    
    SLHeadPortrait * receivedHeader = [[SLHeadPortrait alloc] initWithFrame:CGRectMake(16*Proportion375, senderHeader.bottom + 26*Proportion375, 34*Proportion375, 34*Proportion375)];
    [receivedHeader setRoundStyle:YES imageUrl:_tModel.to_avatar imageHeight:28 vip:NO attestation:YES];
    receivedHeader.delegate= self;
    receivedHeader.tag = 2000;
    [self.view addSubview:receivedHeader];
    
    UILabel * receivedLab = [UILabel labelWithFrame:CGRectMake(0, 0, 200, 14*Proportion375) text:@"收款方" textColor:kTextWith8b font:Font_Regular(14*Proportion375) backgroundColor:[UIColor clearColor]];
    [receivedLab sizeToFit];
    receivedLab.left = receivedHeader.right + 8*Proportion375;
    receivedLab.top = receivedHeader.top + 2*Proportion375;
    receivedLab.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:receivedLab];
    
    
    UILabel * receivedName = [UILabel labelWithFrame:CGRectMake(0, sureImg.bottom + 20*Proportion375, 200, 14*Proportion375) text:_tModel.to_nickname textColor:kTextWithF7 font:Font_Regular(14*Proportion375) backgroundColor:[UIColor clearColor]];
    [receivedName sizeToFit];
    receivedName.left = receivedLab.right + 8*Proportion375;
    receivedName.top = receivedLab.top;
    receivedName.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:receivedName];
    
    UILabel * receivedidLab = [UILabel labelWithFrame:CGRectMake(0, receivedName.bottom + 6*Proportion375, 200, 11*Proportion375) text:_tModel.to_address textColor:kTextWithF7 font:Font_engRegular(11*Proportion375) backgroundColor:[UIColor clearColor]];
    receivedidLab.lineBreakMode = NSLineBreakByTruncatingMiddle;
    receivedidLab.textAlignment = NSTextAlignmentLeft;
    [receivedidLab sizeToFit];
    receivedidLab.left = senderHeader.right + 8*Proportion375;
    receivedidLab.top = receivedLab.bottom + 3*Proportion375;
    receivedidLab.width = kMainScreenWidth - idLab.left - 10;
    [self.view addSubview:receivedidLab];
    
    
    UILabel * moneyTitle = [UILabel labelWithFrame:CGRectMake(receivedidLab.left, receivedHeader.bottom + 35*Proportion375, 200, 14*Proportion375) text:@"手续费" textColor:kTextWith8b font:Font_Regular(14*Proportion375) backgroundColor:[UIColor clearColor]];
//    [moneyTitle sizeToFit];
    moneyTitle.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:moneyTitle];

    UILabel * moneyNum = [UILabel labelWithFrame:CGRectMake(receivedidLab.left, moneyTitle.bottom + 3*Proportion375, 200, 14*Proportion375) text:[NSString stringWithFormat:@"%@ %@",_tModel.service_fee,self.walletModel.typeCName] textColor:kTextWithF7 font:Font_Regular(14*Proportion375) backgroundColor:[UIColor clearColor]];
//    [moneyNum sizeToFit];
    moneyNum.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:moneyNum];
    
    
    UILabel * psTitle = [UILabel labelWithFrame:CGRectMake(receivedidLab.left, moneyNum.bottom + 35*Proportion375, 200, 14*Proportion375) text:@"备注" textColor:kTextWith8b font:Font_Regular(14*Proportion375) backgroundColor:[UIColor clearColor]];
//    [psTitle sizeToFit];
    psTitle.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:psTitle];
    
    UILabel *  psDetail = [UILabel labelWithFrame:CGRectMake(receivedidLab.left, psTitle.bottom + 3*Proportion375, 200, 14*Proportion375) text:_tModel.comment textColor:kTextWithF7 font:Font_Regular(14*Proportion375) backgroundColor:[UIColor clearColor]];
//    [psDetail sizeToFit];
    psDetail.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:psDetail];
    
    
//    UIView * lineView2 = [[UIView alloc] initWithFrame:CGRectMake(25*Proportion375, 0, kMainScreenWidth-50*Proportion375, 1)];
//    lineView2.top = lineView1.bottom+ 210*Proportion375;
//    lineView2.backgroundColor = kSeparationColor;
//    [self.view addSubview:lineView2];
//
    
    UILabel * dealNum = [UILabel labelWithFrame:CGRectMake(receivedidLab.left, psDetail.bottom + 35*Proportion375, 200, 14*Proportion375) text:@"交易号" textColor:kTextWith8b font:Font_Regular(14*Proportion375) backgroundColor:[UIColor clearColor]];
    //    [moneyTitle sizeToFit];
    dealNum.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:dealNum];
    
    UILabel * dealNumdetail = [UILabel labelWithFrame:CGRectMake(receivedidLab.left, dealNum.bottom + 3*Proportion375, 200, 14*Proportion375) text:_tModel.transaction_id textColor:kTextWithF7 font:Font_engRegular(14*Proportion375) backgroundColor:[UIColor clearColor]];
    //    [moneyNum sizeToFit];
    dealNumdetail.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:dealNumdetail];
    
    
    UILabel * dealTime = [UILabel labelWithFrame:CGRectMake(receivedidLab.left, dealNumdetail.bottom + 35*Proportion375, 200, 14*Proportion375) text:@"交易时间" textColor:kTextWith8b font:Font_Regular(14*Proportion375) backgroundColor:[UIColor clearColor]];
    //    [psTitle sizeToFit];
    dealTime.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:dealTime];
    
    UILabel *  dealTimeDetail = [UILabel labelWithFrame:CGRectMake(receivedidLab.left, dealTime.bottom + 3*Proportion375, 200, 14*Proportion375) text:[NSString stringWithFormat:@"%@ + 0800",_tModel.date] textColor:kTextWithF7 font:Font_engRegular(14*Proportion375) backgroundColor:[UIColor clearColor]];
    //    [psDetail sizeToFit];
    dealTimeDetail.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:dealTimeDetail];

    
    
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

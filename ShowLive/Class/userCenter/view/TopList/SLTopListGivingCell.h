//
//  SLTopListGivingCell.h
//  ShowLive
//
//  Created by vning on 2018/4/12.
//  Copyright © 2018年 vning. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SLTopListTabelView.h"
typedef NS_ENUM(NSInteger,cellType) {//
    CellType_Normal = 0,
    CellType_First  = 1,
    CellType_Second  = 2,
    CellType_Third  = 3,
};

@interface SLTopListGivingCell : UITableViewCell
@property (strong,nonatomic)UILabel * numLab;
@property (strong,nonatomic)UIImageView * numImg;
@property (strong,nonatomic)UIImageView * avatar_normal;
@property (strong,nonatomic)UIImageView * avatar_topOne;
@property (strong,nonatomic)UIImageView * avatar_topOne_bg;
@property (strong,nonatomic)UIImageView * avatar_topOne_top;
@property (strong,nonatomic)UIImageView * avatar_topTwo;
@property (strong,nonatomic)UIImageView * avatar_topTwo_bg;
@property (strong,nonatomic)UILabel * nameLab;
@property (strong,nonatomic)UILabel * textLab;
//@property (strong,nonatomic)UILabel * inviteLab;
@property (strong,nonatomic)UIImageView * sexImg;
@property (strong,nonatomic)UIImageView * holdLevelImg;
@property (strong,nonatomic)UIImageView * sendLevelImg;
@property (strong,nonatomic)UIButton * concernBtn;
@property (strong,nonatomic)UIView * lineview;
@property (assign,nonatomic)cellType celltype;
@property(nonatomic,assign)TopListType topListType;
@property(nonatomic,strong)ShowUserModel * datamodel;
@property(nonatomic,assign)NSInteger index;


@end

//
//  NewTopListCell.h
//  ShowLive
//
//  Created by vning on 2019/1/25.
//  Copyright © 2019 vning. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShowUserModel.h"

NS_ASSUME_NONNULL_BEGIN
@class NewTopListCell;

@protocol NewTopListCellDelegate <NSObject>
@optional

-(void)SLUserListCellAttentionBtn:(UIButton *)attentionBtn clickedWithData:(id)celldata;

-(void)SLUserlistCellFollowToast:(NSString *)toastStr withIndex:(NSInteger)index;

-(void)SLUserlistCellToChatWithId:(NSString *)userId;

-(void)SLUserlistCellToDeleteWithId:(NSString *)userId;

@end

@interface NewTopListCell : UITableViewCell<HeadPortraitDelegate>
@property(nonatomic,strong)ShowUserModel * model;
@property(nonatomic,weak)id<NewTopListCellDelegate>delegate;
@property(nonatomic,assign)NSInteger          type;
@property (nonatomic, assign) BOOL                isFollow;
@property(nonatomic,strong)SLHeadPortrait       * headPortrait;
@property(nonatomic,strong)UIImageView          * headPortraitBg;
@property(nonatomic,strong)UIImageView          * headPortraitIsLiveBg;
@property(nonatomic,strong)UIImageView          * NumImg;
@property(nonatomic,strong)UILabel              * NumLab;

@property(nonatomic,strong)UILabel              * nickNameLabel;
@property(nonatomic,strong)UIImageView          * sexImg;
@property (nonatomic,strong)SLLevelMarkView *  masterLevel;
@property (nonatomic,strong)SLLevelMarkView *  showLevel;
@property(nonatomic,strong)UILabel              * detailNameLable;

@property(nonatomic,strong)UILabel     * LabFir;
@property(nonatomic,strong)UILabel     * LabSec;
@property(nonatomic,strong)UILabel     * LabThird;
@property(nonatomic,strong)UILabel     * showCoin;
@property(nonatomic,strong)UILabel     * contentLabel;
@property(nonatomic,strong)UIButton    * attentionButton;
@property(nonatomic,strong)UIView        * lineView;
@property(nonatomic,strong)SLFollowUserAction * followUserAction;


-(void)setmodel:(ShowUserModel *)model withCellType:(NSInteger)celltype;

@end

NS_ASSUME_NONNULL_END

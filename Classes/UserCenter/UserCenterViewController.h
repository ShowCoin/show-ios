//
//  UserCenterViewController.h
//  ShowLive
//
//  Created by vning on 2018/3/29.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "BaseViewController.h"
#import "SLUserViewHeader.h"

#define HeaderHeightWithoutWords        455*Proportion375

@protocol UserCenterDelegate <NSObject>
typedef NS_ENUM(NSInteger,SLLiveListCellType) {
    SLLiveListCellType_homeView  = 1,
    SLLiveListCellType_Usercenter  = 2,
};
-(void)UserCenterConcernDelegateWithModel:(ShowUserModel *)model;

@optional

@end
@interface UserCenterViewController : BaseViewController<UICollectionViewDelegate,UICollectionViewDataSource,SLUserViewHeaderDelegate>
@property (nonatomic,strong)UICollectionView * mainCollectionView;
@property (nonatomic,strong)UIView * floatView;
@property (nonatomic,assign)BOOL IsMe;
@property (nonatomic,strong)ShowUserModel * userModel;
@property (nonatomic, weak) id<UserCenterDelegate> delegate;

- (instancetype)initWithIsMe:(BOOL)isme andUserModel:(ShowUserModel *)usermodel;
//跳转他们个人页数据模型   初始化填入
@end

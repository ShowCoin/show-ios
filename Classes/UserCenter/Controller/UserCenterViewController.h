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

//用户中心
@property (nonatomic,strong)UICollectionView * mainCollectionView;
//浮层
@property (nonatomic,strong)UIView * floatView;
//是否是我
@property (nonatomic,assign)BOOL IsMe;
//用户模型
@property (nonatomic,strong)ShowUserModel * userModel;
//用户中心代理
@property (nonatomic, weak) id<UserCenterDelegate> delegate;

//跳转他们个人页数据模型   初始化填入
- (instancetype)initWithIsMe:(BOOL)isme andUserModel:(ShowUserModel *)usermodel;


@end

//
//  HomeHeader.h
//  ShowLive
//
//  Created by vning on 2018/4/9.
//  Copyright © 2018年 vning. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SLMessageButton.h"

@class HomeHeader;

@protocol HomeHeaderDelegate <NSObject>

@optional

-(void)navTabAaction:(UIButton *)sender;
-(void)navTabBaction:(UIButton *)sender;
-(void)navTabCaction:(UIButton *)sender;
-(void)leftBtnClick:(UIButton *)sender;
-(void)rightBtnClick:(UIButton *)sender;

@end

@interface HomeHeader : UIView

@property (nonatomic, weak) id <HomeHeaderDelegate> delegate;
@property (nonatomic, strong) SLMessageButton *rightBtn;

+ (instancetype)authViewWithFrame:(CGRect)frame;
- (void)changePageIndex:(NSInteger)index;

+ (BOOL)isHot;

- (void)showHeader:(BOOL)show;

- (void)resetHomeHeaderView;

@end

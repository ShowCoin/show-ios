//
//  HomeHeader.h
//  ShowLive
//
//  Created by vning on 2018/4/9.
//  Copyright © 2018年 vning. All rights reserved.
//

#import <UIKit/UIKit.h>
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
@property(nonatomic,weak)id<HomeHeaderDelegate>delegate;

+ (instancetype)authViewWithFrame:(CGRect)frame;
-(void)changePageIndex:(NSInteger)index;
@end

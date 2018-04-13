//
//  SLTopMemberView.h
//  ShowLive
//
//  Created by 巩鑫 on 2018/4/9.
//  Copyright © 2018年 vning. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SLTopMemberView : UICollectionView

@property(nonatomic,strong)NSArray * memberArray;

//刷新更变UI 前移
-(void)changeAudienceWidth:(CGFloat)width;

//后移
-(void)changeBackAudienceWithWidth:(CGFloat)width;

@end

//
//  SLLiveLoadingView.h
//  ShowLive
//
//  Created by WorkNew on 2018/4/14.
//  Copyright © 2018年 VNing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SLLiveLoadingView : UIView

@property(nonatomic,strong)UIButton    * closeButton;

@property(nonatomic,strong)UIImageView * coverImageView;

-(void)showLoadingCover:(NSString*)cover
                   text:(NSString*)text
                   view:(UIView*)view;

-(void)removeLoading;
@end

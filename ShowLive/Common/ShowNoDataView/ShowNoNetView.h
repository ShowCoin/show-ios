//
//  ShowNoNetView.h
//  ShowLive
//
//  Created by 周华 on 2018/3/21.
//  Copyright © 2018年 vning. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum
{
    NoNetWorkViewStyle_No_NetWork=0,
    NoNetWorkViewStyle_Load_Fail
}NoNetWorkViewStyle;
@protocol NoNetWorkViewDelegate ;
@interface ShowNoNetView : UIView

@property (weak,nonatomic) id<NoNetWorkViewDelegate> delegate;
@property (nonatomic, copy) dispatch_block_t reloadDataBlock;

-(void)showInView:(UIView*)superView style:(NoNetWorkViewStyle)style;
-(void)hide;
@end

@protocol NoNetWorkViewDelegate <NSObject>

-(void)retryToGetData;

@end

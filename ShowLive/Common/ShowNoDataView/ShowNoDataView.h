//
//  ShowNoDataView.h
//  ShowLive
//
//  Created by 周华 on 2018/3/21.
//  Copyright © 2018年 vning. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DWTagList.h"

@protocol NoDataViewDelegate;
typedef enum{
    kNoDataType_Default     = 0,
    kNoDataType_Smile       = 1,
}NODataType;

@interface ShowNoDataView : UIView <DWTagListDelegate>
@property (nonatomic,weak) id<NoDataViewDelegate> delegate;



-(void)showNoDataViewController:(UIViewController *)viewController noDataType:(NODataType)type;
-(void)hide;

-(void)showNoDataView:(UIView*)superView noDataType:(NODataType)type;
-(void)setContentViewFrame:(CGRect)rect;
-(void)setColor:(UIColor*)color;
-(void)showNoDataView:(UIView*)superView noDataString:(NSString *)noDataString;
-(void)showNoDataView:(UIView*)superView tagsString:(NSString *)tagsString andminAge:(NSString *)minAge maxAge:(NSString *)maxAge;
//-(void)showNoDataView:(UIView*)superView
-(void)showSmileNodataView:(UIView*)superView noDataString:(NSString *)noDataString;

- (void)hiddenImageIcon;

- (void)setImage:(NSString *)imageStr;

@end

@protocol NoDataViewDelegate <NSObject>

-(void)didClickedNoDataButton;
-(void)didClickGoChooseButton;
-(void)didClickTagStr:(NSString*)tagStr OrminAge:(NSString*)minAge maxAge:(NSString *)maxAge;


@end

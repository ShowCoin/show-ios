//
//  SLToplistSubView.h
//  ShowLive
//
//  Created by vning on 2018/4/12.
//  Copyright © 2018年 vning. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger,TopViewType) {//
    TopViewType_Contribution= 0,//贡献
    TopViewType_Encourage= 1,//激励
};
@interface SLToplistSubView : UIView

@property(nonatomic,assign)TopViewType viewType;
@property (nonatomic, copy) NSString *uid;

+ (instancetype)authViewWithFrame:(CGRect)frame andUid:(NSString *)uid;
@end

//
//  SLLevelView.h
//  ShowLive
//
//  Created by iori_chou on 2018/4/25.
//  Copyright © 2018年 vning. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum : NSUInteger {
    LevelType_ShowCoin,        //  财富等级
    LevelType_Host,        //  主播等级
} LevelType;

@interface SLLevelMarkView : UIView
//等级类型
@property (nonatomic , assign) LevelType type;

@end

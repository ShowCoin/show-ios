//
//  SLMiniCardManager.h
//  ShowLive
//
//  Created by gongxin on 2018/4/19.
//  Copyright © 2018年 vning. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SLMiniCardManager : NSObject

+(instancetype)shareInstance;


//展示
-(void)showMiniCard:(NSString*)userId
          isManager:(BOOL)isManager;

//隐藏
-(void)hide;

@end

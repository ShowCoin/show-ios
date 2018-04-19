//
//  SLADView.m
//  ShowLive
//
//  Created by iori_chou on 2018/4/17.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "SLADModel.h"

@implementation SLADModel
-(void)saveWithDictionary:(NSDictionary *)ConfigDict;
{
    if(self && [ConfigDict isKindOfClass:[NSDictionary class]]) {
        [self setValuesForKeysWithDictionary:ConfigDict];
    }
    
}

@end

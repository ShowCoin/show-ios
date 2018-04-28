//
//  SLADView.m
//  ShowLive
//
//  Created by NicholasChou on 2018/4/17.
//  Copyright © 2018年 VNing. All rights reserved.
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

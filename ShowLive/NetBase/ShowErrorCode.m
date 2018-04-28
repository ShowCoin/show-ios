//
//  ShowErrorCode.m
//  ShowLive
//
//  Created by Mac on 2018/3/21.
//  Copyright © 2018年 VNing. All rights reserved.
//

#import "ShowErrorCode.h"

@implementation ShowErrorCode
+(BOOL)serviceCode:(NSInteger)code{
    return [[self codeList] containsObject:@(code).stringValue];
}

+(NSArray *)codeList{
    return @[];
}

@end

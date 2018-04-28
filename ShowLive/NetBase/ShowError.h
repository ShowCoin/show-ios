//
//  ShowError.h
//  ShowLive
//
//  Created by Mac on 2018/3/21.
//  Copyright © 2018年 VNing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShowError : NSObject
+(NSError *)errorWithDomain:(NSString *)domain message:(NSString *)message code:(NSInteger)code;

+(NSError *)error:(NSError *)error;

@end

//
//  SLWebViewScriptMessage.h
//  ShowLive
//
//  Created by iori_chou on 2018/4/20.
//  Copyright © 2018年 vning. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SLWebViewScriptMessage : NSObject
@property (strong, nonatomic) id body;
@property (strong, nonatomic) NSString *name;

+ (instancetype)messageWithName:(NSString *)name body:(id)body;

@end

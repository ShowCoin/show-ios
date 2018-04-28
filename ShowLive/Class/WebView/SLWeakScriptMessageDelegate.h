//
//  SLWeakScriptMessageDelegate.h
//  ShowLive
//
//  Created by NicholasChou on 2018/4/20.
//  Copyright © 2018年 VNing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WebKit/WebKit.h>
@interface SLWeakScriptMessageDelegate : NSObject<WKScriptMessageHandler>
@property (nonatomic, assign) id<WKScriptMessageHandler> scriptDelegate;

- (instancetype)initWithDelegate:(id<WKScriptMessageHandler>)scriptDelegate;

@end

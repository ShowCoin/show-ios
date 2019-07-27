//
//  SLWeakScriptMessageDelegate.h
//  ShowLive
//
//  Created by iori_chou on 2018/4/20.
//  Copyright © 2018年 vning. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WebKit/WebKit.h>
@interface SLWeakScriptMessageDelegate : NSObject<WKScriptMessageHandler>
@property (nonatomic, assign) id<WKScriptMessageHandler> scriptDelegate;
//初始化delegate
- (instancetype)initWithDelegate:(id<WKScriptMessageHandler>)scriptDelegate;

@end

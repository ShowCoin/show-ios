//
//  SLBaseViewController.h
//  ShowLive
//
//  Created by iori_chou on 2018/4/20.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "BaseViewController.h"
#import "SLWebViewJSFuncNameConst.h"
#import "SLWebView.h"

NS_ASSUME_NONNULL_BEGIN
//基本的web
/// Subclass override to implement JS call back
@protocol SLBaseWebViewControllerSubclassJSHooks <NSObject>
@optional
/// Register Func names supply for JS.
- (nullable NSArray<NSString *> *)registeredJavaScriptMessageHandlerNames;
/// JS call back handle with message @see SLWebView
- (void)handleDidReceiveScriptMessage:(SLWebViewScriptMessage *)message;
@end

typedef void (^SLWebViewScriptMessageCallHandler)(SLWebViewScriptMessage *message);

/// You can subclass, override <SLBaseWebViewControllerSubclassJSHooks> to implement js call back.or simple directly use -registerJSFuncs:callHandler: to register and handle message call back.
@interface SLBaseWebViewController : BaseViewController<SLBaseWebViewControllerSubclassJSHooks>

@property (strong, nonatomic, readonly) SLWebView *webView;
@property (strong, nonatomic) NSString *requestUrl;

/// Directly to register JS funcs and handler message call back.according to message.name and message.body.
- (void)registerJSFuncs:(nullable NSArray <NSString *> *)funcNames jsCallHandler:(SLWebViewScriptMessageCallHandler)jsCallHandler;

@end

NS_ASSUME_NONNULL_END


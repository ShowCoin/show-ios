//
//  SLWebView.h
//  ShowLive
//
//  Created by iori_chou on 2018/4/20.
//  Copyright © 2018年 vning. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
#import "SLWebViewScriptMessage.h"
@class SLWebView;
@protocol SLWebViewDelegate <NSObject>
@optional
- (void)SL_webViewDidStartLoad:(SLWebView *)webView;
- (void)SL_webView:(SLWebView *)webView didFinishLoadingURL:(NSURL *)URL;
- (void)SL_webView:(SLWebView *)webView didFailToLoadURL:(NSURL *)URL error:(NSError *)error;
- (void)SL_webView:(SLWebView *)webView didReceiveScriptMessage:(SLWebViewScriptMessage *)message;
- (BOOL)SL_webView:(SLWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(WKNavigationType)navigationType;
@end
@interface SLWebView : WKWebView
@property (weak, nonatomic) id<SLWebViewDelegate> interactDelegate;

/* Customize progressView */
@property (strong, nonatomic, readonly) UIProgressView *progressView;
/// Progress color
@property (strong, nonatomic) UIColor *progressTintColor;
/// background color
@property (strong, nonatomic) UIColor *progressTrackTintColor;

/// 是否开启加载的log，默认NO
@property (assign, nonatomic) BOOL openLog;

+ (instancetype)webViewWithFrame:(CGRect)frame;
/**
 @brief 此方法用来注册供JS调用的方法名,可注册多个
 
 JS通过调用此方法：
 @code window.webkit.messageHandlers.<name>.postMessage(<messageBody>);
 // 注意: <messageBody>可以是字典、数组等,对应body字段
 // 例如:
 function testFunc() {
 var message = { 'message' : 'hello, world', 'numbers' : [1,2,3] };
 window.webkit.messageHandlers.testfunc.postMessage(message);
 }
 @endcode
 
 @remark 例子.
 @code
 // 1.app调用
 [self addScriptMessageHandlerWithName:@"testName"];
 
 // 2.js调用,并传参数:"testbodystring"
 window.webkit.messageHandlers.testName.postMessage('testbodystring');
 
 // 3.客户端在此回调中获得该message信息,根据name和body做出相应处理
 - (void)SL_webView:(SLWebView *)webView didReceiveScriptMessage:(SLWebViewScriptMessage *)message
 {
 if ([message.name isEqualToString:@"testName"]) {
 if ([message.body isKindOfClass:[NSString class]] &&
 [message.body isEqualToString:@"testbodystring"]) {
 // do something
 }
 }
 }
 @endcode
 @param name method名称
 */
- (void)addScriptMessageHandlerWithName:(NSString *)name;

@end

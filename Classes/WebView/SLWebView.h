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

- (void)addScriptMessageHandlerWithName:(NSString *)name;

@end

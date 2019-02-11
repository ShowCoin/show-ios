//
//  SLBaseViewController.m
//  ShowLive
//
//  Created by iori_chou on 2018/4/20.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "SLBaseWebViewController.h"
#import "SLBaseWebViewRequestHelper.h"

@interface SLBaseWebViewController ()<SLWebViewDelegate>
@property (nonatomic, strong) SLWebView *webView;
@property (nonatomic, strong) UIButton *closeBtn;
@property (nonatomic, strong) UIButton *backButton;
@property (nonatomic, assign) BOOL isGoBackRequest;
@property (nonatomic, copy) SLWebViewScriptMessageCallHandler messageCallHandler;
@end

@implementation SLBaseWebViewController

#pragma mark - LifeCycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupData];
    [self loadUrlRequest];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (!self.webView.isLoading) {
        [self.webView reload];
    }
}

#pragma mark - setup
- (void)setupData
{
    [self.view addSubview:self.webView];
}
//加载URL
- (void)loadUrlRequest
{
    if (!self.requestUrl) {
        self.requestUrl = @"http://www.show-one.com";
    }
    NSURL *url = [NSURL URLWithString:self.requestUrl];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
}

- (void)registerMessageHandlers
{
    NSArray *array = [self registeredJavaScriptMessageHandlerNames];
    for (NSString *name in array) {
        [self.webView addScriptMessageHandlerWithName:name];
    }
}

- (void)registerJSFuncs:(nullable NSArray <NSString *> *)funcNames jsCallHandler:(SLWebViewScriptMessageCallHandler)jsCallHandler
{
    self.messageCallHandler = jsCallHandler;
    for (NSString *name in funcNames) {
        [self.webView addScriptMessageHandlerWithName:name];
    }
}

#pragma mark - Getter
- (SLWebView *)webView
{
    if (!_webView) {
        _webView = [SLWebView webViewWithFrame:CGRectMake(0, kNaviBarHeight, kMainScreenWidth, kMainScreenHeight-kNaviBarHeight-KTabbarSafeBottomMargin)];
        _webView.interactDelegate = self;
        // 左滑后退
        _webView.allowsBackForwardNavigationGestures = YES;
        [self registerMessageHandlers];
    }
    return _webView;
}

- (UIButton *)closeBtn
{
    if (!_closeBtn) {
        _closeBtn = [[UIButton alloc] initWithFrame:CGRectMake(8+44 ,kNaviBarHeight - 44, 44, 44)];
        [_closeBtn setTitle:@"关闭" forState:UIControlStateNormal];
        _closeBtn.titleLabel.font = Font_Regular(16);
        [_closeBtn setTitleColor:Color(@"666666") forState:UIControlStateNormal];
        _closeBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [_closeBtn addTarget:self action:@selector(closeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        _closeBtn.hidden = YES;
    }
    return _closeBtn;
}

- (UIButton*)backButton
{
    if (!_backButton) {
        _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backButton setFrame:CGRectMake(10, kNaviBarHeight-44, 44, 44)];
        
        [_backButton setImage:[UIImage imageNamed:@"nav_back_gray"] forState:UIControlStateNormal];
        _backButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        
        [_backButton addTarget:self action:@selector(backButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backButton;
}

#pragma mark - Actions
- (void)closeBtnClick:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)backButtonClick:(UIButton*)btn
{
    if (self.webView.canGoBack) {
        self.isGoBackRequest = YES;
        [self.webView goBack];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - SLWebViewDelegate
- (BOOL)SL_webView:(SLWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(WKNavigationType)navigationType
{
    if (self.isGoBackRequest) {
        // 重置一下,返回action不需要加载头
        self.isGoBackRequest = NO;
        return YES;
    }
    return [self shouldStartLoadRequest:request];
}

- (void)SL_webViewDidStartLoad:(SLWebView *)webView
{
    
}

- (void)SL_webView:(SLWebView *)webView didFinishLoadingURL:(NSURL *)URL
{
    [self.navigationBarView setNavigationTitle:self.webView.title];
    self.closeBtn.hidden = !webView.canGoBack;
}

- (void)SL_webView:(SLWebView *)webView didFailToLoadURL:(NSURL *)URL error:(NSError *)error
{
    [self.navigationBarView setNavigationTitle:self.webView.title];
    self.closeBtn.hidden = !webView.canGoBack;
}

- (void)SL_webView:(SLWebView *)webView didReceiveScriptMessage:(SLWebViewScriptMessage *)message
{
    NSLog(@"|======= JS call OC =======|:\nname:%@\nbody:%@", message.name, message.body);
    [self handleDidReceiveScriptMessage:message];
    if (self.messageCallHandler) {
        self.messageCallHandler(message);
    }
}

#pragma mark - Private
- (BOOL)shouldStartLoadRequest:(NSURLRequest *)request
{
    NSString *urlString = [[request URL]  absoluteString];
    NSLog(@"==> %@",urlString);
    NSDictionary *requestHeaders = request.allHTTPHeaderFields;
    // 判断请求头是否已包含，如果不判断该字段会导致webview加载时死循环
    if (requestHeaders[@"App-Version"]) {
        return YES;
    }
    [self.webView loadRequest:[SLBaseWebViewRequestHelper requestAppendAppInfo:request]];
    return NO;
}

#pragma mark - SLBaseWebViewControllerSubclassHooks
- (nullable NSArray<NSString *> *)registeredJavaScriptMessageHandlerNames
{
    NSLog(@"subclass not implement it.");
    return nil;
}

- (void)handleDidReceiveScriptMessage:(SLWebViewScriptMessage *)message
{
    NSLog(@"subclass not implement it.");
}
@end

//
//  SLWebViewController.h
//  ShowLive
//
//  Created by iori_chou on 2018/4/24.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "BaseViewController.h"
#import <NJKWebViewProgress.h>
#import <NJKWebViewProgressView.h>
#import "SLUserShareView.h"

@interface SLWebViewController : BaseViewController<UIWebViewDelegate, NJKWebViewProgressDelegate,SLUserShareViewDelegate>
{
    
    NJKWebViewProgressView *_webViewProgressView;
    NJKWebViewProgress *_webViewProgress;
}

//返回按钮
@property(nonatomic,strong)UIButton * BackButton;
//浏览器页面
@property(nonatomic,strong)UIWebView * WebView;
//请求的Url
@property(nonatomic,copy)NSString *  requestUrl;
//web标题
@property(nonatomic,copy)NSString * webTitle;
//返回的image
@property (nonatomic,strong)UIImage * backimage;
//分享
@property (nonatomic, strong) SLUserShareView *shareview;
//分享的id
@property (nonatomic, strong) NSString *shareUid;
//分享的视图Avaliable
@property (assign, nonatomic) BOOL shareViewAvaliable;


@end


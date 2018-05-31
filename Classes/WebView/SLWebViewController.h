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


@property(nonatomic,strong)UIButton * BackButton;

@property(nonatomic,strong)UIWebView * WebView;

@property(nonatomic,copy)NSString *  requestUrl;

@property(nonatomic,copy)NSString * webTitle;

@property (nonatomic,strong)UIImage * backimage;

@property (nonatomic, strong) SLUserShareView *shareview;

@property (nonatomic, strong) NSString *shareUid;

@property (assign, nonatomic) BOOL shareViewAvaliable;


@end


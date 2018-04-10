//
//  HDHud.m
//  CreditGroup
//
//  Created by ang on 14/8/27.
//  Copyright (c) 2014年 JPlay. All rights reserved.
//

#import "HDHud.h"

@implementation HDHud

+(MBProgressHUD *)showHUDInView:(UIView *)view title:(NSString *)title
{
    if ([NSThread isMainThread]) {
        return [self _showHUDInView:view title:title];
    }else{
        dispatch_async(dispatch_get_main_queue(), ^{
            [self _showHUDInView:view title:title];
        });
    }
    return nil;
}

+(MBProgressHUD *)_showHUDInView:(UIView *)view title:(NSString *)title{
    UIView* masterView = [kMainWindow viewWithTag:1001];
    if (masterView==nil) {
        UIView* masterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight)];
        masterView.tag = 1001;
        masterView.backgroundColor=[UIColor clearColor];
        [kMainWindow addSubview:masterView];
    }
    BOOL isVideo = YES;//[title isEqualToString:@"视频处理中..."];
    
    // 禁止TableView滚动
    if ([view respondsToSelector:@selector(setScrollEnabled:)]) {
        [(UIScrollView*)view setScrollEnabled:NO];
    }
    MBProgressHUD *HUDInView = [MBProgressHUD showHUDAddedTo:kMainWindow animated:YES];
    HUDInView.center = kMainWindow.center;

    HUDInView.removeFromSuperViewOnHide = YES;
    HUDInView.labelText = title;
//    HUDInView.square = YES;
    HUDInView.color = [Color(@"181818") colorWithAlphaComponent:0.9];
    HUDInView.mode = isVideo ? MBProgressHUDModeIndeterminate:MBProgressHUDModeCustomView;
    HUDInView.cornerRadius = 10;
    HUDInView.labelFont =  Font_Regular(13);
    HUDInView.minSize = (CGSize){100,100};
    
    if (!isVideo)   {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.frame = CGRectMake(0, 0,40,40);
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        NSMutableArray *imageList = [[NSMutableArray alloc] initWithCapacity:24];
        for (NSInteger i = 1; i <= 11; i++) {
            [imageList addObject:[UIImage imageNamed:[NSString stringWithFormat:@"dropdown_anim__000%ld",(long)i]]];
        }
        [imageView setAnimationImages:imageList];
        [imageView setAnimationDuration:.5];
        [imageView startAnimating];
        HUDInView.customView = imageView;
    }
    return HUDInView;
}

+(void)hideHUDInView:(UIView *)view{
    if (view==nil) {
        return;
    }
    if ([NSThread isMainThread]) {
        [self _hideHUDInView:view];
    }else{
        dispatch_async(dispatch_get_main_queue(), ^{
            [self _hideHUDInView:view];
        });
    }
}

+(void)_hideHUDInView:(UIView *)view{
    if (view==nil) {
        return;
    }
    // 允许TableView滚动
    if ([view respondsToSelector:@selector(setScrollEnabled:)]) {
        [(UIScrollView*)view setScrollEnabled:YES];
    }
    
    [MBProgressHUD hideAllHUDsForView:kMainWindow animated:YES];
    
    UIView* masterView=[kMainWindow viewWithTag:1001];
    if (masterView) {
        [masterView removeFromSuperview];
    }
}


/** 环形进度条+文字 **/
+(void)showCircularHUDProgress{
    
    [HDHud hideHUD];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    hud.center = kMainWindow.center;
    hud.removeFromSuperViewOnHide = YES;
//    hud.square = YES;
    hud.color = [Color(@"181818") colorWithAlphaComponent:0.9];
    hud.cornerRadius = 10;
    hud.labelFont =  Font_Regular(13);
    hud.minSize = (CGSize){100,100};
    hud.labelColor = [UIColor whiteColor];
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    
    hud.labelText = @"下载中...";
}

/** 更新progress进度 **/
+(MBProgressHUD *)getHUDProgress{
    return [MBProgressHUD HUDForView:[UIApplication sharedApplication].keyWindow];
}
//隐藏HUD
+(void)hideHUD{
    [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].keyWindow animated:YES];
}



#pragma mark - 废弃
+(MBProgressHUD *)showNetWorkErrorInView:(UIView *)view
{
    if ([NSThread isMainThread]) {
        return [self _showNetWorkErrorInView:view];
    }else{
        dispatch_async(dispatch_get_main_queue(), ^{
            [self _showNetWorkErrorInView:view];
        });
    }
    return nil;
}

+(MBProgressHUD *)_showNetWorkErrorInView:(UIView *)view{
    if (view==nil) {
        return nil;
    }
    UIView* masterView=[kMainWindow viewWithTag:1001];
    if (masterView) {
        [masterView removeFromSuperview];
    }
    // 允许TableView滚动
    if ([view respondsToSelector:@selector(setScrollEnabled:)]) {
        [(UIScrollView*)view setScrollEnabled:YES];
    }
    [MBProgressHUD hideAllHUDsForView:kMainWindow animated:NO];
    MBProgressHUD *HUDInView = [MBProgressHUD showHUDAddedTo:kMainWindow animated:NO];
    HUDInView.removeFromSuperViewOnHide = YES;
    HUDInView.mode = MBProgressHUDModeText;
    HUDInView.detailsLabelText = KM_NET_ERROR;
    [HUDInView hide:YES afterDelay:0.5];
    return HUDInView;
}

+(MBProgressHUD *)showMessageInView:(UIView *)view title:(NSString *)title
{
    if ([NSThread isMainThread]) {
        return [self _showMessageInView:view title:title];
    }else{
        dispatch_async(dispatch_get_main_queue(), ^{
            [self _showMessageInView:view title:title];
        });
    }
    return nil;
}

+(MBProgressHUD *)_showMessageInView:(UIView *)view title:(NSString *)title{
    if (view==nil) {
        return nil;
    }
    if (!ValidStr(title)) {
        title = KM_NET_ERROR;
    }
    UIView* masterView=[kMainWindow viewWithTag:1001];
    if (masterView) {
        [masterView removeFromSuperview];
    }
    // 允许TableView滚动
    if ([view respondsToSelector:@selector(setScrollEnabled:)]) {
        [(UIScrollView*)view setScrollEnabled:YES];
    }
    [MBProgressHUD hideAllHUDsForView:kMainWindow animated:NO];
    MBProgressHUD *HUDInView = [MBProgressHUD showHUDAddedTo:kMainWindow animated:NO];
    HUDInView.removeFromSuperViewOnHide = YES;
    HUDInView.mode = MBProgressHUDModeText;
    HUDInView.detailsLabelText = title;
    [HUDInView hide:YES afterDelay:1];
    return HUDInView;
}
+(MBProgressHUD *)_showHUDInView:(UIView *)view{
    UIView* masterView = [kMainWindow viewWithTag:1001];
    if (masterView==nil) {
        UIView* masterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight)];
        masterView.tag = 1001;
        masterView.backgroundColor=RGBACOLOR(1, 1, 1, .3);
        [kMainWindow addSubview:masterView];
    }
    
    // 禁止TableView滚动
    if ([view respondsToSelector:@selector(setScrollEnabled:)]) {
        [(UIScrollView*)view setScrollEnabled:NO];
    }
    MBProgressHUD *HUDInView = [MBProgressHUD showHUDAddedTo:kMainWindow animated:YES];
    HUDInView.center = kMainWindow.center;
    
    HUDInView.removeFromSuperViewOnHide = YES;
    HUDInView.labelText = @"";
    //    HUDInView.square = YES;
    HUDInView.color = [Color(@"181818") colorWithAlphaComponent:0];
    HUDInView.mode = MBProgressHUDModeIndeterminate;
    HUDInView.cornerRadius = 10;
    HUDInView.labelFont =  Font_Regular(13);
    HUDInView.minSize = (CGSize){100,100};
    
    return HUDInView;
}

@end

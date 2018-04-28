//
//  SLNetStatusManager.m
//  ShowLive
//
//  Created by WorkNew on 2018/4/23.
//  Copyright © 2018年 VNing. All rights reserved.
//

#import "SLNetStatusManager.h"
#import <AFNetworkReachabilityManager.h>
#import "PageManager.h"
#import "SLPlayerManager.h"
static SLNetStatusManager *instance = nil;
@interface SLNetStatusManager ()




@end

@implementation SLNetStatusManager


+(instancetype)shareInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        instance = [[SLNetStatusManager alloc]init];
    });
    
    return instance;
}

-(void)getNetWorkStausAndIsContinue:(void (^)(BOOL isContinue))isContinue
{
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case -1:
                NSLog(@"未知网络");
                break;
            case 0:
                NSLog(@"网络不可达");
                break;
            case 1:
            {
      
    
                
                NSString * message = @"当前为非WFINI环境,\n是否使用流量观看视频?";
                NSString * title = @"提示";
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *pause = [UIAlertAction actionWithTitle:@"暂停播放" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
              
                    if (isContinue) {
                        isContinue(NO);
                    }
                
                }];
                UIAlertAction *goon = [UIAlertAction actionWithTitle:@"继续观看" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    if (isContinue) {
                        isContinue(YES);
                    }
               
                }];
                [alertController addAction:pause];
                [alertController addAction:goon];
                
                [[PageManager  getCurrentViewController] presentViewController:alertController animated:YES completion:^{}];
            }
                break;
            case 2:
            {
             
            }
                break;
            default:
                break;
        }
        if (status == AFNetworkReachabilityStatusReachableViaWWAN || status == AFNetworkReachabilityStatusReachableViaWiFi) {
            NSLog(@"有网");
        }else{
            NSLog(@"没网");
        }
    }];
}



@end

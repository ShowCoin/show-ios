//
//  SLAppMediaPerssion.m
//  ShowLive
//
//  Created by show gx on 2018/4/12.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "SLAppMediaPerssion.h"
#import <AVFoundation/AVFoundation.h>
@implementation SLAppMediaPerssion

//应用程序需要事先申请音视频使用权限
+ (void)requestMediaCapturerAccessWithCompletionHandler:(void (^)(SLDeviceErrorStatus status))handler{
    
    AVAuthorizationStatus videoAuthorStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    AVAuthorizationStatus audioAuthorStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeAudio];
    
    if (AVAuthorizationStatusAuthorized == videoAuthorStatus && AVAuthorizationStatusAuthorized == audioAuthorStatus) {
        handler(AVDeviceNOErrorStatus);
        
    }else{
        
        //相机没开，麦克风开
        if ((AVAuthorizationStatusRestricted == videoAuthorStatus || AVAuthorizationStatusDenied == videoAuthorStatus)&&(AVAuthorizationStatusAuthorized == audioAuthorStatus)) {
            
            handler(VedioDeviceErrorStatus);
            
            return;
        }
        
        //麦克风没开，相机开
        else if ((AVAuthorizationStatusRestricted == audioAuthorStatus || AVAuthorizationStatusDenied == audioAuthorStatus)&&(AVAuthorizationStatusAuthorized == videoAuthorStatus)) {
            
            handler(AudioDeviceErrorStatus);
            
            return;
        }
        
        //相机麦克风都没开
        else if ((AVAuthorizationStatusRestricted == audioAuthorStatus || AVAuthorizationStatusDenied == audioAuthorStatus)&&(AVAuthorizationStatusRestricted == videoAuthorStatus || AVAuthorizationStatusDenied == videoAuthorStatus)) {
            
            handler(AVDeviceErrorStatus);
            
            return;
        }else
        {
            //请求相机
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                
                if (granted) {
                    //请求麦克风
                    [[AVAudioSession sharedInstance] requestRecordPermission:^(BOOL granted) {
                        if (granted) {
                            
                            dispatch_async(dispatch_get_main_queue(), ^{
                                
                                handler(AVDeviceNOErrorStatus);
                                
                            });
                            
                        }else{
                            
                            dispatch_async(dispatch_get_main_queue(), ^{
                                
                                handler(AudioDeviceErrorStatus);
                            });
                            
                        }
                    }];
                    
                }else{
                    
                    [[AVAudioSession sharedInstance] requestRecordPermission:^(BOOL granted) {
                        if (granted) {
                            dispatch_async(dispatch_get_main_queue(), ^{
                                
                                handler(VedioDeviceErrorStatus );
                            });
                        }else{
                            dispatch_async(dispatch_get_main_queue(), ^{
                                handler(AVDeviceErrorStatus);
                            });
                        }
                    }];
                }
            }];
      
            
        }
    }
    
 
   
}

@end


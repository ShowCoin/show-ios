//
//  SLLiveViewController+Request.h
//  ShowLive
//
//  Created by WorkNew on 2018/4/14.
//  Copyright © 2018年 VNing. All rights reserved.
//

#import "SLLiveViewController.h"

@interface SLLiveViewController (Request)

-(void)liveOpen:(NSString*)streamName
        success:(void (^)(id obj))success
          faile:(void (^)(NSError*))faile;

@end

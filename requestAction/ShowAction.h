//
//  ShowAction.h
//  ShowLive
//
//  Created by iori_chou on 2018/3/21.
//  Copyright © 2018年 vning. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ShowRequest.h"
#import "BaseModel.h"
#import "ShowRequestData.h"

typedef void(^ShowActionFinishedBlock)(id result);
typedef void(^ShowActionFailedBlock)(NSError *error);
typedef void(^ShowActionCancelledBlock)(void);

@interface ShowAction : NSObject

@end

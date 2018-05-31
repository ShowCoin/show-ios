//
//  SLLMModel.m
//  test
//
//  Created by chenyh on 2018/5/31.
//  Copyright © 2018年 chuxia. All rights reserved.
//

#import "SLLMModel.h"

@implementation SLLMModel


+ (instancetype)initWithTitle:(NSString *)t image:(NSString *)i {
    SLLMModel *model = [[self alloc] init];
    model.title = t;
    model.image = i;
    return model;
}

+ (instancetype)sl_create:(SLLMType)type {
    SLLMModel *model = [[self alloc] init];
    model.type = type;
    model.select = NO;
    switch (type) {
        case SLLMTypeMessage:
            model.title = @"私信";
            model.image = @"live_more_message";
            break;
            
        case SLLMTypeFront:
            model.title = @"后置";
            model.image = @"live_more_carema";
            model.selectTitle = @"前置";
            model.selectImage = @"live_more_carema";
            break;
            
        case SLLMTypeMirror:
            model.title = @"镜像";
            model.image = @"live_more_mirror";
            break;
            
        case SLLMTypeMute:
            model.title = @"开静音";
            model.image = @"live_more_mute";
            model.selectTitle = @"关静音";
            model.selectImage = @"live_more_unmute";
            break;
            
        case SLLMTypeShoot:
            model.title = @"截屏";
            model.image = @"live_more_shoot";
            break;
            
        default:
            break;
    }
    return model;
}



@end

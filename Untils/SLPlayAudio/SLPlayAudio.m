//
//  SLVoicePlay.m
//  test
//
//  Created by chenyh on 2018/6/27.
//  Copyright © 2018年 chuxia. All rights reserved.
//

#import "SLPlayAudio.h"
#import <AVFoundation/AVFoundation.h>

@interface SLPlayAudio ()

@property (nonatomic, strong) AVPlayer *player;

@end

@implementation SLPlayAudio

+ (instancetype)shared {
    static id _instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}

@end

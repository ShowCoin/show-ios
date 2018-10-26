//
//  SLVoicePlay.h
//  test
//
//  Created by chenyh on 2018/6/27.
//  Copyright © 2018年 chuxia. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSUInteger, SLAudioOption) {
    SLAudioOptioCoinReceive,
};

@interface SLPlayAudio : NSObject

+ (instancetype)shared;

- (void)play:(SLAudioOption)op;

@end

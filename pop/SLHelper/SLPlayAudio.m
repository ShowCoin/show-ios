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


/**
 SLAudioOption

 @param op op
 */
- (void)play:(SLAudioOption)op {
    NSURL *url = [NSBundle.mainBundle URLForResource:@"coins_received" withExtension:@"wav"];
    AVPlayerItem *item = [[AVPlayerItem alloc] initWithURL:url];
    self.player = [AVPlayer playerWithPlayerItem:item];
    [self.player play];
}

- (void)play {
    NSURL *url = [NSBundle.mainBundle URLForResource:@"coins_received" withExtension:@"wav"];
    NSError *error;
    AVAudioPlayer *player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
    if (error) {
        NSLog(@"error >> %@", error.localizedDescription);
    }
    [player play];
}

@end

//
//  SLChatRecordStateHud.m
//  ShowLive
//
//  Created by Mac on 2018/4/11.
//  Copyright © 2018年 VNing. All rights reserved.
//

#import "SLChatRecordStateHud.h"

@interface SLChatRecordStateHud()

@property (assign, nonatomic) CGFloat angle;
@property (strong, nonatomic) NSTimer *timer;
@property (assign, nonatomic) SLChatRecordState recordState;
@property (assign, nonatomic) NSTimeInterval seconds;

@property (nonatomic, strong, readonly) UIWindow *overlayWindow;

@property (nonatomic, strong) UIView *contentView;  //发语音时的提示view
@property (nonatomic, strong) UIImageView *voiceIcon;  //发语音时的语音小动画
@property (nonatomic, strong) UIImageView *noticeIcon;  //其它状态时的提示icon
@property (nonatomic, strong) UILabel *timeDownLabel;  //倒计时的label
@property (nonatomic, strong) UILabel *noticeLabel;  //发语音时的提示语显示label

@end

@implementation SLChatRecordStateHud

@synthesize overlayWindow = _overlayWindow;

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (void)setup{
    
    [self addSubview:self.contentView];
    [self.contentView addSubview:self.voiceIcon];
    [self.contentView addSubview:self.noticeIcon];
    [self.contentView addSubview:self.timeDownLabel];
    [self.contentView addSubview:self.noticeLabel];
    
    self.noticeIcon.hidden = YES;
    self.timeDownLabel.hidden = YES;
}

#pragma mark - Private Methods

- (void)show{
    
    self.angle = 0.0f;
    self.seconds = 0;
    self.voiceIcon.hidden = NO;
    self.timeDownLabel.hidden = YES;
    self.noticeIcon.hidden = YES;
    [self startTimer];
    dispatch_async(dispatch_get_main_queue(), ^{
        if(!self.superview)
            [self.overlayWindow addSubview:self];
        
        [UIView animateWithDuration:.5 animations:^{
            self.alpha = 1;
        } completion:nil];
        [self setNeedsDisplay];
    });
}

- (void)timerAction{
    self.angle -= 3;
    self.seconds += 0.1 ;
    
    
    if (self.seconds >= (kRecord_Time_Max - 5)) {
        [self stopVoiceAnimating];
        self.noticeIcon.hidden = YES;
        self.voiceIcon.hidden = YES;
        self.timeDownLabel.hidden = NO;
        self.timeDownLabel.text = [NSString stringWithFormat:@"%.0f", floor(kRecord_Time_Max + 1 - self.seconds)];
        if (self.seconds >= kRecord_Time_Max){
            [[NSNotificationCenter defaultCenter] postNotificationName:kNotify_Record_Time_Limit_Out object:nil];
        }
    }
    
}

- (void)dismiss{
    self.recordState = SLChatRecordStateNone;
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [self stopTimer];
        [self.voiceIcon stopAnimating];
        
        CGFloat timeLonger = 0.1;
        //        if (self.recordState == SLChatRecordStateShort) {
        //            timeLonger = 1.5;
        //        }else{
        //            timeLonger = 1.f;
        //        }
        [UIView animateWithDuration:timeLonger
                              delay:0
                            options:UIViewAnimationCurveEaseIn | UIViewAnimationOptionAllowUserInteraction
                         animations:^{
                             self.alpha = 0;
                         }
                         completion:^(BOOL finished){
                             if(self.alpha == 0) {
                                 [self removeFromSuperview];
                                 
                                 NSMutableArray *windows = [[NSMutableArray alloc] initWithArray:[UIApplication sharedApplication].windows];
                                 [windows removeObject:self.overlayWindow];
                                 
                                 [windows enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(UIWindow *window, NSUInteger idx, BOOL *stop) {
                                     if([window isKindOfClass:[UIWindow class]] && window.windowLevel == UIWindowLevelNormal) {
                                         [window makeKeyWindow];
                                         *stop = YES;
                                     }
                                 }];
                             }
                         }];
    });
}

-(void)startVoiceAnimating
{
    if (!self.voiceIcon.isAnimating) {
        self.noticeIcon.hidden = YES;
        self.voiceIcon.hidden = NO;
        [self.voiceIcon startAnimating];
    }
}

-(void)stopVoiceAnimating
{
    if (!self.voiceIcon.hidden) {
        self.noticeIcon.hidden = NO;
        self.voiceIcon.hidden = YES;
        [self.voiceIcon stopAnimating];
    }
}

#pragma mark - Setters
-(void)setNoticeInfo:(NSString *)str
{
    self.noticeLabel.text = str;
}

- (void)setRecordState:(SLChatRecordState)recordState{
    if (_recordState == recordState) {
        return;
    }
    
    _recordState = recordState;
    switch (recordState) {
        case SLChatRecordStateRecording:
        {
            if (self.seconds <= kRecord_Time_Max - 5) {
                [self startVoiceAnimating];
            }
            self.noticeLabel.text = @"手指上滑，取消发送";
        }
            break;
        case SLChatRecordStateUpCancel:
        {
            if (self.seconds <= kRecord_Time_Max - 5) {
                [self stopVoiceAnimating];
                self.noticeIcon.image = [UIImage imageNamed:@"quxiaofasong"];
            }
            self.noticeLabel.text = @"松开手指，取消发送";
        }
            break;
        case SLChatRecordStateSuccess:
        {
            //成功直接隐藏就可以，目前没有专门提示
            //            [self stopVoiceAnimating];
            //            self.noticeLabel.text = @"录音成功";
        }
            break;
        case SLChatRecordStateShort:
        {
            self.noticeIcon.image = [UIImage imageNamed:@"jinggao"];
            self.noticeLabel.text = @"说话时间太短";
            [self stopVoiceAnimating];
        }
            break;
        case SLChatRecordStateError:
        {
            self.noticeIcon.image = [UIImage imageNamed:@"jinggao"];
            self.noticeLabel.text = @"录音失败，请重试";
            [self stopVoiceAnimating];
        }
            break;
            
        default:
            break;
    }
}


#pragma mark - Getters

- (NSTimer *)timer{
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:0.1
                                                  target:self
                                                selector:@selector(timerAction)
                                                userInfo:nil
                                                 repeats:YES];
    }
    return _timer;
}

-(void)startTimer
{
    [self timer];
}

-(void)stopTimer
{
    [self.timer invalidate];
    self.timer = nil;
}

-(UIView *)contentView
{
    if (!_contentView) {
        _contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 150, 150)];
        _contentView.layer.masksToBounds = YES;
        _contentView.layer.cornerRadius = 10;
        _contentView.backgroundColor = HexRGBAlpha(0x333333, 1);
        _contentView.alpha = 0.8;
        _contentView.center =  CGPointMake(kMainScreenWidth*0.5, kMainScreenHeight*0.5);
    }
    return _contentView;
}

-(UIImageView *)voiceIcon
{
    if (!_voiceIcon) {
        _voiceIcon = [[UIImageView alloc] initWithFrame:CGRectMake((150 - 66)*0.5, 26, 66, 66)];
        _voiceIcon.animationDuration = 1.5;//设置动画时间
        [self.voiceIcon setAnimationImages:self.animationImages];
        self.voiceIcon.image = [UIImage imageNamed:@"yuyin3"];
    }
    return _voiceIcon;
}

-(UIImageView *)noticeIcon
{
    if (!_noticeIcon) {
        _noticeIcon = [[UIImageView alloc] initWithFrame:CGRectMake((150 - 66)*0.5, 26, 66, 66)];
        _noticeIcon.image = [UIImage imageNamed:@"jinggao"];
    }
    return _noticeIcon;
}

-(UILabel *)timeDownLabel
{
    if (!_timeDownLabel) {
        _timeDownLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 26, 150, 66)];
        _timeDownLabel.font = [UIFont systemFontOfSize:60];
        _timeDownLabel.textColor = RGBAllColor(0xFFFFFF);
        _timeDownLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _timeDownLabel;
}

-(NSArray<UIImage *> *)animationImages
{
    return @[[UIImage imageNamed:@"yuyin1"],
             [UIImage imageNamed:@"yuyin2"],
             [UIImage imageNamed:@"yuyin3"]];
}

-(UILabel *)noticeLabel
{
    if (!_noticeLabel) {
        _noticeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 100, 150, 20)];
        _noticeLabel.font = [UIFont systemFontOfSize:14];
        _noticeLabel.text = @"手指上滑，取消发送";
        _noticeLabel.textColor = RGBAllColor(0xFFFFFF);
        _noticeLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _noticeLabel;
}

- (UIWindow *)overlayWindow {
    if(!_overlayWindow) {
        
        _overlayWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _overlayWindow.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _overlayWindow.userInteractionEnabled = NO;
        [_overlayWindow makeKeyAndVisible];
        
    }
    return _overlayWindow;
}



#pragma mark - Class Methods


+ (SLChatRecordStateHud *)sharedView {
    static dispatch_once_t once;
    static SLChatRecordStateHud *sharedView;
    dispatch_once(&once, ^ {
        sharedView = [[SLChatRecordStateHud alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        sharedView.backgroundColor = [UIColor clearColor];
        
    });
    return sharedView;
}

+ (void)show {
    [[SLChatRecordStateHud sharedView] show];
    [[SLChatRecordStateHud sharedView] setRecordState:SLChatRecordStateRecording];
}

+ (void)dismissWithRecordState:(SLChatRecordState)recordState{
    [[SLChatRecordStateHud sharedView] setRecordState:recordState];
    [[SLChatRecordStateHud sharedView] dismiss];
}

+ (void)changeState:(SLChatRecordState)newState
{
    [[SLChatRecordStateHud sharedView] setRecordState:newState];
}

+ (NSTimeInterval)seconds{
    return [[SLChatRecordStateHud sharedView] seconds];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

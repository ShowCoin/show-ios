//
//  SLTimerLabel.m
//  ShowLive
//
//  Created by iori_chou on 2018/5/30.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "SLTimerLabel.h"
#define kDefaultTimeFormat  @"HH:mm:ss"
#define kHourFormatReplace  @"!!!*"
#define kDefaultFireIntervalNormal  0.1
#define kDefaultFireIntervalHighUse  0.02
#define kDefaultTimerType SLTimerLabelTypeStopWatch

@interface SLTimerLabel(){
    
    NSTimeInterval timeUserValue;
    NSDate *startCountDate;
    NSDate *pausedTime;
    NSDate *date1970;
    NSDate *timeToCountOff;
}

@property (strong) NSTimer *timer;
@property (nonatomic,strong) NSDateFormatter *dateFormatter;

- (void)setup;
- (void)updateLabel;

@end

@implementation SLTimerLabel
@synthesize timeFormat = _timeFormat;

- (id)initWithTimerType:(SLTimerLabelType)theType{
    return [self initWithLabel:nil andTimerType:theType];
}

- (id)initWithLabel:(UILabel *)theLabel andTimerType:(SLTimerLabelType)theType
{
    self = [super init];
    
    if(self){
        self.timeLabel = theLabel;
        self.timerType = theType;
        [self setup];
    }
    return self;
}

- (id)initWithLabel:(UILabel*)theLabel{
    return [self initWithLabel:theLabel andTimerType:kDefaultTimerType];
}

- (id)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}

#pragma mark - Getter and Setter Method

- (void)setStopWatchTime:(NSTimeInterval)time{
    
    timeUserValue = (time < 0) ? 0 : time;
    if(timeUserValue > 0){
        startCountDate = [[NSDate date] dateByAddingTimeInterval:-timeUserValue];
        pausedTime = [NSDate date];
        [self updateLabel];
    }
}

- (void)setCountDownTime:(NSTimeInterval)time{
    
    timeUserValue = (time < 0)? 0 : time;
    timeToCountOff = [date1970 dateByAddingTimeInterval:timeUserValue];
    [self updateLabel];
}

-(void)setCountDownToDate:(NSDate*)date{
    NSTimeInterval timeLeft = (int)[date timeIntervalSinceDate:[NSDate date]];
    
    if (timeLeft > 0) {
        timeUserValue = timeLeft;
        timeToCountOff = [date1970 dateByAddingTimeInterval:timeLeft];
    }else{
        timeUserValue = 0;
        timeToCountOff = [date1970 dateByAddingTimeInterval:0];
    }
    [self updateLabel];
    
}

- (void)setTimeFormat:(NSString *)timeFormat{
    
    if ([timeFormat length] != 0) {
        _timeFormat = timeFormat;
        self.dateFormatter.dateFormat = timeFormat;
    }
    [self updateLabel];
}

- (NSString*)timeFormat
{
    if ([_timeFormat length] == 0 || _timeFormat == nil) {
        _timeFormat = kDefaultTimeFormat;
    }
    
    return _timeFormat;
}

- (NSDateFormatter*)dateFormatter{
    
    if (_dateFormatter == nil) {
        _dateFormatter = [[NSDateFormatter alloc] init];
        _dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_GB"];
        [_dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
        _dateFormatter.dateFormat = self.timeFormat;
    }
    return _dateFormatter;
}

- (UILabel*)timeLabel
{
    if (_timeLabel == nil) {
        _timeLabel = self;
    }
    return _timeLabel;
}


-(void)addTimeCountedByTime:(NSTimeInterval)timeToAdd
{
    if (_timerType == SLTimerLabelTypeTimer) {
        [self setCountDownTime:timeToAdd + timeUserValue];
    }else if (_timerType == SLTimerLabelTypeStopWatch) {
        NSDate *newStartDate = [startCountDate dateByAddingTimeInterval:-timeToAdd];
        if([[NSDate date] timeIntervalSinceDate:newStartDate] <= 0) {
            //prevent less than 0
            startCountDate = [NSDate date];
        }else{
            startCountDate = newStartDate;
        }
    }
    [self updateLabel];
}


- (NSTimeInterval)getTimeCounted
{
    if(!startCountDate) return 0;
    NSTimeInterval countedTime = [[NSDate date] timeIntervalSinceDate:startCountDate];
    
    if(pausedTime != nil){
        NSTimeInterval pauseCountedTime = [[NSDate date] timeIntervalSinceDate:pausedTime];
        countedTime -= pauseCountedTime;
    }
    return countedTime;
}

- (NSTimeInterval)getTimeRemaining {
    
    if (_timerType == SLTimerLabelTypeTimer) {
        return timeUserValue - [self getTimeCounted];
    }
    
    return 0;
}

- (void)setShouldCountBeyondHHLimit:(BOOL)shouldCountBeyondHHLimit {
    _shouldCountBeyondHHLimit = shouldCountBeyondHHLimit;
    [self updateLabel];
}

#pragma mark - Timer Control Method


-(void)start{
    
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
    
    if ([self.timeFormat rangeOfString:@"SS"].location != NSNotFound) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:kDefaultFireIntervalHighUse target:self selector:@selector(updateLabel) userInfo:nil repeats:YES];
    }else{
        _timer = [NSTimer scheduledTimerWithTimeInterval:kDefaultFireIntervalNormal target:self selector:@selector(updateLabel) userInfo:nil repeats:YES];
    }
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    
    if(startCountDate == nil){
        startCountDate = [NSDate date];
        
        if (self.timerType == SLTimerLabelTypeStopWatch && timeUserValue > 0) {
            startCountDate = [startCountDate dateByAddingTimeInterval:(timeUserValue<0)?0:-timeUserValue];
        }
    }
    if(pausedTime != nil){
        NSTimeInterval countedTime = [pausedTime timeIntervalSinceDate:startCountDate];
        startCountDate = [[NSDate date] dateByAddingTimeInterval:-countedTime];
        pausedTime = nil;
    }
    
    _counting = YES;
    [_timer fire];
}

#if NS_BLOCKS_AVAILABLE
-(void)startWithEndingBlock:(void(^)(NSTimeInterval))end{
    [self start];
    self.endedBlock = end;
}
#endif

-(void)pause{
    if(_counting){
        [_timer invalidate];
        _timer = nil;
        _counting = NO;
        pausedTime = [NSDate date];
    }
}

-(void)reset{
    pausedTime = nil;
    timeUserValue = (self.timerType == SLTimerLabelTypeStopWatch)? 0 : timeUserValue;
    startCountDate = (self.counting)? [NSDate date] : nil;
    [self updateLabel];
}

- (void)stop
{
    [_timer invalidate];
    _timer = nil;
}


#pragma mark - Private method

-(void)setup{
    date1970 = [NSDate dateWithTimeIntervalSince1970:0];
    [self updateLabel];
}


-(void)updateLabel{
    
    NSTimeInterval timeDiff = [[NSDate date] timeIntervalSinceDate:startCountDate];
    NSDate *timeToShow = [NSDate date];
    
    /***SLTimerLabelTypeStopWatch Logic***/
    
    if(_timerType == SLTimerLabelTypeStopWatch){
        
        if (_counting) {
            timeToShow = [date1970 dateByAddingTimeInterval:timeDiff];
        }else{
            timeToShow = [date1970 dateByAddingTimeInterval:(!startCountDate)?0:timeDiff];
        }
        
        if([_delegate respondsToSelector:@selector(timerLabel:countingTo:timertype:)]){
            [_delegate timerLabel:self countingTo:timeDiff timertype:_timerType];
        }
        
    }else{
        
        /***SLTimerLabelTypeTimer Logic***/
        
        if (_counting) {
            
            if([_delegate respondsToSelector:@selector(timerLabel:countingTo:timertype:)]){
                NSTimeInterval timeLeft = timeUserValue - timeDiff;
                [_delegate timerLabel:self countingTo:timeLeft timertype:_timerType];
            }
            
            if(timeDiff >= timeUserValue){
                [self pause];
                timeToShow = [date1970 dateByAddingTimeInterval:0];
                pausedTime = nil;
                startCountDate = nil;
                
                if([_delegate respondsToSelector:@selector(timerLabel:finshedCountDownTimerWithTime:)]){
                    [_delegate timerLabel:self finshedCountDownTimerWithTime:timeUserValue];
                }
                
#if NS_BLOCKS_AVAILABLE
                if(_endedBlock != nil){
                    _endedBlock(timeUserValue);
                }
#endif
                if(_resetTimerAfterFinish){
                    [self reset];
                    return;
                }
                
            }else{
                
                timeToShow = [timeToCountOff dateByAddingTimeInterval:(timeDiff*-1)]; //added 0.999 to make it actually counting the whole first second
            }
        }else{
            timeToShow = timeToCountOff;
        }
    }
    
    
    //setting text value
    if ([_delegate respondsToSelector:@selector(timerLabel:customTextToDisplayAtTime:)]) {
        NSTimeInterval atTime = (_timerType == SLTimerLabelTypeStopWatch) ? timeDiff : (timeUserValue - timeDiff);
        NSString *customtext = [_delegate timerLabel:self customTextToDisplayAtTime:atTime];
        if ([customtext length]) {
            self.timeLabel.text = customtext;
        }else{
            self.timeLabel.text = [self.dateFormatter stringFromDate:timeToShow];
        }
    }else{
        
        if(_shouldCountBeyondHHLimit) {
            //0.4.7 added---start//
            NSString *originalTimeFormat = _timeFormat;
            NSString *beyondFormat = [_timeFormat stringByReplacingOccurrencesOfString:@"HH" withString:kHourFormatReplace];
            beyondFormat = [beyondFormat stringByReplacingOccurrencesOfString:@"H" withString:kHourFormatReplace];
            self.dateFormatter.dateFormat = beyondFormat;
            
            int hours = [self getTimeCounted] / 3600;
            NSString *formmattedDate = [self.dateFormatter stringFromDate:timeToShow];
            NSString *beyondedDate = [formmattedDate stringByReplacingOccurrencesOfString:kHourFormatReplace withString:[NSString stringWithFormat:@"%02d",hours]];
            
            self.timeLabel.text = beyondedDate;
            self.dateFormatter.dateFormat = originalTimeFormat;
            //0.4.7 added---endb//
        }else{
            self.timeLabel.text = [self.dateFormatter stringFromDate:timeToShow];
        }
    }
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

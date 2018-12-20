//
//  SLTimerLabel.h
//  ShowLive
//
//  Created by iori_chou on 2018/5/30.
//  Copyright © 2018年 vning. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum{
    SLTimerLabelTypeStopWatch,
    SLTimerLabelTypeTimer
}SLTimerLabelType;

/**********************************************
 Delegate Methods
 @optional
 
 - timerLabel:finshedCountDownTimerWithTimeWithTime:
 ** SLTimerLabel Delegate method for finish of countdown timer
 
 - timerLabel:countingTo:timertype:
 ** SLTimerLabel Delegate method for monitering the current counting progress
 
 - timerlabel:customTextToDisplayAtTime:
 ** SLTimerLabel Delegate method for overriding the text displaying at the time, implement this for your very custom display formmat
 **********************************************/

@class SLTimerLabel;
@protocol SLTimerLabelDelegate <NSObject>
@optional
-(void)timerLabel:(SLTimerLabel*)timerLabel finshedCountDownTimerWithTime:(NSTimeInterval)countTime;
-(void)timerLabel:(SLTimerLabel*)timerLabel countingTo:(NSTimeInterval)time timertype:(SLTimerLabelType)timerType;
-(NSString*)timerLabel:(SLTimerLabel*)timerLabel customTextToDisplayAtTime:(NSTimeInterval)time;
@end
@interface SLTimerLabel : UILabel
/*Delegate for finish of countdown timer */
@property (nonatomic, weak) id<SLTimerLabelDelegate> delegate;

/*Time format wish to display in label*/
@property (nonatomic,copy) NSString *timeFormat;


@end

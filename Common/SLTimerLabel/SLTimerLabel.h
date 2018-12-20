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


@end

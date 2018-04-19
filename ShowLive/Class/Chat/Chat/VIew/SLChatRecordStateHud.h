//
//  SLChatRecordStateHud.h
//  ShowLive
//
//  Created by 周华 on 2018/4/11.
//  Copyright © 2018年 vning. All rights reserved.
//

#import <UIKit/UIKit.h>
static NSUInteger const kRecord_Time_Max = 60;    //录音时长最大值
static NSString *const kNotify_Record_Time_Limit_Out = @"kNotify_Record_Time_Limit_Out";    //录音时长超过60秒


/**
 *  状态指示器对应状态
 */
typedef NS_ENUM(NSUInteger, SLChatRecordState){
    SLChatRecordStateNone, //初始值
    SLChatRecordStateRecording, //正在录音
    SLChatRecordStateUpCancel, //松手取消录音
    SLChatRecordStateSuccess, //成功
    SLChatRecordStateError, //出错,失败
    SLChatRecordStateShort //时间太短失败
};

@interface SLChatRecordStateHud : UIView
/**
 *  显示录音指示器
 */
+ (void)show;

/**
 *  隐藏hud,带有录音状态
 *
 *  @param progressState 录音状态
 */
+ (void)dismissWithRecordState:(SLChatRecordState)recordState;

/**
 设置当前hud的提示状态
 
 @param newState 新状态类型
 */
+ (void)changeState:(SLChatRecordState)newState;

/**
 *  上次成功录音时长
 *
 *  @return
 */
+ (NSTimeInterval)seconds;
@end

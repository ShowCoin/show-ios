//
//  SIDayView.h
//  Edu
//
//  Created by chenyh on 2018/9/29.
//  Copyright © 2018年 chuxia. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, SIWeekType) {
    SIWeekTypeMon = 1, // Monday
    SIWeekTypeTue,     // Tuesday
    SIWeekTypeWed,     // Wednesday
    SIWeekTypeThu,     // Thursday
    SIWeekTypeFri,     // Friday
    SIWeekTypeSat,     // Saturday
    SIWeekTypeSun,     // Sunday
};

/// 0,1,2,待签到,待补签,已签到
typedef NS_ENUM(NSUInteger, SISignedOption) {
    SISignedOptionWait = 0,   // 待签
    SISignedOptionComplement, // 补签
    SISignedOptionAlready,    // 已签
};

@class SISignedModel;

@interface SIDayView : UIView

@property (nonatomic, copy) SLSimpleBlock signBlock;
@property (nonatomic, assign) SIWeekType type;
@property (nonatomic, strong) SISignedModel *info;

@end

@interface SITimeView : UIView

@property (nonatomic, assign, getter=isHighlighted) BOOL highlighted;
@property (nonatomic, strong) NSString *text;

@end

@interface SISignedModel : NSObject

@property (nonatomic, assign) BOOL isToday;
@property (nonatomic, strong) NSString *picUrl;
@property (nonatomic, strong) NSString *rewardItemName;
@property (nonatomic, assign) NSInteger signStatus;

@end

FOUNDATION_EXPORT SIWeekType SLFuncCurrentWeekDay(void);

NS_ASSUME_NONNULL_END

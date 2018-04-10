//
//  HLLeadProfile.h
//  QinChat
//
//  Created by liyingbin on 16/10/6.
//  Copyright © 2016年 zero. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 * 便捷访问单例
 */
#define LeadProfile [HLLeadProfile leadProfile]
#define LEADREPLYVIDEO @"replyvideo" //回复视频
#define LEADSENDVIDEO @"sendvideo" // 有发送列表
#define LEADSENDVIDEONO @"sendvideono" // 无发送列表
#define LEADSENDTALKBACK @"sendtalkback" // 对讲松开发送
#define LEADCANCELTALKBACK @"canceltalkback" // 对讲取消发送
#define LEADSLIDEUP @"slideup" // 上滑关闭
#define LEADSLIDEDOWN @"slidedown" // 下滑更多
#define LEADSLIDELEFT @"slideleft" // 左滑更多
#define LEADSHOWEFFECTSHOW @"effectshow" // 特效提示
#define LEADFILTERSHOW @"filtershow" // 滤镜提示
#define LEADSELECTSENDVIDEO @"selectsendvideo" // 选择人发送视频
#define LEADEFFECTS @"leadeffects" // 特效按钮
#define LEADFAIL @"leadfailtime" // 按住录制
#define LEADMOUTHGAME @"mouthgame" // 游戏是否张嘴吃掉
#define LEADGAMEGSEND @"gamesend" // 发给好友领红包
#define LEADGAMEANIMATION @"gameanimation" // 游戏入口动画是否执行
#define LEADMSGDETAIL @"leadmsgdetail" // 老用户消息详情页引导
#define LEADDETAILDETAIL @"leaddetaildetail" // 详情页引导
#define LEADXIONGMAO @"leadxiongmao" // 熊猫头像引导
#define LEAD4G @"lead4g" // 4g弹窗
#define LEADIF @"leadIF" // 新用户iF号
#define LEADMAGICPEN @"magicPen" // 魔法笔引导
#define LEADMAGICEFFECT @"magicEffect" // 魔法特效引导
@interface HLLeadProfile : NSObject
/**
 * 单例
 */
+ (instancetype)leadProfile;
-(BOOL)boolForKey:(NSString *)str;
-(void)setBool:(NSString *)str;
- (void)setNewUsrBool;
@end

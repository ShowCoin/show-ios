//
//  SLChatRoomMessageManager.m
//  ShowLive
//
//  Created by WorkNew on 2018/4/18.
//  Copyright © 2018年 VNing. All rights reserved.
//

#import "SLChatRoomMessageManager.h"
#import "SLReceivedGiftModel.h"
#import "SLMemberListModel.h"

static SLChatRoomMessageManager *instance = nil;
@interface SLChatRoomMessageManager ()

@end

@implementation SLChatRoomMessageManager


+(instancetype)shareInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        instance = [[SLChatRoomMessageManager alloc]init];
    });
    
    return instance;
}

//注册聊天室消息
-(void)addChatRoomMessageNotification
{
    [self removeChatRoomMessageNotification]; //避免收到其他消息
    
    //聊天室文本消息
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(chatRoomNotification:) name:KMRongCloudChatRoomNotification object:nil];
}

//移除聊天室消息
-(void)removeChatRoomMessageNotification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)chatRoomNotification:(NSNotification *)ntfi {
    if (!ntfi.object) return;

    SLMessageInfo *messageInfo = (SLMessageInfo*)ntfi.object;
    SLChatRoomMessageType type = messageInfo.type;

    NSDictionary * jsonDict = [self JsonToDict:messageInfo.messageContent];
    
    switch (type) {

           case SLChatRoomMessageTypePause: //直播暂停
        {
            [self livePause];
        }
            break;
            case SLChatRoomMessageTypeBeigin: //直播恢复 直播开始都走这个消息
        {
             [self liveRecovery];
        }
            break;
        case SLChatRoomMessageTypeClose: //直播关闭
        {
            [self liveFinish:jsonDict];
        }
            break;
        case  SLChatRoomMessageTypeUserlist: //更新成员列表
        {
            
            NSString * totalString = [NSString stringWithFormat:@"%@",[jsonDict valueForKey:@"total"]];
            [self handleUserlistMessage:jsonDict total:totalString];
            
        }
            break;
       
        case SLChatRoomMessageTypeGift: //礼物
        {
        
            [self handleGiftMessage:jsonDict];

        }
            break;
        case SLChatRoomMessageTypeDanMu: //弹幕
        {
            [self handleDanmu:jsonDict];
        }
            break;
            case SLChatRoomMessageTypeNoti:
        {
            
        }
            break;
        default:
            break;
    }
    
}

//json转dict
- (NSDictionary *)JsonToDict:(NSString *)jsonData {
    if (!jsonData) return nil;
    if ([jsonData isKindOfClass: [NSDictionary class]]) return (NSDictionary *)jsonData;
    
    __autoreleasing NSError *error;
    //json 转化
    NSDictionary *dataDict = [NSJSONSerialization JSONObjectWithData:[jsonData dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:&error];
    
    if (error) return nil;
    
    return dataDict;
}

-(void)handleNoti:(NSDictionary*)data
{
    NSString * content = [[data valueForKey:@"data"] valueForKey:@"content"];
    if(self.delegate&&[self.delegate respondsToSelector:@selector(notice:)])
    {
        [self.delegate notice:content];
    }
}

-(void)handleDanmu:(NSDictionary*)data
{
    NSDictionary * dict = [data valueForKey:@"data"];
    SLShoutModel * model = [[SLShoutModel alloc]init];
    model.nickname = [dict valueForKey:@"nickName"];
    model.avatar =  [dict valueForKey:@"profileImg"];
    model.text  =[dict valueForKey:@"content"];
    
    if (self.delegate&&[self.delegate respondsToSelector:@selector(showShout:)]) {
        [self.delegate showShout:model];
    }
    
}

-(void)handleGiftMessage:(NSDictionary*)data
{
    NSDictionary * gift = [data valueForKey:@"data"];
    NSLog(@"[gx] 礼物消息是%ld",[[gift valueForKey:@"count"] integerValue]);
    
    SLReceivedGiftModel * receivedGiftModel = [[SLReceivedGiftModel alloc]init];
    receivedGiftModel.goods_id = [gift valueForKey:@"giftId"];
    receivedGiftModel.goods_name = [gift valueForKey:@"giftName"];
    receivedGiftModel.goods_pic = [gift valueForKey:@"giftImg"];
    receivedGiftModel.head_photo = [gift valueForKey:@"fromUserImg"];
    receivedGiftModel.nickname  =[gift valueForKey:@"fromNickName"];
    receivedGiftModel.level   = [[gift valueForKey:@"fromUserLevel"] integerValue];
    receivedGiftModel.user_id  = [gift valueForKey:@"fromUid"];
    receivedGiftModel.num  = 1;
    receivedGiftModel.double_hit = [[gift valueForKey:@"count"] integerValue];
    receivedGiftModel.animating_type = [[gift valueForKey:@"giftType"] integerValue];
    receivedGiftModel.totlePrice =  [[gift valueForKey:@"receive"] integerValue];
    receivedGiftModel.giftUniTag       = [NSString stringWithFormat:@"%@%@",[AccountModel shared].uid,[gift valueForKey:@"giftId"]];
    if (self.delegate&&[self.delegate respondsToSelector:@selector(receiveGift:)]) {
        [self.delegate receiveGift:receivedGiftModel];
    }
    
}



//更新成员列表
-(void)handleUserlistMessage:(NSDictionary*)data total:(NSString*)totalString
{
    NSArray * dataArray = [data valueForKey:@"data"];
    NSArray * userArray = [SLMemberListModel mj_objectArrayWithKeyValuesArray:dataArray];
    if (self.delegate&&[self.delegate respondsToSelector:@selector(updateMemberList:total:)]) {
        [self.delegate updateMemberList:userArray total:totalString];
    }
    
}


//直播暂停
-(void)livePause
{
    if (self.delegate&&[self.delegate respondsToSelector:@selector(anchorOut)]) {
        [self.delegate anchorOut];
    }
}

//直播恢复
-(void)liveRecovery
{
    if (self.delegate&&[self.delegate respondsToSelector:@selector(anchorBack)]) {
        [self.delegate anchorBack];
    }
}

//直播结束
-(void)liveFinish:(NSDictionary*)data
{
    SLFinishModel * model = [SLFinishModel mj_objectWithKeyValues:data];
    if (self.delegate&&[self.delegate respondsToSelector:@selector(finishLive:)]) {
        [self.delegate finishLive:model];
    }
}

@end

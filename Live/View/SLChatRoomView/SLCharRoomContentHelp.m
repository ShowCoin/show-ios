//
//  SLCharRoomContentHelp.m
//  ShowLive
//
//  Created by zhangxinggong on 2018/4/10.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "SLCharRoomContentHelp.h"
#import "YYText.h"
#import "SLLevelMarkView.h"

static NSString * lastSendGiftUid;
typedef NS_ENUM(NSInteger,ImagePostionType) {
    ImagePostionType_left = 1,
    ImagePostionType_right = 2
};

@interface ChatRoomModel:NSObject

@property (strong,nonatomic) NSDictionary * user ;
@property (strong,nonatomic) UIImage * levelImage ;
@property (copy,nonatomic) NSString *speakName ;
@property (copy,nonatomic) NSString *imageName ;
@property (assign,nonatomic) CGSize imageSize ;
@property (copy,nonatomic) NSString *levelString;
@property (assign,nonatomic)ImagePostionType postionType;
@property (assign,nonatomic)BOOL showThisMessage;//如果是排行的消息，一个UID只显示一次成为第一土豪，下次不显示。
@end

@implementation ChatRoomModel

@end


typedef NS_ENUM(NSInteger,Chat_User_level){
    Chat_User_level_low = 1,
    Chat_User_level_heigh = 2
} ;

@interface SLCharRoomContentHelp()

@property (strong,nonatomic) ChatRoomModel * roomModel ;

@end;

@implementation SLCharRoomContentHelp

+(SLMessageInfo *)contentAttributedString:(SLMessageInfo *)content{
    

    NSMutableAttributedString *text = [[NSMutableAttributedString alloc]init];
    
    ChatRoomModel *roomModel = [SLCharRoomContentHelp attributedModelWithString:content];
    if(!roomModel.showThisMessage){
        return nil ;
    }
    if(!content.type){
    UIView *diamoundCountView = [self userLevelViewWithModel:roomModel];
    NSMutableAttributedString * attachment1 = [NSMutableAttributedString yy_attachmentStringWithContent:diamoundCountView contentMode:UIViewContentModeCenter attachmentSize:diamoundCountView.frame.size alignToFont:[UIFont systemFontOfSize:15.0f] alignment:YYTextVerticalAlignmentCenter];
    [text appendAttributedString:attachment1];
    }
    
//    // 嵌入 UIImage
//    UIImage *image = [UIImage imageNamed:@"tab_userCenter"];
//    NSMutableAttributedString *attachment = nil;
//    attachment = [NSMutableAttributedString yy_attachmentStringWithContent:image contentMode:UIViewContentModeCenter attachmentSize:CGSizeMake(15.0f, 15.0f) alignToFont:[UIFont systemFontOfSize:15.0f] alignment:YYTextVerticalAlignmentCenter];
//    [text appendAttributedString: attachment];
//
//
    NSMutableAttributedString *edageContent = [[NSMutableAttributedString alloc] initWithString:@" "];
    [text appendAttributedString:edageContent];
    NSString *string = [self creatstring:content];
    NSMutableAttributedString *textContent = [[NSMutableAttributedString alloc] initWithString:string?:@""];
    // 2. Set attributes to text, you can use almost all CoreText attributes.
    textContent.yy_font = [UIFont systemFontOfSize:15];
    textContent.yy_color = [self adapterColor:content];
    text.yy_lineSpacing = 2;
    [text appendAttributedString:textContent];
    
    
    content.attribute = text ;
    return content;
}

+ (NSString *)creatstring:(SLMessageInfo *)message{
    NSDictionary * user=nil;
    NSString * str=nil;
    
    if ([SLLive_IM_SEND_WangAn isEqualToString:message.messageExtra] == YES)
    {
        str=[NSString stringWithFormat:@"%@",message.messageContent];//[(+系统消息+)]
    }
    else if (message.type==SLChatRoomMessageTypeGift)
    {//[(++)]
        str=[NSString stringWithFormat:@"%@:我送了一个%@",[message.data valueForKey:@"fromNickName"],[message.data valueForKey:@"giftName"]];
    }
    else if (message.type==SLChatRoomMessageTypeLevelUp)
    {
        str=[NSString stringWithFormat:@"恭喜%@在本直播间升级为%@级",[message.data valueForKey:@"nickName"],[message.data valueForKey:@"fanLevel"]];//[(+房间消息+)]
    }
    else if (message.type== SLChatRoomMessageTypeDanMu)
    {
        str=[NSString stringWithFormat:@"%@:%@",[message.data valueForKey:@"nickName"],[message.data valueForKey:@"content"]];//[(+房间消息+)]
    }
    else if (message.type==SLChatRoomMessageTypeDianzan)
    {
        if ([[message.data valueForKey:@"isAdmin"] integerValue]==1)
            str=[NSString stringWithFormat:@" @%@点了喜欢",[message.data valueForKey:@"nickName"]];//[(+level_P+)] [(+红心+)] [(+level_%@+)][message.data valueForKey:@"fanLevel"], [(+level_%@+)]
        else
            str=[NSString stringWithFormat:@"@%@点了喜欢",[message.data valueForKey:@"nickName"]];
    }
    else if (message.type==SLChatRoomMessageTypeUserJoin)
    {
        str=[NSString stringWithFormat:@"欢迎%@进入直播间",[message.data valueForKey:@"nickName"]];//[(+房间消息+)]
    }else if (message.type==SLChatRoomMessageTypePause)
    {
        str=@"主播暂停了直播";//[(+房间消息+)]
    }else if (message.type==SLChatRoomMessageTypeBeigin)
    {
        str=@"主播开始了直播";//[(+房间消息+)]
    }else if (message.type==SLChatRoomMessageTypeNoti)
    {
        str=[NSString stringWithFormat:@"%@",[message.data valueForKey:@"content"]];//[(+系统消息+)]
    }
    else if (message.type==SLChatRoomMessageTypeRanking)
    {
        NSDictionary * array=message.data;
        NSMutableArray * userModelList=[NSDictionary mj_objectArrayWithKeyValuesArray:array];
        NSDictionary * dic = [userModelList objectAtIndex:0];
        NSString * name=[dic valueForKey:@"nickName"];
        
        str=[NSString stringWithFormat:@"恭喜%@成为直播室第一土豪~~",name?:@""];//[(+房间消息+)]
        
    }
    else if (message.type==SLChatRoomMessageTypeKict)
    {
        NSInteger forbid=[[message.data valueForKey:@"forbid_type"] integerValue];
        if (forbid==2)
            str=[NSString stringWithFormat:@"%@被%@禁言5分钟",[message.data valueForKey:@"nickName"],[message.data valueForKey:@"opt_nickName"]];//[(+房间消息+)]
        else if (forbid==1)
            str=[NSString stringWithFormat:@"%@已被%@踢出房间1小时",[message.data valueForKey:@"nickName"],[message.data valueForKey:@"opt_nickName"]];//[(+房间消息+)]
        else{
            str=[NSString stringWithFormat:@"%@被%@禁言5分钟",[message.data valueForKey:@"nickName"],[message.data valueForKey:@"opt_nickName"]];//[(+房间消息+)]

        }
    }
    else if (message.type==SLChatRoomMessageTypeFocus)
    {
        str=[NSString stringWithFormat:@"%@关注了主播，不错过下次直播",[message.data valueForKey:@"nickName"]];//[(+房间消息+)]
    }
    else if (message.type== SLChatRoomMessageTypeCreatRoom){
        str=@"聊天室已恢复连接";
    }
    else if (!message.type)
    {
        user=[NSString dictionaryWithJsonString:message.messageExtra];
        
        if ([[user valueForKey:@"isAdmin"] integerValue]==1)
        {
            str=[NSString stringWithFormat:@"%@:%@",[user valueForKey:@"nickName"],message.messageContent];//[(+level_P+)]
        }
        else
        {
            if (![[user valueForKey:@"id"] isEqualToString:[AccountModel shared].uid]) {
                NSString * level=[user valueForKey:@"fanLevel"];
                if (level) {
                    str=[NSString stringWithFormat:@"%@:%@",[user valueForKey:@"nickName"],message.messageContent];//[(+level_%@+)],[user valueForKey:@"fanLevel"]
                }
                else
                {
                    str=[NSString stringWithFormat:@"%@:%@",[user valueForKey:@"nickName"],message.messageContent];//[user valueForKey:@"level"],
                }
            }
            else
                str=[NSString stringWithFormat:@"%@:%@",[AccountModel shared].nickname,message.messageContent];//[(+level_%@+)][BKSession sharedSession].fanLevel,
        }
    }
        return str ;
}

+ (UIColor *)adapterColor:(SLMessageInfo *)message{
    UIColor *color = nil ;
    if ([SLLive_IM_SEND_WangAn isEqualToString:message.messageExtra] == YES)
    {
        color = RGBACOLOR(43, 210, 182, 1);
    }
    else if (message.type==1)
    {
        color = RGBACOLOR(255, 77, 106, 1);
    }
    else if(message.type==2)
    {
        color = RGBACOLOR(162, 255, 0, 1);
    }
    else if (message.type==11||message.type==12||message.type==13||message.type==14)
    {
        color = RGBACOLOR(187, 162, 255, 1);
    }
    else if (message.type==9)
    {
        color = RGBACOLOR(255, 255, 255, 1);
    }
    else if (message.type==10)
    {
        color = RGBACOLOR(255, 96, 150, 1);
    }
    else if (!message.type||message.type==3)
    {
        color = [UIColor whiteColor];
        
    }else if(message.type == 7){
        color = [UIColor blackColor];
    }
    return color ; 
}

+ (ChatRoomModel *)attributedModelWithString:(SLMessageInfo *)content{
    
 //   NSString *str = [self creatstring:content];
    ChatRoomModel *model = [[ChatRoomModel alloc]init];
    model.showThisMessage = YES ;
    NSDictionary * user=nil;
    NSString *speakName = nil ;
    NSString *imageName = nil ;
    UIImage *levelImage = nil ;
    NSString *levelString = nil ;
    if (!content.type&&[SLLive_IM_SEND_WangAn isEqualToString:content.messageExtra] == NO)
    {
        user=[NSString dictionaryWithJsonString:content.messageExtra];
        if ([[user valueForKey:@"id"] integerValue] !=[[AccountModel shared].uid integerValue])
        {
            speakName =[user valueForKey:@"nickName"];
        }
        else
        {
            speakName = [AccountModel shared].uid;
        }
        NSString * level=nil;
        if ([[user valueForKey:@"isAdmin"] integerValue]==1)
        {
            level=@"level_P";
        }
        else
        {
            levelString = [user valueForKey:@"fanLevel"];
            level=[NSString stringWithFormat:@"level_%@",[user valueForKey:@"fanLevel"]];
        }
        model.postionType = ImagePostionType_left ;
        levelImage =[UIImage imageNamed:level]; //支持网络
    }
    else
    {
        if ([content.data isKindOfClass:[NSArray class]])
        {
            NSArray * array =(NSArray *)content.data;
            if ([array count]>0) {
                user =[(NSArray *)content.data objectAtIndex:0];
            }
        }
        else
        {
            user =content.data;
        }
        if (content.type==1)
        {
            speakName=[content.data valueForKey:@"fromNickName"];
            imageName =[content.data valueForKey:@"giftImg"]; //支持网络
            NSString * level=nil;
            if ([[user valueForKey:@"isAdmin"] integerValue]==1)
            {
                level=@"level_P";
            }
            else
            {
                level=[NSString stringWithFormat:@"%@",[user valueForKey:@"fromUserLevel"]];
            }
            model.postionType = ImagePostionType_left ;
            levelImage =[UIImage imageNamed:level]; //支持网络
        }
        else if (content.type==3)
        {
            speakName=[user valueForKey:@"nickName"];
            NSString * level;
            if ([[content.data valueForKey:@"isAdmin"] integerValue]==1)
            {
                level=@"level_P";
            }
            else
            {
                levelString = [user valueForKey:@"fanLevel"];
                level=[NSString stringWithFormat:@"%@",[user valueForKey:@"fanLevel"]];
            }
            model.postionType = ImagePostionType_left ;
            levelImage =[UIImage imageNamed:@"房间消息"]; //支持网络
        }
        else if(content.type==7)
        {
            speakName = [user valueForKey:@"nickName"];
            
            // =[UIImage imageNamed:@"红心"]; //支持网络
            NSString * level=nil;
            if ([[content.data valueForKey:@"isAdmin"] integerValue]==1)
            {
                level=@"level_P";
            }
            else
            {
                levelString = [user valueForKey:@"fanLevel"];
                level=[NSString stringWithFormat:@"%@",[user valueForKey:@"fanLevel"]];
            }
            model.postionType = ImagePostionType_left ;
            levelImage=[UIImage imageNamed:level]; //支持网络
            //self.imMassage1.position = 0;
        }
        else if (content.type==2||content.type==9||content.type==11||content.type==12||content.type==13||content.type==14) {
            if ([[user valueForKey:@"id"] integerValue] !=[[AccountModel shared].uid integerValue]) {
                speakName=[user valueForKey:@"nickName"];
            }
            else
            {
                speakName=[AccountModel shared].nickname;
            }
            
            if(content.type ==11 ){
                NSString *uid = [NSString stringWithFormat:@"%@",[user valueForKey:@"uid"]];
                if([uid isEqualToString:lastSendGiftUid] || IsStrEmpty(uid)){
                    model.showThisMessage = NO ;
                }else{
                    lastSendGiftUid = uid;
                }
            }
           
            levelImage =[UIImage imageNamed:@"房间消息"]; //支持网络
            
        }
        else if ([SLLive_IM_SEND_WangAn isEqualToString:content.messageExtra] == YES||content.type==10)
        {
            speakName=@"";
            model.postionType = ImagePostionType_left ;
            levelImage =[UIImage imageNamed:@"系统消息"]; //支持网络
        }
    }
    
    model.user = user ;
    model.imageName = imageName;
    model.levelImage = levelImage;
    model.levelString =[user valueForKey:@"fanLevel"]?:@"0";
    return  model ;
}

+(UIView *)diamondCountView{
    UIView *diamondCountView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 28, 15)];
    diamondCountView.backgroundColor = [UIColor greenColor];
    UILabel *countLabel = [[UILabel alloc]init];
    countLabel.textColor = [UIColor whiteColor];
    countLabel.textAlignment = NSTextAlignmentCenter    ;
    countLabel.text = @"12";
    countLabel.font = [UIFont systemFontOfSize:10];
    [diamondCountView addSubview:countLabel];
    [countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(diamondCountView);
    }];
    return diamondCountView;
}
//chat_user_levelheigh chat_user_levellow
+ (UIView *)userLevelViewWithModel:(ChatRoomModel *)chatModel {
    LevelType type ;
    if ([[chatModel.user valueForKey:@"id"] integerValue] !=[[AccountModel shared].uid integerValue]){
        type =LevelType_ShowCoin ;
    }else{
        type =LevelType_Host ;
    }

    SLLevelMarkView * level = [[SLLevelMarkView alloc]initWithFrame:CGRectMake(0, 0, 30, 15) withType: type];
    level.level =chatModel.levelString;
    return level ;
}



@end

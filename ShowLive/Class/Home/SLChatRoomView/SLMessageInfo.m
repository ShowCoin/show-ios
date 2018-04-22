//
//  SLMessageInfo.m
//  ShowLive
//
//  Created by zhangxinggong on 2018/4/13.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "SLMessageInfo.h"
#import <YYText.h>

@implementation SLMessageInfo

- (instancetype)initWithRCText:(RCMessage *)message{
    if(self = [super init]){
        RCTextMessage *messageIm = (RCTextMessage *)message.content;
        self.roomId=message.targetId;
        self.userId = messageIm.senderUserInfo.userId;
        self.name = messageIm.senderUserInfo.name;
        self.portraitUri = messageIm.senderUserInfo.portraitUri;
        self.messageContent = messageIm.content;
        self.messageExtra= messageIm.extra;
        self.objectName = message.objectName;
        self.data = [NSString dictionaryWithJsonString:messageIm.extra];
        self.type = [[[NSString dictionaryWithJsonString:messageIm.extra] valueForKey:@"type"] longValue];
    }
    return self ;
}

- (void)setAttribute:(NSAttributedString *)attribute{
    if(_attribute != attribute){
        _attribute =attribute;
        if(attribute !=nil){
            self.height;
        }
    }
}

- (CGFloat)height{
    if(!_height){
        NSAttributedString *string = self.attribute;
        if(!self.type){
            CGSize size = CGSizeMake(KScreenWidth *0.64-55, CGFLOAT_MAX);
            YYTextLayout *layout = [YYTextLayout layoutWithContainerSize:size text:string];
            _height = layout.textBoundingSize.height + 15;
        }else{
            CGSize size = CGSizeMake(KScreenWidth *0.64-12, CGFLOAT_MAX);
            YYTextLayout *layout = [YYTextLayout layoutWithContainerSize:size text:string];
            _height = layout.textBoundingSize.height + 15;
        }
    }
    return _height;
}

@end

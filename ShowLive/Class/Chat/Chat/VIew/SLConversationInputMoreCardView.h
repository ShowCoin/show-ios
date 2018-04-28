//
//  SLConversationInputMoreCardView.h
//  ShowLive
//
//  Created by Mac on 2018/4/11.
//  Copyright © 2018年 VNing. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, SLConversationInputMoreCardViewButtonType) {
    SLConversationInputMoreCardViewButtonTypeGift = 100,
    SLConversationInputMoreCardViewButtonTypeCamera,
    SLConversationInputMoreCardViewButtonTypeLocation,
    SLConversationInputMoreCardViewButtonTypeDlice
    
};

@protocol SLConversationInputMoreCardViewDelegate <NSObject>

- (void)conversationInputMoreCardViewDidClickBtnWithType:(SLConversationInputMoreCardViewButtonType)type;

@end
@interface SLConversationInputMoreCardView : UIView

@property (nonatomic, copy) void (^didTapedBlock)(SLConversationInputMoreCardViewButtonType type);
@property (nonatomic, weak) id<SLConversationInputMoreCardViewDelegate> delegate;
@end

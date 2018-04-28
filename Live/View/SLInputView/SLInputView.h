//
//  SLInputView.h
//  ShowLive
//
//  Created by WorkNew on 2018/4/12.
//  Copyright © 2018年 VNing. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SLInputDelegate <NSObject>

@optional

- (void)showInputView;
- (void)hideInputView;

-(void)sendText:(NSString*)text
          isPay:(BOOL)isPay;

-(void)inputViewHeightChange:(CGFloat)height;


@end

@interface SLInputView : UIView

@property (nonatomic, weak) id<SLInputDelegate>delegate;

//开始聊天
-(void)beginChat;


@end

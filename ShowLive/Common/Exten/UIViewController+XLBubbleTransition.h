//
//  UIViewController+XLBubbleTransition.h
//  XLBubbleTransitionDemo
//
//  Created by  JokeSmileZhang on 2017/4/1.
//  Copyright © 2017年 JokeSmileZhang. All rights reserved.
//  GitHub ：https://github.com/JokeSmileZhang/XLBubbleTransition

#import <UIKit/UIKit.h>
#import "XLBubbleTransition.h"

@interface UIViewController (XLBubbleTransition)<UINavigationControllerDelegate,UIViewControllerTransitioningDelegate>

@property (nonatomic, retain) XLBubbleTransition *xl_pushTranstion;

@property (nonatomic, retain) XLBubbleTransition *xl_popTranstion;

@property (nonatomic, retain) XLBubbleTransition *xl_presentTranstion;

@property (nonatomic, retain) XLBubbleTransition *xl_dismissTranstion;

@end

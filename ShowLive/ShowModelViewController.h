//
//  ShowModelViewController.h
//  ShowLive
//
//  Created by Mac on 2018/4/5.
//  Copyright © 2018年 VNing. All rights reserved.
//

#import "BaseViewController.h"

@interface ShowModelViewController : BaseViewController
+ (ShowModelViewController*)presentViewController: (UIViewController*)viewController animated: (BOOL)animated completion: (void (^)(void))completion;

+ (void)dismissAll;

+ (void)dismissAllCompletionCallback: (void (^)(void))completionCallback;

@end

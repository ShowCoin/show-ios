//
//  SLNavigationControllerTransition.h
//  ShowLive
//
//  Created by iori_chou on 2018/5/2.
//  Copyright © 2018年 vning. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SLNavigationControllerTransition : NSObject<UINavigationControllerDelegate>
- (void)pan:(UIPanGestureRecognizer *)panGes;

@end

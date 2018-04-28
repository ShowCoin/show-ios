//
//  SLADView.h
//  ShowLive
//
//  Created by NicholasChou on 2018/4/17.
//  Copyright © 2018年 VNing. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol SLADViewDelegate <NSObject>

- (void)ADViewWillDisappear;

@end

@interface SLADView : UIView
@property (nonatomic, weak) id<SLADViewDelegate> delegate;

@end

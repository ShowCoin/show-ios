//
// Copyright 2009-2011 Facebook
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//

#import "UIView+TTUICommon.h"

// Core
//#import "Three20Core/TTCorePreprocessorMacros.h"


///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
/**
 * Additions.
 */
//TT_FIX_CATEGORY_BUG(UIView_TTUICommon)

#define KLoadingViewTag 200
#import "ShowAppDelegateAppDelegate.h"

@implementation UIView (TTUICommon)


///////////////////////////////////////////////////////////////////////////////////////////////////
- (UIViewController*)viewController {
  for (UIView* next = [self superview]; next; next = next.superview) {
    UIResponder* nextResponder = [next nextResponder];
    if ([nextResponder isKindOfClass:[UIViewController class]]) {
      return (UIViewController*)nextResponder;
    }
  }
  return nil;
}

/// 弹窗
- (void)ShowResultView:(BOOL)success ErrorMsg:(NSString *)error {
    int viewWidth = 150;
    int imageWidth = 60;
    int imageHeight = 52.5;
    float CORNER_RADIUS = 6.0;
    UIColor *color = [UIColor colorWithWhite:0.0 alpha:0.75];
    CGSize fullSize = [[UIScreen mainScreen] bounds].size;
    CGRect rect;
    rect.origin.x = (fullSize.width - viewWidth) * 0.5;
    rect.origin.y = (fullSize.height- viewWidth) * 0.5 - 44 ;
    rect.size.width = viewWidth;
    rect.size.height = viewWidth;
    UIView *hudView = [[UIView alloc] initWithFrame:rect];
    hudView.backgroundColor = color;
    hudView.layer.cornerRadius = CORNER_RADIUS;
    hudView.clipsToBounds = YES;
    
    int imageLeft = (viewWidth - imageWidth) / 2 ;
    int imageTop  = (viewWidth - imageHeight) / 2 - 10;
    UIImageView *remindView=[[UIImageView alloc] initWithFrame:CGRectMake(imageLeft , imageTop, imageWidth , imageHeight)];
    remindView.contentMode = UIViewContentModeCenter;
    [hudView addSubview:remindView];
    remindView.image= success ? [UIImage imageNamed:@"common_alert_image_yes"]:[UIImage imageNamed:@"common_alert_image_no"];
    //    [remindView release];
    
    int messageLeft = 5  ;
    int messageTop = imageHeight + imageTop  ;
    int messageHeight =  viewWidth - messageTop  ;
    int messageWidth =  viewWidth - 2.0 * messageLeft;
    UIFont *font = [UIFont fontWithName:@"Helvetica-Bold" size:15.0];
    UIColor *textColor = [UIColor whiteColor];
    CGRect messageRect = CGRectMake(messageLeft, messageTop , messageWidth, messageHeight);
    UILabel *messageLabel = [[UILabel alloc] initWithFrame:messageRect];
    [messageLabel setFont:[UIFont systemFontOfSize:12]];
    messageLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    messageLabel.numberOfLines = 2;
    messageLabel.backgroundColor = [UIColor clearColor];
    messageLabel.textAlignment = NSTextAlignmentCenter;
    messageLabel.adjustsFontSizeToFitWidth=YES;
    messageLabel.font = font;
    messageLabel.textColor = textColor;
    messageLabel.text = error;
    [hudView  addSubview:messageLabel];
    //    [messageLabel release];
    hudView.tag = KLoadingViewTag;
    
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [appDelegate.window addSubview:hudView];
    [self performSelector:@selector(hideResultView:) withObject:hudView afterDelay:1];
    //    [hudView release];
}

- (void)hideResultView:(id)sender {
    UIView *resultView = (UIView *)sender;
    if (resultView)
    {
        [resultView removeFromSuperview];
    }
}


@end


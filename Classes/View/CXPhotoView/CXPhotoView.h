//
//  CXPhotoView.h
//  test
//
//  Created by chenyh on 2018/5/31.
//  Copyright © 2018年 chuxia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CXPhotoView : UICollectionView

+ (instancetype)cx_photoView;
- (UIViewController *)getPickerVC;

@end

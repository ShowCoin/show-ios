//
//  DCCodeInputView.h
//  ShowLive
//
//  Created by chenyh on 2019/1/26.
//  Copyright © 2019 vning. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DCCodeInputView : UICollectionView <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) NSString *text;

+ (instancetype)inputView;

@end

static NSInteger const kDCGoogleCodeLength = 6;

NS_ASSUME_NONNULL_END

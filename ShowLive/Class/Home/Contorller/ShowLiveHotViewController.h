//
//  ShowLiveHotViewController.h
//  ShowLive
//
//  Created by vning on 2018/4/7.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "BaseViewController.h"

@interface ShowLiveHotViewController : BaseViewController<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic,strong)UICollectionView * mainCollectionView;

@end

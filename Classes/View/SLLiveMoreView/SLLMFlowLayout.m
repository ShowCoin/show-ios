//
//  SLLMFlowLayout.m
//  test
//
//  Created by chenyh on 2018/5/31.
//  Copyright © 2018年 chuxia. All rights reserved.
//

#import "SLLMFlowLayout.h"

static NSInteger const kRow = 3; // list row count


@implementation SLLMFlowLayout


- (void)prepareLayout {
    [super prepareLayout];
    
    self.minimumLineSpacing = kMargin10;
    self.minimumInteritemSpacing = 0;
    self.sectionInset = UIEdgeInsetsMake(14, 20, 0, 20);
    
    CGFloat w = self.collectionView.frame.size.width - self.sectionInset.left - self.sectionInset.right;
    CGFloat itemW = w / kRow;
    self.itemSize = CGSizeMake(itemW, 80);
}


@end

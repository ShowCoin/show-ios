//
//  SLPlayerBottomView.m
//  ShowLive
//
//  Created by 巩鑫 on 2018/4/10.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "SLPlayerBottomView.h"
#import "SLPlayerBottomCollectionViewCell.h"
@interface SLPlayerBottomView () <UICollectionViewDataSource,UICollectionViewDelegate>

@property(nonatomic,strong)NSArray * cellArray;

@end
@implementation SLPlayerBottomView

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout
{
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        
        self.delegate = self;
        self.dataSource = self;
        self.showsHorizontalScrollIndicator=NO;
        self.bounces = YES;
        self.backgroundColor = [UIColor clearColor];
        [self registerClass:[SLPlayerBottomCollectionViewCell
                             class] forCellWithReuseIdentifier:@"SLPlayerBottomCollectionViewCell"];
    }
    return self;
}

-(void)initData
{
    
}


#pragma ----collectionDelegate-------

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGSizeMake(38, 38);
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 3;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * identifier = @"SLPlayerBottomCollectionViewCell";
    SLPlayerBottomCollectionViewCell * cell;
    if(!cell)
    {
        cell= (SLPlayerBottomCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    }
    return cell;
    
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    CGFloat spacing = (kScreenWidth-38*7)/8;
    return UIEdgeInsetsMake(9,spacing,9,spacing);
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath;
{
    return YES;
}

@end

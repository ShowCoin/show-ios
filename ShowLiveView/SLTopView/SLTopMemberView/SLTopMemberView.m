//
//  SLTopMemberView.m
//  ShowLive
//
//  Created by 巩鑫 on 2018/4/9.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "SLTopMemberView.h"
#import "SLTopMemberViewCollectionViewCell.h"
@interface SLTopMemberView () <UICollectionViewDataSource,UICollectionViewDelegate>

@end
@implementation SLTopMemberView

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout
{
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
  
        self.delegate = self;
        self.dataSource = self;
        self.showsHorizontalScrollIndicator=NO;
        self.bounces = YES;
        
        [self registerClass:[SLTopMemberViewCollectionViewCell
                                              class] forCellWithReuseIdentifier:@"SLTopMemberViewCollectionViewCell"];
    }
    return self;
}

-(void)changeAudienceWidth:(CGFloat)width
{
    CGFloat sWidth=self.width;
    self.frame=CGRectMake(self.mj_x+(sWidth-width), self.mj_y, width, self.height);
}

-(void)changeBackAudienceWithWidth:(CGFloat)width
{
    self.frame=CGRectMake(self.mj_x, self.mj_y, width, self.height);

}

#pragma ----collectionDelegate-------

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {

    return CGSizeMake(32, 32);
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString * identifier = @"SLTopMemberViewCollectionViewCell";
    SLTopMemberViewCollectionViewCell * cell;
    if(!cell)
    {
        cell= (SLTopMemberViewCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    }
    return cell;
    
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    //上左下右
    return UIEdgeInsetsMake(0,1,0,1);
    
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath;
{
    return YES;
}

-(void)setMemberArray:(NSArray *)memberArray
{
    _memberArray = memberArray;
    [self reloadData];
}
@end

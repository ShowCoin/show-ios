//
//  SLLiveBottomView.m
//  ShowLive
//
//  Created by WorkNew on 2018/4/13.
//  Copyright © 2018年 VNing. All rights reserved.
//

#import "SLLiveBottomView.h"
#import "SLLiveBottomCollectionViewCell.h"
#import "SLBottomLikeCollectionViewCell.h"
@interface SLLiveBottomView () <UICollectionViewDataSource,UICollectionViewDelegate>

@property(nonatomic,strong)UILabel * nickLabel;
@property(nonatomic,strong)UILabel * musicLabel;
@property(nonatomic,strong)UICollectionView * collectionView;
@property(nonatomic,strong)NSArray * cellArray;
@property(nonatomic,strong)UIView * lineView;

@end
@implementation SLLiveBottomView

-(void)dealloc
{
    NSLog(@"[gx] bottom view dealloc");
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
        
        [self addSubview:self.nickLabel];
        [self addSubview:self.musicLabel];
        [self addSubview:self.collectionView];
        [self addSubview:self.lineView];
     
    }
    return self;
}

-(void)setAnchorNickName:(NSString*)nickName
               liveTheme:(NSString*)theme
{
    self.nickLabel.text = [NSString stringWithFormat:@"%@ | %@",nickName,theme];
}

-(UILabel*)nickLabel
{
    if (!_nickLabel) {
        _nickLabel = [[UILabel alloc]initWithFrame:CGRectMake(20,5,KScreenWidth-100, 20.f)];
        _nickLabel.font = [UIFont systemFontOfSize:18];
        _nickLabel.textColor = [UIColor whiteColor];
        _nickLabel.textAlignment = NSTextAlignmentLeft;
        _nickLabel.layer.shadowRadius = 4.0f;
        _nickLabel.layer.shadowOpacity = 0.5;
        _nickLabel.layer.shadowColor = [UIColor blackColor].CGColor;
        _nickLabel.layer.shadowOffset = CGSizeMake(2, 2);
        _nickLabel.layer.masksToBounds = NO;

    }
    return _nickLabel;
}

-(UILabel*)musicLabel
{
    if (!_musicLabel) {
        _musicLabel = [[UILabel alloc]initWithFrame:CGRectMake(20,5,KScreenWidth/2-20, 20.f)];
        _musicLabel.font = [UIFont systemFontOfSize:16];
        _musicLabel.textColor = [UIColor whiteColor];
        _musicLabel.textAlignment = NSTextAlignmentLeft;
        _musicLabel.layer.shadowRadius = 4.0f;
        _musicLabel.layer.shadowOpacity = 0.5;
        _musicLabel.layer.shadowColor = [UIColor blackColor].CGColor;
        _musicLabel.layer.shadowOffset = CGSizeMake(2, 2);
        _musicLabel.layer.masksToBounds = NO;
        
    }
    return _musicLabel;
}

-(UIView*)lineView
{
    if (!_lineView) {
        _lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 50, KScreenWidth, 1)];
        _lineView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
        
    }
    return _lineView;
}

-(UICollectionView*)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;

        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 50,KScreenWidth,50) collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsHorizontalScrollIndicator=NO;
        _collectionView.bounces = YES;
        [_collectionView registerClass:[SLLiveBottomCollectionViewCell
                             class] forCellWithReuseIdentifier:@"SLLiveBottomCollectionViewCell"];
        [_collectionView registerClass:[SLBottomLikeCollectionViewCell class] forCellWithReuseIdentifier:@"SLBottomLikeCollectionViewCell"];
        
    }
    return _collectionView;
}



-(void)setControllerType:(SLLiveContollerType)controllerType
{
    _controllerType = controllerType;

    NSDictionary * dict = @{};
    NSDictionary * chat = @{@"image":@"live_bottom_chat",@"type":@"0"};
    NSDictionary * beautify = @{@"image":@"live_bottom_beauty",@"type":@"1"};
    NSDictionary * message = @{@"image":@"live_bottom_message",@"type":@"2"};
    NSDictionary * gift = @{@"image":@"live_bottom_gift",@"type":@"3"};
   // NSDictionary * fastGift = @{@"image":@"live_bottom_fast_gift",@"type":@"4"};
    NSDictionary * share  = @{@"image":@"live_bottom_share",@"type":@"5"};
    NSDictionary * more  = @{@"image":@"live_bottom_more",@"type":@"6"};
    NSDictionary * like  = @{@"image":@"live_bottom_like",@"type":@"7"};
    
    NSArray * playerArray = @[chat,dict,dict,gift,share,message,like];
    NSArray * anchorArray = @[chat,dict,dict,beautify,share,message,more];
    self.cellArray =(controllerType==SLLiveContollerTypeLive)?anchorArray:playerArray;
    [self.collectionView reloadData];
}


#pragma ----collectionDelegate-------

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (indexPath.row) {
        case 0:
        {
            if(_controllerType == SLLiveContollerTypePlayer)
            {
                return  CGSizeMake(38*3, 38);
            }
        }
            break;
            case 1:
        {
            if(_controllerType == SLLiveContollerTypePlayer)
            {
                 return  CGSizeMake(19,0);
            }

        }
            break;
            case 2:
        {
            if(_controllerType == SLLiveContollerTypePlayer)
            {
                return  CGSizeMake(19,0);
            }
        }
            break;
            case 4:
        {
            if(_controllerType == SLLiveContollerTypePlayer)
            {
                return   CGSizeMake(70, 38);
            }
    
        }
            break;
       
        default:
            break;
    }
    
    return CGSizeMake(38, 38);
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.cellArray count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * identifier = @"SLLiveBottomCollectionViewCell";
    static NSString * likeCellID = @"SLBottomLikeCollectionViewCell";
    SLLiveBottomCollectionViewCell * cell;
    if(!cell)
    {
        cell= (SLLiveBottomCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    }

    if (self.controllerType==SLLiveContollerTypePlayer && indexPath.row==6) {
        SLBottomLikeCollectionViewCell * likeCell;
        if (!likeCell) {
            likeCell = (SLBottomLikeCollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:likeCellID forIndexPath:indexPath];
        }
        return likeCell;
        
    }
    
    cell.type = SLLiveBottomViewCellTypeOnlyImage;
    
    switch (indexPath.row) {
        case 0:
        {
            if (self.controllerType==SLLiveContollerTypePlayer) {
                cell.type = SLLiveBottomViewCellTypeInput;
            }
        }
            break;
        case 4:
        {
            
            if (self.controllerType==SLLiveContollerTypePlayer) {
                   cell.type = SLLiveBottomViewCellTypeText;
            }
          
        }
            break;
        case 6:
        {
            if (self.controllerType==SLLiveContollerTypePlayer) {
                 cell.type = SLLiveBottomViewCellTypeText;
            }
        }
            break;
        default:
            break;
    }
    
    
    cell.icon = [self.cellArray[indexPath.item] valueForKey:@"image"];


    return cell;
    
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{

    NSDictionary * dict = self.cellArray[indexPath.item];
    
    if (IS_DICTIONARY_CLASS(dict)) {
        SLBottomButtonClickType type = [dict[@"type"] integerValue];
        if (self.protocol&&[self.protocol respondsToSelector:@selector(selectBottomViewAtIndex:)]) {
            [self.protocol selectBottomViewAtIndex:type];
        }
    }
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

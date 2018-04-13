//
//  SLPushPreView.m
//  ShowLive
//
//  Created by 巩鑫 on 2018/4/11.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "SLPushPreView.h"
#import "SLShareViewCollectionViewCell.h"
@interface SLPushPreView()<UICollectionViewDelegate,UICollectionViewDataSource,UITextFieldDelegate>

//相机按钮
@property(nonatomic,strong)UIButton    * cameraButton;
//关闭按钮
@property(nonatomic,strong)UIButton    * closeButton;
//开播按钮
@property(nonatomic,strong)UIButton * beginButton;
//美颜按钮
@property(nonatomic,strong)UIButton * skinButton;
//主题输入框
@property(nonatomic,strong)UITextField * themeTextFiled;

//分享视图
@property(nonatomic,strong)UICollectionView * collectionView;
@property(nonatomic,strong)NSMutableArray * dataArray;


@end
@implementation SLPushPreView

-(id)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {

        [self addSubview:self.cameraButton];
        [self addSubview:self.closeButton];
        [self addSubview:self.themeTextFiled];
        [self addSubview:self.collectionView];
        [self addSubview:self.beginButton];
        [self addSubview:self.collectionView];
    }
    return self;
    
}

-(UIButton*)cameraButton
{
    if (!_cameraButton) {
        _cameraButton=[[UIButton alloc]initWithFrame:CGRectMake(10, 17+KNaviBarSafeBottomMargin, 40, 40)];
        [_cameraButton setImage:[UIImage imageNamed:@"live_close_push"] forState:UIControlStateNormal];
        [_cameraButton addTarget:self action:@selector(cameraButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cameraButton;
}

-(UIButton*)closeButton
{
    if (!_closeButton) {
        _closeButton=[[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth-50, 17+KNaviBarSafeBottomMargin, 40, 40)];
        [_closeButton setImage:[UIImage imageNamed:@"live_close_push"] forState:UIControlStateNormal];
        [_closeButton addTarget:self action:@selector(closeButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeButton;
}

-(UITextField*)themeTextFiled
{
    if (!_themeTextFiled) {
        //输入标题框
        _themeTextFiled=[[UITextField alloc]initWithFrame:CGRectMake(25,KScreenHeight/2, kScreenWidth-50 , 42)];
        _themeTextFiled.placeholder = @"直播标题";
        _themeTextFiled.clearButtonMode = UITextFieldViewModeWhileEditing;
        _themeTextFiled.textColor=[UIColor whiteColor];
        _themeTextFiled.font=[UIFont systemFontOfSize:18];
        _themeTextFiled.delegate=self;
        _themeTextFiled.textAlignment=NSTextAlignmentLeft;
        [_themeTextFiled addTarget:self action:@selector(themeTextChange) forControlEvents:UIControlEventEditingChanged];
        _themeTextFiled.returnKeyType = UIReturnKeyDone;
        
    }
    return _themeTextFiled;
}


-(UICollectionView*)collectionView
{
    if (!_collectionView) {
        //普通集合视图布局
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        CGFloat spacing =  (kScreenWidth-50*5)/6;
        layout.minimumLineSpacing = spacing;
        layout.minimumInteritemSpacing = spacing;
        layout.itemSize = CGSizeMake(50, 70);

        CGRect rect = CGRectMake(0, KScreenHeight/2+52,KScreenWidth,70);
        _collectionView =[[UICollectionView alloc]initWithFrame:rect collectionViewLayout:layout];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.backgroundColor = [UIColor clearColor];
        [_collectionView registerClass:[SLShareViewCollectionViewCell class] forCellWithReuseIdentifier:@"SLShareViewCollectionViewCell"];
        
        
    }
    return _collectionView;
}

-(UIButton*)beginButton
{
    if (!_beginButton) {
        
        //开始按钮
        _beginButton=[UIButton buttonWithType:UIButtonTypeCustom];
        _beginButton.frame= CGRectMake(kScreenWidth/2-153.5,KScreenHeight/2+52+70+40,88, 88);
        [_beginButton setBackgroundImage:[UIImage imageNamed:@"live_push_begin"] forState:UIControlStateNormal];
        _beginButton.layer.cornerRadius=44.f;
        _beginButton.layer.masksToBounds = YES;
        [_beginButton setTitle:@"开启直播" forState:UIControlStateNormal];
        [_beginButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _beginButton.titleLabel.font=[UIFont systemFontOfSize:17];
        [_beginButton addTarget:self action:@selector(beginButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _beginButton;
}


-(NSMutableArray*)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

#pragma mark delegate
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    //上左下右
    return UIEdgeInsetsMake(16,13,13,16);
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    SLShareViewCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SLShareViewCollectionViewCell" forIndexPath:indexPath];
    
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}


@end

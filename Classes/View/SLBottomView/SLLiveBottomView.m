//
//  SLLiveBottomView.m
//  ShowLive
//
//  Created by gongxin on 2018/4/13.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "SLLiveBottomView.h"
#import "SLLiveBottomCollectionViewCell.h"
#import "SLBottomLikeCollectionViewCell.h"
#import "SLVolumeView.h"
#import "SLMusicView.h"
#import "SLShadowLabel.h"
#import "CBAutoScrollLabel.h"
#import "SLLoopView.h"
#import "HomeHeader.h"
#import "SLBottomAimationView.h"
#import "ShowHomeBaseController.h"

static CGFloat kCellWidth60 = 60;
static CGFloat kCellWidth30 = 30;
static CGFloat kCellWidth42 = 42;
static CGFloat kCellMargin  = 8;
static CGFloat kLRMargin    = 15;

@interface SLLiveBottomView () <UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic, strong) NSArray * cellArray;
@property (nonatomic, strong) UIView * volumeView;
@property (nonatomic, copy)   NSString * shareCount;
@property (nonatomic, strong) SLLoopView *loopView;
@property (nonatomic, strong) UIButton *centerBtn;

@end

@implementation SLLiveBottomView {
    NSString *_nickName;
}

-(void)dealloc
{
    NSLog(@"[gxx] bottom view dealloc");
    [self.loopView endAnimation];
    [self removeNotification];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self addSubview:self.loopView];
        [self addSubview:self.collectionView];
        [self.collectionView addSubview:self.volumeView];
        [self.collectionView addSubview:self.centerBtn];
        [self addNotification];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat w = self.frame.size.width;
    CGFloat h = self.frame.size.height;
    self.loopView.frame = CGRectMake(0, 0, w, kSLLoopViewHeight);
    self.volumeView.frame = CGRectMake(0, 0, w, 1);
    CGFloat collectY = h - KTabBarHeight;
    CGFloat collectH = 49;
    self.collectionView.frame = CGRectMake(0, collectY, w, collectH);
    self.centerBtn.bounds = CGRectMake(0, 0, 75.5, 44.5);
    self.centerBtn.center = CGPointMake(w / 2, collectH / 2);
}

- (void)addNotification
{
    @weakify(self);
    
//    [RACObserve(self.collectionView, hidden) subscribeNext:^(id x) {
//        if(![x boolValue]){
//            
//        }
//    }];
    
    [[[NSNotificationCenter defaultCenter]rac_addObserverForName:SLPlayerBottomCollectionNotification object:nil] subscribeNext:^(id x) {
        @strongify(self);
        
        if (self.controllerType == SLLiveContollerTypeLive) {
            return ;
        }
        if([[x object] boolValue]){
            self.collectionView.hidden = YES;
        }else{
            self.collectionView.hidden = NO;
        }
    }];
    
    [[[NSNotificationCenter defaultCenter]rac_addObserverForName:SLLiveBackClickCollectionNotification object:nil] subscribeNext:^(id x) {
        @strongify(self);
        if([[x object] boolValue]){
            self.collectionView.hidden = YES;
        }else{
            self.collectionView.hidden = NO;
        }
    }];
    
    if([SLBottomAimationView isShowingTabbar] && ![ShowHomeBaseController isScollerPlayerView] && self.controllerType != SLLiveContollerTypeLive){
        self.collectionView.hidden = YES ;
    }
}

-(void)removeNotification
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}



-(void)setLiveTheme:(NSString*)theme
{
    if (IsStrEmpty(theme)) {
        return;
    }
    NSString *name = [NSString stringWithFormat:@"%@ | %@", _nickName, theme];
    [self.loopView setTitle:name subTitle:nil];
}

-(void)musicClick
{
    [HDHud _showMessageInView:[UIApplication sharedApplication].keyWindow title:@"敬请期待"];
}

-(void)setAnchorNickName:(NSString*)nickName
{
    _nickName = nickName;
    [self.loopView setTitle:nickName subTitle:nil];
}

-(UIView *)volumeView
{
    if (!_volumeView) {
        _volumeView = [[SLVolumeView alloc] init];
        _volumeView.backgroundColor = [[UIColor whiteColor]colorWithAlphaComponent:0.2];
    }
    return _volumeView;
}

- (UICollectionView*)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.minimumLineSpacing = kCellMargin;
        layout.minimumInteritemSpacing = kCellMargin;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsHorizontalScrollIndicator=NO;
        _collectionView.bounces = YES;
        _collectionView.scrollEnabled = NO;
        [_collectionView registerClass:[SLLiveBottomCollectionViewCell
                                        class] forCellWithReuseIdentifier:@"SLLiveBottomCollectionViewCell"];
        [_collectionView registerClass:[SLBottomLikeCollectionViewCell class] forCellWithReuseIdentifier:@"SLBottomLikeCollectionViewCell"];
    }
    return _collectionView;
}

- (SLLoopView *)loopView {
    if (!_loopView) {
        _loopView = [[SLLoopView alloc] init];
    }
    return _loopView;
}

-(void)setControllerType:(SLLiveContollerType)controllerType
{
    _controllerType = controllerType;
    
    NSDictionary * dict = @{};
    NSDictionary * chat = @{@"image":@"live_bottom_chat",@"type":@"0"};
    NSDictionary * beautify = @{@"image":@"live_bottom_beauty",@"type":@"1"};
//    NSDictionary * message = @{@"image":@"live_bottom_message",@"type":@"2"};
  //  NSDictionary * gift = @{@"image":@"live_bottom_gift",@"type":@"3"};
    NSDictionary * share  = @{@"image":@"live_bottom_share",@"type":@"5"};
    NSDictionary * more  = @{@"image":@"live_more_s",@"type":@"6"};
    NSDictionary * like  = @{@"image":@"live_bottom_like",@"type":@"7"};
    
    NSArray * playerArray = @[chat,dict,dict,dict,dict,share,like];
    NSArray * anchorArray = @[chat,dict,dict,dict,beautify,share,more];
    self.cellArray =(controllerType==SLLiveContollerTypeLive)?anchorArray:playerArray;
    [self.collectionView reloadData];
    
    self.volumeView.hidden = NO;
    
//    BOOL isHide = (_controllerType==SLLiveContollerTypePlayer)?YES:NO;

    self.centerBtn.hidden = (_controllerType==SLLiveContollerTypePlayer)?NO:YES;

    if (controllerType == SLLiveContollerTypeLive) {
        self.loopView.titleView.imageView.hidden = NO;
        [self.loopView.titleView.imageView addRotationAnimated];
        [self.loopView endAnimation];
    }
}


#pragma ----collectionDelegate-------

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {

    switch (indexPath.row) {
        case 0:
            return CGSizeMake(kCellWidth42, 30);
            
        case 1:  {
            // 左右边距 + 第一个cell的边距 + cell * margin
            CGFloat w = UIScreen.mainScreen.bounds.size.width - kLRMargin * 2 - kCellWidth42 - kCellMargin * 6;
            if (_controllerType == SLLiveContollerTypePlayer)
            {
                w = w - kCellWidth60 * 2 - kCellWidth30 * 3;
                return  CGSizeMake(w<0?0:w, 30);
            } else {
                w = w -kCellWidth30 * 4 - kCellWidth60;
                return  CGSizeMake(w<0?0:w, 30);
            }
        }
            
        case 5:
            return CGSizeMake(kCellWidth60, 30);
            
        case 6:
        {
            if (_controllerType == SLLiveContollerTypePlayer)
            {
                return  CGSizeMake(kCellWidth60, 30);
            }
        }
            
        default:
            break;
    }
    return CGSizeMake(30, 30);
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
    if (!cell) {
        cell = (SLLiveBottomCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    }
    
    if (self.controllerType==SLLiveContollerTypePlayer && indexPath.row==6) {
        SLBottomLikeCollectionViewCell * likeCell;
        if (!likeCell) {
            likeCell = (SLBottomLikeCollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:likeCellID forIndexPath:indexPath];
        }
        //cell.backgroundColor = [self arc4randomColor];
        return likeCell;
    }
    
    cell.type = SLLiveBottomViewCellTypeOnlyImage;
    //cell.backgroundColor = [self arc4randomColor];
    
    switch (indexPath.row) {
            case 0:
        {
            cell.type = SLLiveBottomViewCellTypeInput;
        }
            break;
            
        case 5:
        {
            cell.type = SLLiveBottomViewCellTypeText;
        }
            break;
            
        case 6:
        {
            if(_controllerType == SLLiveContollerTypePlayer){
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

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
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
    return UIEdgeInsetsMake(6, kLRMargin, 9, kLRMargin);
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath;
{
    return YES;
}

- (void)updateShareCount:(NSInteger)shareCount
{
    NSLog(@"[gx] update sharecount %ld",(long)shareCount);
    NSInteger  row = 5;
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:0];
    SLLiveBottomCollectionViewCell * cell  = (SLLiveBottomCollectionViewCell * )[self.collectionView cellForItemAtIndexPath:indexPath];
    [cell updateCount:shareCount];
}

- (void)updateLikeCount:(NSInteger)likeCount
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:6 inSection:0];
    SLBottomLikeCollectionViewCell * likeCell  = (SLBottomLikeCollectionViewCell * )[self.collectionView cellForItemAtIndexPath:indexPath];
    [likeCell updateCount:likeCount];
}

- (void)setLikeCellSelect
{
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:6 inSection:0];
    SLBottomLikeCollectionViewCell * likeCell  = (SLBottomLikeCollectionViewCell * )[self.collectionView cellForItemAtIndexPath:indexPath];
    [likeCell setSelected:YES];
    
}

- (UIButton *)centerBtn {
    if(!_centerBtn){
        _centerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_centerBtn setImage:[UIImage imageNamed:@"live_animation"] forState:UIControlStateNormal];
        _centerBtn.layer.shadowRadius = .5f;
        _centerBtn.layer.shadowOpacity = 0.5;
        _centerBtn.layer.shadowColor = RGBACOLOR(46, 46, 46, .4).CGColor;
        _centerBtn.layer.shadowOffset = CGSizeMake(.5, .5);
        _centerBtn.layer.masksToBounds = NO;
        @weakify(self);
        [[_centerBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self);
            if (self.protocol&&[self.protocol respondsToSelector:@selector(selectBottomViewAtIndex:)]) {
                [self.protocol selectBottomViewAtIndex:3];
            }
        }];
    }
    return _centerBtn;
}

- (void)startBottomAnimation {
    [self.loopView beginAnimation];
}

- (void)endBottomAnimation {
    [self.loopView endAnimation];
}

@end


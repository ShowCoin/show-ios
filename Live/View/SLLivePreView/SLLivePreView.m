//
//  SLLivePreView.m
//  ShowLive
//
//  Created by gongxin on 2018/4/12.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "SLLivePreView.h"
#import "SLPushManager.h"
#import "SLShareViewCollectionViewCell.h"
#import "UITextField+Category.h"
#import "SLLiveStartAction.h"
#import "SLLiveStatusAction.h"
#import "SLLiveStatusModel.h"
#import "SLLiveStopAction.h"
#import "SLLocationManager.h"
@interface SLLivePreView ()<UICollectionViewDelegate,UICollectionViewDataSource,UITextFieldDelegate>

@property (nonatomic,strong) UIButton *locationButton;
@property (nonatomic,strong) UIButton *beautyButton;
@property (nonatomic,strong) UIButton *cameraButton;
@property (nonatomic,strong) UIButton *closeButton;
@property (nonatomic,strong) UIButton *startLiveButton;
@property (nonatomic,strong) UITextField * themeTextFiled;
@property (nonatomic,strong) UICollectionView * collectionView;
@property (nonatomic,strong) UIView *containerView;
@property (nonatomic,strong) NSMutableArray * dataArray;

//是否展示地理位置
@property BOOL showLocation;


@end
@implementation SLLivePreView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];

        [self addSubview:self.containerView];
        [self.containerView addSubview:self.locationButton];
        [self.containerView addSubview:self.closeButton];
        [self.containerView addSubview:self.cameraButton];
        [self.containerView addSubview:self.beautyButton];
        [self.containerView addSubview:self.themeTextFiled];
        [self.containerView addSubview:self.startLiveButton];
        [self addNotification];

    }
    return self;
}

-(void)addNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(continueLive:) name:SL_Live_Continue object:nil];
}

-(void)removeNotification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
-(void)bringContainerViewToFront
{
    [self bringSubviewToFront:self.containerView];
}

-(void)continueLive:(NSNotification *)ntfi {
    if (!ntfi.object) return;

    SLLiveStatusModel *model = (SLLiveStatusModel*)ntfi.object;
    SLLiveStartModel * startModel = [[SLLiveStartModel alloc]init];
    startModel.rtmp = model.rtmp;
    startModel.cdnType = model.cdnType;
    startModel.share_addr = model.share_addr;
    startModel.liveId = model.liveId;
    startModel.streamName = model.streamName;
    startModel.roomId = model.roomId;

    [self.containerView removeFromSuperview];
    
    
    if (self.delegate&&[self.delegate respondsToSelector:@selector(startLive:)]) {
        [self.delegate startLive:self.themeTextFiled.text];
    }
    
    if (self.delegate&&[self.delegate respondsToSelector:@selector(startLiveSussces:)]) {
        [self.delegate startLiveSussces:startModel];
    }
    
}
#pragma mark -- Event
-(void)startLiveButtonClick:(UIButton*)sender
{
    [self.containerView removeFromSuperview];
    
    if (self.delegate&&[self.delegate respondsToSelector:@selector(startLive:)]) {
        [self.delegate startLive:self.themeTextFiled.text];
    }
    
    [self startInit];
}

-(void)startInit
{
    SLLiveStartAction * action = [SLLiveStartAction action];
    action.title = self.themeTextFiled.text;
    action.pos = _showLocation?@"1":@"0";
    action.topic = @"";
    action.modelClass =SLLiveStartModel.self;
    @weakify(self);
    [self sl_startRequestAction:action Sucess:^(SLLiveStartModel *model) {
        @strongify(self);
        if (self.delegate&&[self.delegate respondsToSelector:@selector(startLiveSussces:)]) {
            [self.delegate startLiveSussces:model];
        }
        
    } FaildBlock:^(NSError *error) {
          @strongify(self);
         [self liveInitFail];
    }];
}

-(void)liveInitFail
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"直播失败，请过一会儿再试！" preferredStyle:UIAlertControllerStyleAlert];
    @weakify(self);
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
         @strongify(self);
        [self closeButtonClick:nil];
    }];

    [alertController addAction:cancelAction];
    [[PageManager  getCurrentViewController] presentViewController:alertController animated:YES completion:nil];
}


-(void)closeButtonClick:(UIButton*)sender
{
    if(self.delegate && [self.delegate respondsToSelector:@selector(closeLive)])
    {
        [self.delegate closeLive];
    }
}

-(void)cameraButtonClick:(UIButton*)sender
{
    [[SLPushManager shareInstance] switchCamera];
}

-(void)beautyButtonClick:(UIButton*)sender
{
    if ([[SLPushManager shareInstance] beautifyOpen]) {
        [[SLPushManager shareInstance] clearBeautify];
    }else
    {
        [[SLPushManager shareInstance] startBeautify];
    }
}

-(void)locationButtonClick:(UIButton*)sender
{
    
    if (IsStrEmpty([AccountModel shared].city)) {
        [[SLLocationManager shareManager] startLocation];
    }
    else
    {
        // 显示地理位置
        if (_showLocation) {
            _showLocation = NO;
            [self.locationButton setTitle:@"" forState:UIControlStateNormal];
        }
        else  // 不显示地理位置
        {
            _showLocation = YES;
            [self.locationButton setTitle:[AccountModel shared].city forState:UIControlStateNormal];
        }
    }
}

#pragma mark touches
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.themeTextFiled resignFirstResponder];
    [self endEditing:YES];
}
#pragma mark textField delegate
-(void)themeTextChange
{
    NSString * toBeString = self.themeTextFiled.text;
    NSString * lang = [[UIApplication sharedApplication]textInputMode].primaryLanguage;
    if ([lang isEqualToString:@"zh-Hans"]) {
        UITextRange * selectedRange = [self.themeTextFiled markedTextRange];
        UITextPosition * position = [self.themeTextFiled positionFromPosition:selectedRange.start offset:0];
        if (!position)
        {
            if (toBeString.length > 20)
            {
                NSRange range ={0,20};
                self.themeTextFiled.text = [toBeString substringWithRange:range];
            }
            
        }
        
    }
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.themeTextFiled resignFirstResponder];
    return YES;
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
    NSLog(@"[gx] 分享成功后在推流");
}


#pragma mark -- Getter Setter


- (UIView *)containerView {
    if (!_containerView) {
        _containerView = [UIView new];
        _containerView.frame = self.bounds;
        _containerView.backgroundColor = [UIColor clearColor];
        _containerView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    }
    return _containerView;
}

-(UIButton*)locationButton
{
    if (!_locationButton) {
        _locationButton=[[UIButton alloc]initWithFrame:CGRectMake(15, 17+KNaviBarSafeBottomMargin, 180, 40)];
        _locationButton.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
        
        if ([AccountModel shared].city.length) {
            [_locationButton setTitle:[AccountModel shared].city forState:UIControlStateNormal];
    
        }else
        {
            [_locationButton setTitle:@"" forState:UIControlStateNormal];
         
            
        }
        [_locationButton setImage:[UIImage imageNamed:@"live_location"] forState:UIControlStateNormal];
        [_locationButton addTarget:self action:@selector(locationButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        _locationButton.imageView.size = CGSizeMake(11, 14);
        _locationButton.titleLabel.font=[UIFont systemFontOfSize:15];
        [_locationButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    return _locationButton;
}


-(UIButton*)cameraButton
{
    if (!_cameraButton) {
        _cameraButton=[[UIButton alloc]initWithFrame:CGRectMake(KScreenWidth/2-20, 17+KNaviBarSafeBottomMargin,40, 40)];
        [_cameraButton setImage:[UIImage imageNamed:@"live_camera_button"] forState:UIControlStateNormal];
        [_cameraButton addTarget:self action:@selector(cameraButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cameraButton;
}

-(UIButton*)closeButton
{
    if (!_closeButton) {
        _closeButton=[[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth-50, 17+KNaviBarSafeBottomMargin, 40, 40)];
        [_closeButton setImage:[UIImage imageNamed:@"live_back_button"] forState:UIControlStateNormal];
        [_closeButton addTarget:self action:@selector(closeButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeButton;
}

-(UITextField*)themeTextFiled
{
    if (!_themeTextFiled) {
        //输入标题框
        _themeTextFiled=[[UITextField alloc]initWithFrame:CGRectMake(25,200+KNaviBarSafeBottomMargin, kScreenWidth-50 , 42)];
        [_themeTextFiled setPlaceholder:@"这次要分享什么" withFont:[UIFont systemFontOfSize:22] color:[UIColor whiteColor]];
        _themeTextFiled.clearButtonMode = UITextFieldViewModeWhileEditing;
        _themeTextFiled.textColor=[UIColor whiteColor];
        _themeTextFiled.font=[UIFont systemFontOfSize:18];
        _themeTextFiled.delegate=self;
        _themeTextFiled.textAlignment=NSTextAlignmentCenter;
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

-(UIButton*)startLiveButton
{
    if (!_startLiveButton) {
        //开始按钮
        _startLiveButton=[UIButton buttonWithType:UIButtonTypeCustom];
        _startLiveButton.frame= CGRectMake(KScreenWidth/2-50,KScreenHeight/2+52+70,100,100);
        [_startLiveButton setBackgroundColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _startLiveButton.layer.cornerRadius=_startLiveButton.width/2;
        _startLiveButton.layer.masksToBounds = YES;
        [_startLiveButton setTitle:@"开启直播" forState:UIControlStateNormal];
        [_startLiveButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _startLiveButton.titleLabel.font=[UIFont systemFontOfSize:17];
        _startLiveButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_startLiveButton addTarget:self action:@selector(startLiveButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _startLiveButton;
}

-(UIButton*)beautyButton
{
    if (!_beautyButton) {
        _beautyButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _beautyButton.frame = CGRectMake(KScreenWidth-100, KScreenHeight/2+52+70+20, 60, 60);
        [_beautyButton setImage:[UIImage imageNamed:@"live_beauty_button"] forState:UIControlStateNormal];
        [_beautyButton addTarget:self action:@selector(beautyButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _beautyButton;
}


-(NSMutableArray*)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)dealloc{
    NSLog(@"[gx] live preview dealloc");
}

@end

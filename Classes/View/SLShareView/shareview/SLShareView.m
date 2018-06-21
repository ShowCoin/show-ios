//
//  SLShareView.m
//  ShowLive
//
//  Created by show gx on 2018/4/11.
//  Copyright © 2018年 vning. All rights reserved.
//


#import "SLShareView.h"
#import "SLLiveShareCollectionViewCell.h"
#import "SLShareCollectionReusableView.h"

@interface SLShareView()<UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic,strong)UICollectionView * collectionView;
@property(nonatomic,strong)NSArray * dataArray;
@property(nonatomic,strong)UIButton * closeButton;

@end

@implementation SLShareView

+ (instancetype)shared {
    static SLShareView *_shareView = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shareView = [[self alloc] initWithSuperView:UIApplication.sharedApplication.keyWindow.rootViewController.view
                                     animationTravel:0.3
                                          viewHeight:196+KTabbarSafeBottomMargin];
    });
    return _shareView;
}

- (void)dealloc
{
    NSLog(@" dealloc shareview");
}
// 初始化子视图
- (void)initView
{
    [super initView];
    [self addEffect:UIBlurEffectStyleDark];
    [self addSubview:self.collectionView];
    [self addSubview:self.closeButton];
}

- (void)modalViewDidAppare
{
    [super modalViewDidAppare];
     [self initData];
}

- (void)modalViewWillDisappare
{
    [super modalViewWillDisappare];

}
-(void)setShareType:(SLShareType)sType andInfo:(NSString*)info andUID:(NSString *)uid{
    shareInfo=info;
    shareType=sType;
    NSString* extInfo=@"";
    switch (shareType) {
        case SLShareType_Live:
            _uid = uid;
            extInfo=[NSString stringWithFormat:@"share.do?roomid=%@",info];
            break;
        case SLShareType_User:
            _uid = info;
            extInfo=[NSString stringWithFormat:@"share.do?uid=%@",info];
            break;
        default:
            break;
    }
    if ([[self.share_add substringFromIndex:[self.share_add length]-1] isEqualToString:@"/"]) {
        _shareUrl=[NSString stringWithFormat:@"%@%@&id=%@",self.share_add,extInfo,AccountUserInfoModel.uid];
    }else{
        _shareUrl=[NSString stringWithFormat:@"%@/%@&id=%@",self.share_add,extInfo,AccountUserInfoModel.uid];
    }
}

-(void)initData
{
    self.dataArray = @[@{@"image":@"friendShare",@"title":@"朋友圈"},@{@"image":@"wechatShare",@"title":@"微信"},@{@"image":@"Share_qq_icon",@"title":@"QQ"},@{@"image":@"Share_qqRoom_icon",@"title":@"QQ空间"},@{@"image":@"weiboShare",@"title":@"微博"},@{@"image":@"copyUrl",@"title":@"复制链接"}];
    [self.collectionView reloadData];
    
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{

    return (CGSize){kScreenWidth,38};
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{

    if([kind isEqualToString:UICollectionElementKindSectionHeader])
    {
        SLShareCollectionReusableView *headerView = [_collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"SLShareCollectionReusableView" forIndexPath:indexPath];
        if(headerView == nil)
        {
            headerView = [[SLShareCollectionReusableView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, 38)];
        }
        
        return headerView;
    }
   
    return nil;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    //上左下右
    CGFloat spacing =  (kScreenWidth-45*6)/7;
    return UIEdgeInsetsMake(18,spacing,13,spacing);
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.dataArray count];
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    SLLiveShareCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SLLiveShareCollectionViewCell" forIndexPath:indexPath];

    cell.dict = self.dataArray[indexPath.row];
    cell.platformLabel.textColor = [UIColor whiteColor];
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
            [self friendClick];
            break;
        case 1:
            [self wechatClick];
            break;
        case 2:
            [self qqClick];
            break;
        case 3:
            [self qqRoomClick];
            break;
        case 4:
            [self shareToWeiboSession];
            break;
        case 5:
            
            break;
        default:
            break;
    }
}



#pragma mark - Getters and Setters

-(UICollectionView*)collectionView
{
    if (!_collectionView) {
        //普通集合视图布局
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        CGFloat spacing =  (kScreenWidth-45*6)/7;
        layout.minimumLineSpacing = spacing;
        layout.minimumInteritemSpacing = spacing;
        layout.itemSize = CGSizeMake(45, 70);

        CGFloat height = 151;
        CGRect rect = CGRectMake(0, 0,KScreenWidth,height);
        _collectionView =[[UICollectionView alloc]initWithFrame:rect collectionViewLayout:layout];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];
        [_collectionView registerClass:[SLLiveShareCollectionViewCell class] forCellWithReuseIdentifier:@"SLLiveShareCollectionViewCell"];
        [_collectionView registerClass:[SLShareCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"SLShareCollectionReusableView"];
    }
    return _collectionView;
}

-(UIButton*)closeButton
{
    if (!_closeButton) {
        _closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _closeButton.frame = CGRectMake(0,151, KScreenWidth, 45+KTabbarSafeBottomMargin);
        [_closeButton setTitle:@"取消" forState:UIControlStateNormal];
        [_closeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _closeButton.titleLabel.font = [UIFont systemFontOfSize:18];
        [_closeButton addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchUpInside];
        _closeButton.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2];
        _closeButton.titleEdgeInsets = UIEdgeInsetsMake(-KTabbarSafeBottomMargin, 0, 0, 0);
    }
    return _closeButton;
}
#pragma mark -shareClick
-(void)friendClick
{
    
    //分享的图片
    UIImage * shareImage = _userHeader ? _userHeader : [UIImage imageNamed:@"shareimage"];
    NSString *shareUrl = [NSString stringWithFormat:@"%@&channel=weixin",self.shareUrl];
    
    __weak typeof(self) weaks = self;
    [SLShareUtils shareVideo:shareUrl shareUserName:self.userName thumbImage:shareImage platform:UMSocialPlatformType_WechatTimeLine currentController:nil completion:^(id result, NSError *error) {
        if (!error) {
            [weaks hide];
            [weaks requestShareSuccessActionByWork:@"weixin"];
        }
    } isOffical:NO];
}

-(void)wechatClick
{
    //分享的图片
    UIImage * shareImage = _userHeader? _userHeader:[UIImage imageNamed:@"shareimage"];
    //分享的链接
    NSString *shareUrl =[NSString stringWithFormat:@"%@&channel=weixin",self.shareUrl];
    
    __weak typeof(self) weaks = self;
    [SLShareUtils shareVideo:shareUrl shareUserName:self.userName thumbImage:shareImage platform:UMSocialPlatformType_WechatSession currentController:nil completion:^(id result, NSError *error) {
        if (!error) {
            [weaks hide];
            [weaks requestShareSuccessActionByWork:@"weixin"];
        }
    } isOffical:NO];
    
}
-(void)shareToWeiboSession
{
    
    //分享的图片
    UIImage * shareImage =_userHeader?_userHeader: [UIImage imageNamed:@"shareimage"];
    //分享的链接
    NSString *shareUrl = [NSString stringWithFormat:@"%@&channel=weibo",self.shareUrl];
    
    __weak typeof(self) weaks = self;
    [SLShareUtils shareImage:shareImage contentUrl:shareUrl shareUserName:self.userName platform:UMSocialPlatformType_Sina currentController:nil completion:^(id result, NSError *error) {
        if (!error) {
            [weaks hide];
            [weaks requestShareSuccessActionByWork:@"weibo"];
        }
    } isOffical:NO];
}

-(void)qqClick {
    //分享的图片
    UIImage * shareImage =_userHeader?_userHeader: [UIImage imageNamed:@"shareimage"];
    //分享的链接
    NSString *shareUrl =[NSString stringWithFormat:@"%@&channel=qq",self.shareUrl];
    
    __weak typeof(self) weaks = self;
    [SLShareUtils shareVideo:shareUrl shareUserName:self.userName thumbImage:shareImage platform:UMSocialPlatformType_QQ currentController:nil completion:^(id result, NSError *error) {
        if (!error) {
            [weaks hide];
            [weaks requestShareSuccessActionByWork:@"qq"];
        }
    } isOffical:NO];
}

-(void)qqRoomClick {
    
    //分享的图片
    UIImage * shareImage =_userHeader?_userHeader: [UIImage imageNamed:@"shareimage"];
    //分享的链接
    NSString *shareUrl = [NSString stringWithFormat:@"%@&channel=qzone",self.shareUrl];
    
    __weak typeof(self) weaks = self;
    [SLShareUtils shareVideo:shareUrl shareUserName:self.userName thumbImage:shareImage platform:UMSocialPlatformType_Qzone currentController:nil completion:^(id result, NSError *error) {
        if (!error) {
            [weaks hide];
            [weaks requestShareSuccessActionByWork:@"qzone"];
        }
    } isOffical:NO];
}

- (void)requestShareSuccessActionByWork:(NSString *)channel{
    if (self.shareSuccessAction) {
        [self.shareSuccessAction cancel];
        self.shareSuccessAction = nil;
    }
    SLShareSuccessAction *action = [SLShareSuccessAction action];
    action.roomId = shareInfo;
    action.channel = channel;
    
    
    @weakify(self)
    action.finishedBlock = ^(id result) {
        @strongify(self)
        if ([result valueForKey:@"shared"]) {
//            AccountUserInfoModel.shared = [[result valueForKey:@"shared"] boolValue];
        }
        if (self.shareSuccessBlock) {
            self.shareSuccessBlock();
        }
    };
    [action start];
    self.shareSuccessAction = action;
}

@end

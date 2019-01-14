//
//  SLHeadPortrait.m
//  ShowLive
//
//  Created by iori_chou on 2018/4/10.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "SLHeadPortrait.h"
#import "NSString+Validation.h"
@interface SLHeadPortrait()<UICollectionViewDelegate,UICollectionViewDataSource>

@end
@implementation SLHeadPortrait

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        vipWidth = self.size.width *0.45;
        vipHeight = self.size.height * 0.7;
        
        vipLeft  =self.size.width*0.55;
        
        vipTop  =self.size.width*0.3;
        
        
        [self addloadView];
    }
    return self;
}
- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code
        
        self.backgroundColor = [UIColor clearColor];
        vipWidth = self.size.width *0.45;
        vipHeight = self.size.height * 0.7;
        vipLeft  =self.size.width*0.55;
        vipTop  =self.size.width*0.3;
        [self addloadView];
    }
    return self;
}
//重置frame方法
-(void)setSelfFrame:(CGRect)selfFrame
{
    CGRect frame = CGRectMake(selfFrame.origin.x, selfFrame.origin.y, selfFrame.size.width, selfFrame.size.height);
    aFrame = selfFrame;
    _imageView.frame = CGRectMake(0, 0, selfFrame.size.width, selfFrame.size.height);
    self.frame = frame ;
    vipWidth = self.size.width *0.45;
    vipHeight = self.size.height * 0.7;
    vipLeft  =self.size.width*0.55;
    vipTop  =self.size.width*0.3;
    [self addloadView];
}

-(void)addloadView
{
    CGRect frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
    aFrame = self.frame;
    
    if (!_imageView) {
        self.imageView = [[UIImageView alloc]init];
    
    }
    //设置图片剧中显示
    [_imageView setImageClipsToBounds];
    
    //添加认证图标
    if (!_imageV) {
        _imageV = [[UIImageView alloc]init];
        _imageV.image = [UIImage imageNamed:@"认证图标"];
        _imageV.contentMode = UIViewContentModeScaleAspectFit;
        _imageV.hidden = YES;
        [self addSubview:_imageV];
    }
    if (!_vipIcon) {
        _vipIcon = [[UIImageView alloc]init];
        
    }
    self.frame = frame ;
    
    //添加点击方法
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headPortraitClick)]];
}
- (void)setRoundStyle:(BOOL)roundStyle image:(UIImage *)image;
{
    [_imageView setImage:image];
    
    if (roundStyle)
        [_imageView roundStyle];
    else
        [_imageView cornerRadiusStyle];
}


- (void)setRoundStyle:(BOOL)roundStyle imageUrl:(NSString *)imageUrl imageHeight:(float)imageheight vip:(BOOL)vip attestation:(BOOL)attestation{
    
    if([imageUrl isKindOfClass:[NSNull class]]){
        imageUrl = nil ;
    }
        @weakify(self)
    [_imageView yy_setImageWithURL:[NSURL URLWithString:imageUrl] placeholder:[UIImage imageNamed:@"默认头像"] options:YYWebImageOptionAvoidSetImage completion:^(UIImage * _Nullable image, NSURL * _Nonnull url, YYWebImageFromType from, YYWebImageStage stage, NSError * _Nullable error) {
        @strongify(self)
        if (self &&[self isKindOfClass:[SLHeadPortrait class]]&& self.imageView&&image) {
                [self.imageView setImage:image];
        }
    }];
    if (roundStyle)
    {
        [self layerWithView:_imageView withColor:kGrayBGColor width:1];
    }
    
    if (imageheight==64) {
        [self layerWithView:_imageView withColor:RGBCOLOR(139, 96, 236) width:6];
    }else if (imageheight==75||imageheight==84) {
        [self layerWithView:_imageView withColor:kThemeWhiteColor width:aFrame.size.width * 0.046];
    }
    else if (imageheight==28) {
        [self layerWithView:_imageView withColor:ClearColor width:aFrame.size.width * 0.046];
        if (vip) {
            _imageV.image = [UIImage imageNamed:@"account_TR_error"];
        }
        else{
            _imageV.image = attestation?[UIImage imageNamed:@"account_TR_in"]:[UIImage imageNamed:@"account_TR_out"];
        }
    }else if (imageheight == 90){
        [self layerWithView:_imageView withColor:ClearColor width:6];

    }else if (imageheight == 100){
        [self layerWithView:_imageView withColor:kBlackWith27 width:6];
    }else if (imageheight == 101){
        [self layerWithView:_imageView withColor:ClearColor width:aFrame.size.width * 0.046];
        _imageV.hidden = YES;
    }else if(imageheight == 50) //直播间主播头像
    {
        [self layerWithView:_imageView withColor:[Color(@"ffffff") colorWithAlphaComponent:0.3] width:2];
    }else if(imageheight == 35) //直播间右侧成员列表
    {
        [self layerWithView:_imageView withColor:[Color(@"ffffff") colorWithAlphaComponent:0.3] width:1];
    }else if(imageheight == 34)//订单列表
    {
        [self layerWithView:_imageView withColor:[[UIColor whiteColor] colorWithAlphaComponent:0.3] width:2];

    }
        
    
    
    
    //添加认证图标
    float width = aFrame.size.width *0.76;
    float height = aFrame.size.height * 0.635;
    _imageV.hidden=vip?YES:NO;
    _vipIcon.hidden=vip?NO:YES;
    _imageV.frame = CGRectMake(width, height, aFrame.size.width*.3f,  aFrame.size.width*.3f);
    _vipIcon.frame =imageheight==95?CGRectMake(width,height, aFrame.size.width*.49f,aFrame.size.width*.25f): CGRectMake(width-aFrame.size.width*.4f,height-aFrame.size.width*.1f, aFrame.size.width*.75f,aFrame.size.width*.38f);
    _vipIcon.image = [UIImage imageNamed:@"vipIcon"];

    if (imageheight==10) {
        _imageV.hidden  = YES;
        _vipIcon.hidden = YES;
    }

}
- (void)setRoundStyle:(BOOL)roundStyle imageUrl:(NSString *)imageUrl holdImg:(UIImage *)holdImg imageHeight:(float)imageheight vip:(BOOL)vip attestation:(BOOL)attestation{
    
    if([imageUrl isKindOfClass:[NSNull class]]){
        imageUrl = nil ;
    }
    @weakify_old(self)
    [_imageView yy_setImageWithURL:[NSURL URLWithString:imageUrl] placeholder:holdImg options:YYWebImageOptionAvoidSetImage completion:^(UIImage * _Nullable image, NSURL * _Nonnull url, YYWebImageFromType from, YYWebImageStage stage, NSError * _Nullable error) {
        @strongify_old(self)
        if (strong_self &&[strong_self isKindOfClass:[SLHeadPortrait class]]&& strong_self.imageView&&image) {
            [strong_self.imageView setImage:image];
        }
    }];
    if (roundStyle)
    {
        [self layerWithView:_imageView withColor:kGrayBGColor width:1];
    }
    
    if (imageheight==64) {
        [self layerWithView:_imageView withColor:RGBCOLOR(139, 96, 236) width:6];
    }else if (imageheight==75||imageheight==84) {
        [self layerWithView:_imageView withColor:kThemeWhiteColor width:aFrame.size.width * 0.046];
    }
    else if (imageheight==28) {
        [self layerWithView:_imageView withColor:ClearColor width:aFrame.size.width * 0.046];
        if (vip) {
            _imageV.image = [UIImage imageNamed:@"account_TR_error"];
        }
        else{
            _imageV.image = attestation?[UIImage imageNamed:@"account_TR_in"]:[UIImage imageNamed:@"account_TR_out"];
        }
    }else if (imageheight == 90){
        [self layerWithView:_imageView withColor:ClearColor width:6];
        
    }else if (imageheight == 100){
        [self layerWithView:_imageView withColor:kThemeWhiteColor width:6];
    }else if (imageheight == 101){
        [self layerWithView:_imageView withColor:ClearColor width:aFrame.size.width * 0.046];
        _imageV.hidden = YES;
    }else if (imageheight == 95){
        if (roundStyle)
        {
            [self layerWithView:_imageView withColor:HexRGBAlpha(0xffffff, 0.1) width:2];
        }
    }
    //添加认证图标
    float width = aFrame.size.width *0.76;
    float height = aFrame.size.height * 0.635;
    _imageV.hidden=vip?YES:NO;
    _vipIcon.hidden=vip?NO:YES;
    _imageV.frame = CGRectMake(width, height, aFrame.size.width*.3f,  aFrame.size.width*.3f);
    _vipIcon.frame =imageheight==95?CGRectMake(width,height, aFrame.size.width*.49f,aFrame.size.width*.25f): CGRectMake(width-aFrame.size.width*.4f,height-aFrame.size.width*.1f, aFrame.size.width*.75f,aFrame.size.width*.38f);
    _vipIcon.image = [UIImage imageNamed:@"vipIcon"];
    
    if (imageheight==10) {
        _imageV.hidden  = YES;
        _vipIcon.hidden = YES;
    }
    
}

//添加点击方法
-(void)headPortraitClick
{
    if (_delegate &&[_delegate respondsToSelector:@selector(headPortraitClickAuthor)]){
        [_delegate headPortraitClickAuthor];
    }
    if (_delegate &&[_delegate respondsToSelector:@selector(headPortraitClickAuthor:)]) {
        [_delegate headPortraitClickAuthor:self];

    }
}
-(void)layerWithView:(UIImageView *)imageview withColor:(UIColor *)color width:(CGFloat)width
{
    if(!self.maskLayer){
        self.maskLayer = [CAShapeLayer layer];
    }
    if (!self.borderLayer) {
        self.borderLayer = [CAShapeLayer layer];
    }
    self.maskLayer.frame = CGRectMake(0, 0, imageview.width, imageview.height);
    self.borderLayer.frame = CGRectMake(0, 0, imageview.width, imageview.height);
    self.borderLayer.lineWidth = width;
    self.borderLayer.strokeColor = color.CGColor;
    self.borderLayer.fillColor = [UIColor clearColor].CGColor;
    self.bezierPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, imageview.width, imageview.height) cornerRadius:imageview.height];
    self.maskLayer.path = self.bezierPath.CGPath;
    self.borderLayer.path = self.bezierPath.CGPath;
    [imageview.layer insertSublayer:self.borderLayer atIndex:0];
    [imageview.layer setMask:self. maskLayer];
    
}

-(void)removeTap
{
    for (UITapGestureRecognizer * tap in [self gestureRecognizers]) {
        [self removeGestureRecognizer:tap];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

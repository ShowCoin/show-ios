//
//  ShowNoDataView.m
//  ShowLive
//
//  Created by Mac on 2018/3/21.
//  Copyright © 2018年 VNing. All rights reserved.
//

#import "ShowNoDataView.h"

@interface ShowNoDataView (){
    
    UILabel            *dataLabel;
    UILabel            *tagsTitleLabel;
    UIView             *contentView;
    UIImageView        *loaderrImageView;
    DWTagList          *_tagList;
    UIButton           *GoChooseBtn;
    NODataType         _noDataType;
    BOOL               includAgeTag;
    NSString            *_minAge;
    NSString            *_maxAge;
    __weak UIViewController                   *_viewController;
    
}


@end

@implementation ShowNoDataView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self initNodataView];
        
    }
    return self;
}

-(void)initNodataView

{
    loaderrImageView = [[UIImageView alloc]init];
    loaderrImageView.frame = CGRectMake(kMainScreenWidth/2-57*Proportion375, 176*Proportion375, 113*Proportion375, 113*Proportion375);
    loaderrImageView.backgroundColor = [UIColor clearColor];
    loaderrImageView.image = [UIImage imageNamed:@"tag_nodata"];
    [self addSubview:loaderrImageView];
    
    dataLabel = [[UILabel alloc]init];
    dataLabel.frame = CGRectMake(10, loaderrImageView.bottom + 10*Proportion375, kMainScreenWidth-20, 15 *Proportion375);
    dataLabel.font = [UIFont systemFontOfSize:15*Proportion375];
    dataLabel.textColor = kTextGrayColor;
    dataLabel.textAlignment = NSTextAlignmentCenter;
    
    [self addSubview:dataLabel];
    
    tagsTitleLabel = [[UILabel alloc]init];
    tagsTitleLabel.frame = CGRectMake(10,126*Proportion375 - 64, kMainScreenWidth-20, 16 *Proportion375);
    tagsTitleLabel.font = [UIFont systemFontOfSize:16*Proportion375];
    tagsTitleLabel.textColor = kTextGrayColor;
    tagsTitleLabel.text = @"看看更多感兴趣的标签";
    tagsTitleLabel.hidden = YES;
    tagsTitleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:tagsTitleLabel];
    
    _tagList = [[DWTagList alloc] initWithFrame:CGRectMake(20*Proportion375, tagsTitleLabel.bottom + 25*Proportion375,kMainScreenWidth -  50 * Proportion375, 300)];
    [_tagList setLabelBackgroundColor:[UIColor whiteColor] withType:3];
    _tagList.delegate = self;
    [self addSubview:_tagList];
    
    
    GoChooseBtn = [[UIButton alloc]initWithFrame:CGRectMake((kMainScreenWidth - 187*Proportion375)/2, dataLabel.bottom + 35*Proportion375, 187*Proportion375, 45*Proportion375)];
    GoChooseBtn.titleLabel.font = [UIFont systemFontOfSize:14*Proportion375];
    [GoChooseBtn setBackgroundImage:[UIImage imageNamed:@"home_red"] forState:UIControlStateNormal];
    [GoChooseBtn setTitle:@"去看看精彩推荐" forState:UIControlStateNormal];
    [GoChooseBtn setHidden:YES];
    [GoChooseBtn addTarget:self action:@selector(goChooseBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:GoChooseBtn];
}

-(void)showNoDataView:(UIView*)superView noDataType:(NODataType)type
{
    if (!self.superview) {
        self.frame = superView.bounds;
        [superView addSubview:self];
    }
    [self setNoDataType:type];
}

-(void)showNoDataView:(UIView*)superView noDataString:(NSString *)noDataString
{
    if (!self.superview) {
        self.frame = superView.bounds;
        [superView addSubview:self];
    }
    
    dataLabel.text =  [ShowHelper isBlankString:noDataString] ? @"暂无数据" : noDataString;
    if ([noDataString isEqualToString:@"好尴尬，冷到没有评论"]) {
        dataLabel.textColor = HexRGBAlpha(0x8C8888, 1);
    }
}
-(void)showNoDataView:(UIView*)superView noDataString:(NSString *)noDataString andGoButton:(BOOL)hide;
{
    if (!self.superview) {
        self.frame = superView.bounds;
        [superView addSubview:self];
    }
    
    dataLabel.text =  [ShowHelper isBlankString:noDataString] ? @"暂无数据" : noDataString;
    GoChooseBtn.hidden = hide;
}
-(void)showNoDataView:(UIView *)superView tagsString:(NSString *)tagsString andminAge:(NSString *)minAge maxAge:(NSString *)maxAge
{
    if (!self.superview) {
        self.frame = superView.bounds;
        [superView addSubview:self];
    }
    
    dataLabel.hidden = YES;
    loaderrImageView.hidden = YES;
    GoChooseBtn.hidden = NO;
    NSLog(@"标签：%@,年龄 小%@ 大%@",tagsString,minAge,maxAge);
    tagsTitleLabel.hidden = NO;
    NSString * tagStr = [NSString string];
    NSArray * tagsArray = [NSArray array];
    if (!IsStrEmpty(minAge) && !IsStrEmpty(maxAge)) {
        NSString * ageStr = [NSString stringWithFormat:@"%@~%@岁",minAge,maxAge];
        tagStr = [NSString stringWithFormat:@"%@,%@",ageStr,tagsString];
        includAgeTag = YES;
        _minAge = [NSString stringWithFormat:@"%@",minAge];
        _maxAge = [NSString stringWithFormat:@"%@",maxAge];
    }else{
        tagStr = [NSString stringWithFormat:@"%@",tagsString];
        includAgeTag = NO;
    }
    tagsArray =  [tagStr componentsSeparatedByString:@","];
    NSLog(@"标签：%@",tagsArray);
    [_tagList setTags:tagsArray];
    _tagList.height = [_tagList fittedSize].height;
    _tagList.centerX =kMainScreenWidth/2;
    NSLog(@"tag---size-------%f+%f",[_tagList fitSize].width,[_tagList fitSize].height);
    GoChooseBtn.top= _tagList.bottom + 25*Proportion375;
    
}
-(void)showSmileNodataView:(UIView*)superView noDataString:(NSString *)noDataString;
{
    
    if (!self.superview) {
        self.frame = superView.bounds;
        [superView addSubview:self];
    }
    
    dataLabel.text =  [ShowHelper isBlankString:noDataString] ? @"暂无数据" : noDataString;
    
    
    [self setNoDataType:kNoDataType_Smile];
}

- (void)setImage:(NSString *)imageStr {
    loaderrImageView.image = [UIImage imageNamed:imageStr];
}

-(void)setContentViewFrame:(CGRect)rect
{
    self.frame = rect;
}

-(void)setColor:(UIColor*)color
{
    self.backgroundColor = color;
    contentView.backgroundColor = color;
}

-(void)showNoDataViewController:(UIViewController *)viewController noDataType:(NODataType)type{
    if (!self.superview) {
        self.frame = viewController.view.bounds;
        [viewController.view addSubview:self];
    }
    _noDataType = type;
    _viewController = viewController;
    [self setNoDataType:type];
}



-(void)setNoDataType:(NODataType)type{
    
    switch (type) {
        case kNoDataType_Default:
            dataLabel.text = @"暂无数据";
            //[dataButton setTitle:@"随便逛逛" forState:UIControlStateNormal];
            break;
        case kNoDataType_Smile:
            loaderrImageView.image = [UIImage imageNamed:@"tag_nodata_smile"];
            break;
    }
    //    [dataButton addTarget:self action:@selector(dataAction:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)hiddenImageIcon {
    dataLabel.centerY = self.centerY;
    loaderrImageView.hidden = YES;
}

-(void)hide
{
    [self removeFromSuperview];
}


-(void)goChooseBtnClick{
    if(_delegate)
    {
        [_delegate didClickGoChooseButton];
    }
}

-(void)clickWithStr:(NSString *)str
{
    if ([str containsString:@"~"] && [str containsString:@"岁"]) {
        
        if (_delegate) {
            [_delegate didClickTagStr:nil OrminAge:_minAge maxAge:_maxAge];
        }
    }else{
        if (_delegate) {
            [_delegate didClickTagStr:str OrminAge:nil maxAge:nil];
        }
    }
}
-(void)dataAction:(id)sender{
    
    switch (_noDataType) {
            
        case kNoDataType_Default:
            break;
            
        default:
            if(_delegate && [_delegate respondsToSelector:@selector(didClickedNoDataButton)])
            {
                [_delegate didClickedNoDataButton];
            }
            break;
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

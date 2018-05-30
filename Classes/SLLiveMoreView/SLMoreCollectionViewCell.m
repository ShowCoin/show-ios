//
//  SLMoreCollectionViewCell.m
//  ShowLive
//
//  Created by gongxin on 2018/4/24.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "SLMoreCollectionViewCell.h"

@interface SLMoreCollectionViewCell ()

@property(nonatomic,strong)UIImageView * imageView;
@property(nonatomic,strong)UILabel * label;

@end

@implementation SLMoreCollectionViewCell

-(id)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
        _imageView = [[UIImageView alloc]init];
        
        _label =  [[UILabel alloc]init];
        _label.textColor = [UIColor whiteColor];
        _label.font = [UIFont systemFontOfSize:14];
        _label.textAlignment = NSTextAlignmentCenter;
        
        [self.contentView addSubview:self.imageView];
        [self.contentView addSubview:self.label];
    }
    return self;
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat w = self.frame.size.width;
    CGFloat h = self.frame.size.height;
    CGFloat imageWH = 59;
    CGFloat labelH = self.label.font.lineHeight;
    CGFloat kMargin = (h - imageWH - labelH) / 3;
    CGFloat imageX = (w - imageWH) / 2;
    self.imageView.frame = CGRectMake(imageX, kMargin, imageWH, imageWH);
    CGFloat labelY = CGRectGetMaxY(self.imageView.frame) + kMargin - 2;
    self.label.frame = CGRectMake(0, labelY, w, labelH);
}

- (void)setModel:(SLLMModel *)model
{
    _model = model;
    if (model.select == NO) {
        [self.imageView setImage:[UIImage imageNamed:model.image]];
        self.label.text = model.title;
    } else {
        [self.imageView setImage:[UIImage imageNamed:model.selectImage]];
        self.label.text = model.selectTitle;
    }
    
}

@end

@implementation SLLMModel

+ (instancetype)initWithTitle:(NSString *)t image:(NSString *)i {
    SLLMModel *model = [[self alloc] init];
    model.title = t;
    model.image = i;
    return model;
}

+ (instancetype)sl_create:(SLLMType)type {
    SLLMModel *model = [[self alloc] init];
    model.type = type;
    model.select = NO;
    switch (type) {
        case SLLMTypeMessage:
            model.title = @"私信";
            model.image = @"live_more_message";
            break;
            
        case SLLMTypeFront:
            model.title = @"后置";
            model.image = @"live_more_carema";
            model.selectTitle = @"前置";
            model.selectImage = @"live_more_carema";
            break;
            
        case SLLMTypeMirror:
            model.title = @"镜像";
            model.image = @"live_more_mirror";
            break;
            
        case SLLMTypeMute:
            model.title = @"开静音";
            model.image = @"live_more_mute";
            model.selectTitle = @"关静音";
            model.selectImage = @"live_more_unmute";
            break;
            
        case SLLMTypeShoot:
            model.title = @"截屏";
            model.image = @"live_more_shoot";
            break;
            
        default:
            break;
    }
    return model;
}


@end

//
//  ACMediaImageCell.m
//
//  Created by caoyq on 16/12/2.
//  Copyright © 2016年 SnSoft. All rights reserved.
//

#import "ACMediaImageCell.h"
#import "ACMediaFrameConst.h"

@interface ACMediaImageCell ()
{
    UIButton * image;
}
@end

@implementation ACMediaImageCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self _setupViews];
        image=[UIButton buttonWithType:UIButtonTypeCustom];
        image.frame=self.bounds;
        [image setImage:[UIImage imageNamed:@"点点"] forState:UIControlStateNormal];
        image.backgroundColor=RGBACOLOR(1, 1, 1, .5);
        image.hidden=YES;
        [self.icon addSubview:image];

    }
    return self;
}
-(void)setIsLast:(BOOL)isLast
{
    _isLast =isLast;
    if (_isLast) {
        image.hidden=NO;
    }
    else
    {
        image.hidden=YES;
    }
}
- (void)_setupViews {

    _selectBtn = [[UIButton alloc] init];
    [_selectBtn setBackgroundImage:[UIImage imageNamed:@"照片未选中"] forState:UIControlStateNormal];
    [_selectBtn setBackgroundImage:[UIImage imageNamed:@"照片选中"] forState:UIControlStateSelected];

    [_selectBtn addTarget:self action:@selector(clickDeleteButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_selectBtn];
    
    _videoImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ACMediaFrame.bundle/ShowVideo"]];
    [self.contentView addSubview:_videoImageView];
    
    _icon = [[UIImageView alloc] init];
    _icon.clipsToBounds = YES;
    _icon.contentMode = UIViewContentModeScaleAspectFill;
    [self.contentView addSubview:_icon];

}

- (void)layoutSubviews {
    [super layoutSubviews];
    _icon.frame = CGRectMake(0, 0, self.width, self.height);
    _selectBtn.frame = CGRectMake(self.bounds.size.width - ACMediaDeleteButtonWidth, self.height-ACMediaDeleteButtonWidth, ACMediaDeleteButtonWidth, ACMediaDeleteButtonWidth);
    _videoImageView.frame = CGRectMake((self.width-30)/2, (self.width-30)/2, 30, 30);
}
-(void)setModel:(ACMediaModel *)model
{
    _model=model;
    _selectBtn.selected=_model.isSelect;
    NSString * thumbnail =_model.thumbnail;

    if (!model.isVideo && model.imageUrlString) {
        if (thumbnail.length>1) {
            [self.icon yy_setImageWithURL:[NSURL URLWithString: thumbnail] placeholder:[UIImage imageNamed:@"照片墙缺省图"]];//关注默认图
        }
        else
            [self.icon yy_setImageWithURL:[NSURL URLWithString:model.imageUrlString] placeholder:[UIImage imageNamed:@"照片墙缺省图"]];
    }else if (model.isVideo && model.imageUrlString)
    {
        if (thumbnail.length>1) {
            [self.icon yy_setImageWithURL:[NSURL URLWithString: thumbnail] placeholder:[UIImage imageNamed:@"照片墙缺省图"]];
        }
        else
            [self.icon yy_setImageWithURL:[NSURL URLWithString:model.imageUrlString] placeholder:[UIImage imageNamed:@"照片墙缺省图"]];
    }
    else
    {
        self.icon.image = model.image;
    }
    
    self.videoImageView.hidden = !model.isVideo;
}
- (void)clickDeleteButton:(UIButton *)sender {

    if(_delegate){
        [_delegate selectCellBtn:sender clickedWithData:_model];
    }
}
-(void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    if (selected) {
        //选中时
        NSLog(@"4321");
        if(_delegate){
            [_delegate selectCellBtn:_selectBtn clickedWithData:_model];
        }
    }else{
        //非选中
        NSLog(@"1234");
    }
}
@end

//
//  SLComboButton.m
//  ShowLive
//
//  Created by gongxin on 2018/4/16.
//  Copyright © 2018年 vning. All rights reserved.
//

#import "SLComboButton.h"
#import "SLCountDown.h"

@interface SLComboButton ()<SLCountDownTimerDelegate>

@property (nonatomic, strong) UIButton *camboBtn;

@property (nonatomic, strong) UILabel  *camNumLabel;

@property (nonatomic, assign) BOOL isShow;

@property (nonatomic, strong) NSDate *startDate;

@property (nonatomic,assign) NSInteger optionTimerCount;

@property (nonatomic,strong) SLCountDown *countDown;

@end

@implementation SLComboButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.frame  = CGRectMake(frame.origin.x, frame.origin.y, 84, 84);
        self.hidden = YES;
        [self initButton];
        self.isShow = NO;
        _optionTimerCount = 50;
        _startDate = [NSDate date];
        
    }
    
    return self;
}

- (void)initButton
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame     = self.bounds;
    
    btn.layer.cornerRadius = self.width/2;
    btn.clipsToBounds      = YES;
    
    btn.backgroundColor = [[UIColor orangeColor] colorWithAlphaComponent:0.5];
    
    btn.layer.borderWidth = 3;
    btn.layer.borderColor = [UIColor orangeColor].CGColor;
    
    btn.titleLabel.font = [UIFont systemFontOfSize:25];

    [btn setTitleColor:[UIColor whiteColor]
              forState:UIControlStateNormal];
    
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.camboBtn = btn;
    [self addSubview:self.camboBtn];
    
}

- (void)show
{
    if (self.isShow) return;
    self.isShow = YES;
    self.hidden = NO;
    
    [self.camboBtn setTitle:[NSString stringWithFormat:@"%ld",_optionTimerCount]
                   forState:UIControlStateNormal];
    _countDown = [[SLCountDown alloc]initWithCount:_optionTimerCount];
    _countDown.delegate = self;
    [_countDown start];
    
    
}

- (void)hide
{
    if(self.hidden == YES) return;
    
    self.isShow = NO;
    self.hidden = YES;
    
    self.finishBlock();
    
    [_countDown stop];
}

- (void)btnClick:(UIButton *)btn
{
   
    [self.camboBtn setTitle:[NSString stringWithFormat:@"%ld",(long)_optionTimerCount]
                   forState:UIControlStateNormal];
    
    [_countDown countReset];
    
    self.startDate = [NSDate date];
    self.clickBlock();
}

#pragma mark -- timerDelegate

- (void)reductionNum:(NSInteger)currentCount
{
    [self.camboBtn setTitle:[NSString stringWithFormat:@"%ld",currentCount]
                   forState:UIControlStateNormal];
    
    if (currentCount == 0) {
        
        [self hide];
    }
    
}

@end

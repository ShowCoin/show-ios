//
//  SLUserInfoListCell.h
//  ShowLive
//
//  Created by vning on 2018/4/25.
//  Copyright © 2018年 vning. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SLUserInfoListCell : UITableViewCell<UITextFieldDelegate>
@property (strong,nonatomic)UILabel * title;
@property (strong,nonatomic)UILabel * textLab;
@property (strong,nonatomic)UILabel * detailTextLab;
@property (strong,nonatomic)UIImageView * arrow;
@property (strong,nonatomic)UIView * lineView;

@end

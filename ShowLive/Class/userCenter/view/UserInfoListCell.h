//
//  UserInfoListCell.h
//  ShowLive
//
//  Created by vning on 2018/4/6.
//  Copyright © 2018年 vning. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, CellType){
    /**
     *  首行
     */
    firstcellType   =    0,
    /**
     *  其他
     */
    othertcellType  =    1
};

@interface UserInfoListCell : UITableViewCell
@property (assign,nonatomic)CellType celltype;

@property (strong,nonatomic)UILabel * name;
@property (strong,nonatomic)UILabel * text;
@property (strong,nonatomic)UIImageView * arrow;
@property (strong,nonatomic)UIImageView * avatar;

@end

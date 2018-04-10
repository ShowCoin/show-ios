//
//  BaseModel.h
//
//  Created by JokeSmielZhang on 16/4/11.
//  Copyright © 2016年 JokeSmielZhang. All rights reserved.
//

#import "JSONModel.h"
#import "BGFMDB.h" //添加该头文件,本类就具有了存储功能.

@interface BaseModel : JSONModel<NSCoding>


@end

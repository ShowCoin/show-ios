//
//  ACMediaModel.m
//
//  Created by  JokeSmileZhang on 16/12/25.
//  Copyright © 2016年 ArthurCao. All rights reserved.
//

#import "ACMediaModel.h"

@implementation ACMediaModel
-(void)setFile:(NSString *)file
{
    _file=file;
    NSString *b = [file substringFromIndex:file.length-1];
    if ([b isEqualToString:@"4"])
    {
        self.isVideo=YES;
        self.mediaURL=[NSURL URLWithString:_file];
    }
    else
    {
        self.isVideo=NO;
    }
    self.imageUrlString=_img;

}
@end

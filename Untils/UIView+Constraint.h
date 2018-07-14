//
//  UIView+Constraint.h
//  show
//
//  Created by showgx on 16/8/14.
//  Copyright © 2016年 show. All rights reserved.
//
//按方向停靠在给定的某一个View的边上
//    b    2    a
//     ---------
//     |       |
//   3 |       | 1
//     |       |
//     ---------
//    c    4    d
//-|右上角 |-左上角 |_左下角 _|右下角
//|1右边外部 1|右边内部 _2上边外部 2_上边


#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, JQconstraintType) {
    //     ---------
    //     |       |
    //     |   o   |
    //     |       |
    //     ---------
    constraintStickyTypeCenter,//中心点
    
    //吸附View内边
    //     ---------
    //     |       |
    //     |      o|
    //     |       |
    //     ---------
    constraintStickyTypeInsideRightEdge,//内边1----Edge
    //     ---------
    //     |       |
    //     |o      |
    //     |       |
    //     ---------
    constraintStickyTypeInsideLeftEdge,//内边3----Edge
    //     ---------
    //     |   o   |
    //     |       |
    //     |       |
    //     ---------
    constraintStickyTypeInsideTopEdge,//内边2----Edge
    //     ---------
    //     |       |
    //     |       |
    //     |   o   |
    //     ---------
    constraintStickyTypeInsideBottomEdge,//内边4----Edge
    
    //     ---------
    //     |      o|
    //     |       |
    //     |       |
    //     ---------
    constraintStickyTypeUpperRightCorner,//右上角a----Corner
    //     ---------
    //     |o      |
    //     |       |
    //     |       |
    //     ---------
    constraintStickyTypeUpperLeftCorner,//左上角b----Corne
    //     ---------
    //     |       |
    //     |       |
    //     |o      |
    //     ---------
    constraintStickyTypeLowerLeftCorner,//左下角c----Corne
    //     ---------
    //     |       |
    //     |       |
    //     |      o|
    //     ---------
    constraintStickyTypeLowerRightCorner,//右下角d----Corne
    
    //吸附View外边
    //     ---------
    //     |       |
    //     |       |o
    //     |       |
    //     ---------
    constraintStickyTypeOutsideRightEdge,//外边1----Edge
    //     ---------
    //     |       |
    //    o|       |
    //     |       |
    //     ---------
    constraintStickyTypeOutsideLeftEdge,//外边3----Edge
    //         o
    //     ---------
    //     |       |
    //     |       |
    //     |       |
    //     ---------
    constraintStickyTypeOutsideTopEdge,//外边2----Edge
    //     ---------
    //     |       |
    //     |       |
    //     |       |
    //     ---------
    //         o
    constraintStickyTypeOutsideBottomEdge,//外边4----Edge
    
    //     _________
    //     |       |o
    //     |       |
    //     |       |
    //     ---------
    constraintStickyTypeOutsideRightEdgeTop,//外右边1,吸顶----Corner
    //     _________
    //     |       |
    //     |       |
    //     |       |o
    //     ---------
    constraintStickyTypeOutsideRightEdgeBottom,//外右边1,吸底部----Corner
    
    //     o
    //     ---------
    //     |       |
    //     |       |
    //     |       |
    //     ---------
    constraintStickyTypeOutsideUpperEdgeLeft,//外顶边2,吸左边----Corner
    //             o
    //     ---------
    //     |       |
    //     |       |
    //     |       |
    //     ---------
    constraintStickyTypeOutsideUpperEdgeRight,//外顶边2,吸右边----Corner
    
    //     _________
    //    o|       |
    //     |       |
    //     |       |
    //     ---------
    constraintStickyTypeOutsideLeftEdgeTop,//外左边3,吸顶----Corner
    //     _________
    //     |       |
    //     |       |
    //    o|       |
    //     ---------
    constraintStickyTypeOutsideLeftEdgeBottom,//外左边3,吸底部----Corner
    
    //     _________
    //     |       |
    //     |       |
    //     |       |
    //     ---------
    //     o
    constraintStickyTypeOutsideLowerEdgeLeft,//外顶边4,吸左边----Corner
    //     _________
    //     |       |
    //     |       |
    //     |       |
    //     ---------
    //             o
    constraintStickyTypeOutsideLowerEdgeRight,//外顶边4,吸右边----Corner
    
};
typedef NS_ENUM(NSUInteger, JQconstraint2ViewType) {
    //     _________         ________
    //     |       |         |      |
    //     |   *---|----0----|---*  |
    //     |       |         |      |
    //     ---------         --------
    constraint2ViewTypeDivideDistance,//中心点距离等分
    
    //     _________
    //     |       |
    //     |   0   |
    //     |   |   |
    //     ---------
    constraint2ViewTypeLowerEdge,//1view到2view的底边
    //     _________
    //     |   |   |
    //     |   0   |
    //     |       |
    //     ---------
    constraint2ViewTypeUpperEdge,//1view到2view的底边
    //     _________
    //     |       |
    //     |---0   |
    //     |       |
    //     ---------
    constraint2ViewTypeLeftEdge,//1view到2view的左边
    //     _________
    //     |       |
    //     |   0---|
    //     |       |
    //     ---------
    constraint2ViewTypeRightEdge,//1view到2view的右边
    
};

@interface UIView (Constraint)
//按方向停靠在给定的某一个View的边上
- (void)constraintStickyWithView:(UIView*)view orientation:(JQconstraintType)orientation offset:(NSArray*)offsetArray;

//两个View的距离的中心点约束
- (void)constraint2View:(NSArray<UIView *>*)views constraintType:(JQconstraint2ViewType)type offset:(NSArray*)offsetArray;

@end

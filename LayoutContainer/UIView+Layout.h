//
// Created by William Zhao on 4/2/14.
// Copyright (c) 2014 Vipshop Holdings Limited. All rights reserved.
//

#import <Foundation/Foundation.h>

struct VSGap {
    CGFloat top;
    CGFloat left;
    CGFloat bottom;
    CGFloat right;
};
typedef struct VSGap VSGap;

CG_INLINE VSGap
VSGapMake(CGFloat top, CGFloat left, CGFloat bottom, CGFloat right)
{
    VSGap gap;
    gap.top = top; gap.left= left;
    gap.bottom = bottom; gap.right = right;
    return gap;
}

@interface UIView (VSLayoutContainer)

//排版间隙
-(VSGap)gap;

@end
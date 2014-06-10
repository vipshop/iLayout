//
// Created by William Zhao on 4/2/14.
// Copyright (c) 2014 Vipshop Holdings Limited. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface VSHorizontalLayoutView : UIView

//添加子View用于排版
-(void)addSubviewForLayout:(UIView*)subview;

//更新布局
-(void)updateLayout;

@end

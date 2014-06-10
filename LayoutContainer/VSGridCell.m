//
//  VSGridCell.m
//  LayoutContainer
//
//  Created by vips on 14-6-10.
//  Copyright (c) 2014年 Vipshop Holdings Limited. All rights reserved.
//

#import "VSGridCell.h"

@implementation VSGridCell
{
    UIButton *_backgroundButton;
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
//        _backgroundButton = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
//        _backgroundButton.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
//        _backgroundButton.backgroundColor = [UIColor clearColor];
//        [_backgroundButton addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}


//- (void)click:(id)sender
//{
//    UIView *view = self.superview;
//    if (view && [view isKindOfClass:NSClassFromString(@"VSGridLayoutScrollView")]) {
//        
//    }
//}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end

//
// Created by William Zhao on 4/2/14.
// Copyright (c) 2014 Vipshop Holdings Limited. All rights reserved.
//

#import <Foundation/Foundation.h>

@class VSHorizontalLayout;

@protocol VSHorizontalLayoutDelegate<NSObject>

-(void)layoutViewDidChange:(VSHorizontalLayout*)HorizontalLayout;

@end

@interface VSHorizontalLayout : NSObject

@property (nonatomic, assign) id<VSHorizontalLayoutDelegate> delegate;
@property (nonatomic, readonly) CGFloat contentHeight;

- (void)addSubviewForLayout:(UIView *)subview;

- (void)removeSubviewForLayout:(UIView*)subview;

- (void)updateLayout;

@end

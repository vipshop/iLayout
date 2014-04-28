//
// Created by William Zhao on 4/2/14.
// Copyright (c) 2014 Vipshop Holdings Limited. All rights reserved.
//

#import <Foundation/Foundation.h>

@class VSVerticalLayout;

@protocol VSVerticalLayoutDelegate<NSObject>

-(void)layoutViewDidChange:(VSVerticalLayout*)verticalLayout;

@end

@interface VSVerticalLayout : NSObject

@property (nonatomic, assign) id<VSVerticalLayoutDelegate> delegate;
@property (nonatomic, readonly) CGFloat contentHeight;

- (void)addSubviewForLayout:(UIView *)subview;

- (void)removeSubviewForLayout:(UIView*)subview;

- (void)updateLayout;

@end
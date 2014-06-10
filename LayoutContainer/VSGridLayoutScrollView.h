//
// Created by William Zhao on 5/14/14.
// Copyright (c) 2014 Vipshop Holdings Limited. All rights reserved.
//

#import <Foundation/Foundation.h>

@class VSGridCell;
@class VSGridLayoutScrollView;

#define VSGridChangeNotification @"VSGridChangeNotification"

@protocol VSGridViewDataSource<NSObject>
@required
- (NSInteger)numberOfItemsInGridView:(VSGridLayoutScrollView *)gridView;
- (VSGridCell *)gridView:(VSGridLayoutScrollView *)gridView cellForItemAtIndex:(NSInteger)index;
- (CGSize )sizeOfItemsInGridView:(VSGridLayoutScrollView *)gridView;
@end


@protocol VSGridViewTapDelegate <NSObject>
@required
- (void)gridView:(VSGridLayoutScrollView *)gridView didTapOnItemAtIndex:(NSInteger)index;
@end


@interface VSGridLayoutScrollView : UIScrollView
@property (nonatomic) NSInteger itemSpacing;
@property (nonatomic) UIEdgeInsets minEdgeInsets;
@property (nonatomic,unsafe_unretained)id <VSGridViewDataSource>dataSource;
@property (nonatomic,unsafe_unretained)id <VSGridViewTapDelegate>tapDelegate;


- (void)reloadData;
- (void)insertCell:(VSGridCell *)cell atIndex:(NSInteger)index animated:(BOOL)animated;
- (void)removeCellAtIndex:(NSInteger)index animated:(BOOL)animated;
- (void)replaceCell:(VSGridCell *)cell atIndex:(NSInteger)index animated:(BOOL)animated;
- (VSGridCell *)cellAtIndex:(NSInteger)index;
- (NSInteger)indexOfCell:(VSGridCell *)cell;
@end
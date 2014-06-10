//
// Created by William Zhao on 5/14/14.
// Copyright (c) 2014 Vipshop Holdings Limited. All rights reserved.
//

#import "VSGridLayoutScrollView.h"
#import "VSGridCell.h"
#define kTagOffset 5
static const CGFloat kDefaultAnimationDuration = 0.3;
static const UIViewAnimationOptions kDefaultAnimationOptions = UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionAllowUserInteraction;

@interface VSGridLayoutScrollView ()<UIGestureRecognizerDelegate>
{
    CGSize _itemSize;
    UITapGestureRecognizer *tapGesture;
}
@end

@implementation VSGridLayoutScrollView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _itemSpacing = 10;
        _minEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
        
        
        tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureUpdated:)];
        tapGesture.delegate = self;
        tapGesture.numberOfTapsRequired = 1;
        tapGesture.numberOfTouchesRequired = 1;
        tapGesture.cancelsTouchesInView = NO;
        [self addGestureRecognizer:tapGesture];
    }
    return self;
}


- (NSInteger )numberOfItemInRow
{
    _itemSize = [_dataSource sizeOfItemsInGridView:self];
    NSInteger numberOfItemInRow = 1;
    numberOfItemInRow = (self.frame.size.width - self.minEdgeInsets.left-self.minEdgeInsets.right+_itemSpacing)/(_itemSpacing+_itemSize.width);
    if (numberOfItemInRow<1) {
        numberOfItemInRow = 1;
    }
    return numberOfItemInRow;
}

- (NSInteger )numberOfRow
{
    NSInteger numberOfItemInRow = [self numberOfItemInRow];
    NSInteger total = [_dataSource numberOfItemsInGridView:self];
    return   (NSInteger) (total/numberOfItemInRow) + (total%numberOfItemInRow?1:0);
}



- (void)reloadData
{
    
    if (!_dataSource || ![_dataSource respondsToSelector:@selector(numberOfItemsInGridView:)]
        || ![_dataSource respondsToSelector:@selector(sizeOfItemsInGridView:)]
        || ![_dataSource respondsToSelector:@selector(gridView:cellForItemAtIndex:)]) {
        return;
    }
    NSInteger total = [_dataSource numberOfItemsInGridView:self];
    _itemSize = [_dataSource sizeOfItemsInGridView:self];
    NSInteger numberOfItemInRow = [self numberOfItemInRow];
    
    
    int numberOfRow = (int ) (total/numberOfItemInRow) + (total%numberOfItemInRow?1:0);
    self.contentSize = CGSizeMake(self.frame.size.width,self.minEdgeInsets.top+self.minEdgeInsets.bottom+(_itemSize.height+_itemSpacing)*numberOfRow-_itemSpacing);
    for (int i = 0; i<total; i++) {
        VSGridCell *cell = [_dataSource gridView:self cellForItemAtIndex:i];
        NSInteger row = i/numberOfItemInRow;
        NSInteger indexAtRow = i - row*numberOfItemInRow;
        cell.frame = CGRectMake(_minEdgeInsets.left+indexAtRow*(_itemSize.width+_itemSpacing), _minEdgeInsets.top+row*(_itemSize.height+_itemSpacing), _itemSize.width, _itemSize.height);
        cell.tag = i+kTagOffset;
        [self addSubview:cell];
        
    }
}

- (void)tapGestureUpdated:(UITapGestureRecognizer *)tapGestur
{
    CGPoint locationTouch = [tapGestur locationInView:self];
    int row = (locationTouch.y-_minEdgeInsets.top)/(_itemSize.height+_itemSpacing);
    float y2Item = locationTouch.y-(_itemSize.height+_itemSpacing)*row-_minEdgeInsets.top-_itemSize.height;
    if (y2Item>0) {
        return;
    }
    
    int indexAtRow = (locationTouch.x-_minEdgeInsets.left)/(_itemSize.width+_itemSpacing);
    float x2Item = locationTouch.x-(_itemSize.width+_itemSpacing)*indexAtRow-_minEdgeInsets.left-_itemSize.width;
    if (x2Item>0) {
        return;
    }
    
    NSInteger index = row*[self numberOfItemInRow]+indexAtRow;
    
    if (_tapDelegate  && [_tapDelegate respondsToSelector:@selector(gridView:didTapOnItemAtIndex:)]) {
        [_tapDelegate gridView:self didTapOnItemAtIndex:index];
    }
}

- (NSInteger)indexOfCell:(VSGridCell *)cell
{
    for (VSGridCell *sub in self.subviews) {
        if (sub == cell) {
            return sub.tag-kTagOffset;
        }
    }
    return NSNotFound;
}

- (VSGridCell *)cellAtIndex:(NSInteger)index
{
    VSGridCell *view = (VSGridCell *)[self viewWithTag:index+kTagOffset];
    return view;
}

- (CGPoint)originForItemAtIndex:(NSInteger)index
{
    NSInteger numberOfItemInRow = [self numberOfItemInRow];
    NSInteger row = index/numberOfItemInRow;
    NSInteger indexAtRow = index - row*numberOfItemInRow;
    CGPoint   origin = CGPointMake(_minEdgeInsets.left+indexAtRow*(_itemSize.width+_itemSpacing), _minEdgeInsets.top+row*(_itemSize.height+_itemSpacing));
    return origin;
}



- (void)insertCell:(VSGridCell *)cell atIndex:(NSInteger)index animated:(BOOL)animated
{
    NSInteger numberOfItemInRow = [self numberOfItemInRow];
    NSInteger total = [_dataSource numberOfItemsInGridView:self];
    BOOL isfull =  total%numberOfItemInRow==0?YES:NO;
    
    if ([self numberOfRow]>0) {
        if (isfull) {
            self.contentSize = CGSizeMake(self.frame.size.width, self.contentSize.height+_itemSize.height+_itemSpacing);
        }
    }else{
        self.contentSize = CGSizeMake(self.frame.size.width, _minEdgeInsets.top+_minEdgeInsets.bottom+_itemSize.height);
    }
    
    for (UIView *view in self.subviews)
    {
        NSInteger i = view.tag - kTagOffset;
        if (i>=index ) {
            view.tag = i+kTagOffset+1;
        }
    }
    
    void (^layoutBlock)(void) = ^{
        for (UIView *view in self.subviews)
        {
            if ([view isKindOfClass:[VSGridCell class]])
            {
                NSInteger i = view.tag - kTagOffset;
                if (i>index ) {
                    CGPoint origin = [self originForItemAtIndex:i];
                    view.frame = CGRectMake(origin.x, origin.y, _itemSize.width, _itemSize.height);
                }
                
            }
        }
    };
    
    if (!animated) {
        layoutBlock();
        cell.tag = index+kTagOffset;
        CGPoint origin = [self originForItemAtIndex:index];
        cell.frame = CGRectMake(origin.x, origin.y, _itemSize.width, _itemSize.height);
        [self addSubview:cell];
    }else{
        [UIView animateWithDuration:kDefaultAnimationDuration
                              delay:0
                            options:kDefaultAnimationOptions
                         animations:^{
                             layoutBlock();
                         }
                         completion:^(BOOL finished){
                             cell.tag = index+kTagOffset;
                             CGPoint origin = [self originForItemAtIndex:index];
                             cell.frame = CGRectMake(origin.x, origin.y, _itemSize.width, _itemSize.height);
                             cell.alpha = 0.0;
                             [self addSubview:cell];
                             
                             [UIView animateWithDuration:kDefaultAnimationDuration delay:0 options:kDefaultAnimationDuration animations:^{
                                 cell.alpha = 1.0;
                             }completion:^(BOOL finished){
                                 [[NSNotificationCenter defaultCenter] postNotificationName:VSGridChangeNotification object:@{@"action": @"add",@"index":[NSString stringWithFormat:@"%ld",(long)index]} userInfo:nil];
                             }];
                         }
         ];
    }
    
}


- (void)removeCellAtIndex:(NSInteger)index animated:(BOOL)animated
{
    NSInteger numberOfItemInRow = [self numberOfItemInRow];
    NSInteger total = [_dataSource numberOfItemsInGridView:self];
    if (index>=total) {
        return;
    }
    BOOL isfull =  total%numberOfItemInRow==1?YES:NO;
    if (isfull) {
        float space = 0;
        if ([self numberOfRow]!=1) {
            space = _itemSpacing;
        }
        self.contentSize = CGSizeMake(self.frame.size.width, self.contentSize.height-_itemSize.height-space);
    }
    
    
    
    void (^layoutBlock)(void) = ^{
        for (UIView *view in self.subviews)
        {
            if ([view isKindOfClass:[VSGridCell class]])
            {
                NSInteger i = view.tag - kTagOffset;
                if (i>index ) {
                    CGPoint origin = [self originForItemAtIndex:i-1];
                    view.frame = CGRectMake(origin.x, origin.y, _itemSize.width, _itemSize.height);
                    view.tag = i+kTagOffset-1;
                }
                
            }
        }
    };
    
    if (!animated) {
        VSGridCell *cell = (VSGridCell *)[self cellAtIndex:index];
        [cell removeFromSuperview];
        layoutBlock();
        
    }else{
        VSGridCell *cell = (VSGridCell *)[self cellAtIndex:index];
        [UIView animateWithDuration:kDefaultAnimationDuration delay:0 options:kDefaultAnimationDuration animations:^{
            cell.alpha = 0.0;
        }completion:^(BOOL finished){
            [cell removeFromSuperview];
            [UIView animateWithDuration:kDefaultAnimationDuration
                                  delay:0
                                options:kDefaultAnimationOptions
                             animations:^{
                                 layoutBlock();
                             }completion:^(BOOL finished){
                                 [[NSNotificationCenter defaultCenter] postNotificationName:VSGridChangeNotification object:@{@"action": @"delete",@"index":[NSString stringWithFormat:@"%ld",(long)index]} userInfo:nil];
                             }];
        }];
        
    }
    
    
}


- (void)replaceCell:(VSGridCell *)cell atIndex:(NSInteger)index animated:(BOOL)animated
{
    VSGridCell *temp = (VSGridCell *)[self cellAtIndex:index];
    [UIView animateWithDuration:kDefaultAnimationDuration delay:0 options:kDefaultAnimationDuration animations:^{
        temp.alpha = 0.0;
    }completion:^(BOOL finished){
        [temp removeFromSuperview];
        
        cell.tag = index+kTagOffset;
        CGPoint origin = [self originForItemAtIndex:index];
        cell.frame = CGRectMake(origin.x, origin.y, _itemSize.width, _itemSize.height);
        cell.alpha = 0.0;
        [self addSubview:cell];
        
        [UIView animateWithDuration:kDefaultAnimationDuration delay:0 options:kDefaultAnimationDuration animations:^{
            cell.alpha = 1.0;
        }completion:^(BOOL finished){
            [[NSNotificationCenter defaultCenter] postNotificationName:VSGridChangeNotification object:@{@"action": @"repalce",@"index":[NSString stringWithFormat:@"%ld",(long)index]} userInfo:nil];
        }];
    }];
}




@end
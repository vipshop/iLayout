//
// Created by William Zhao on 4/2/14.
// Copyright (c) 2014 Vipshop Holdings Limited. All rights reserved.
//

#import "VSHorizontalLayoutView.h"
#import "VSHorizontalLayout.h"

@interface VSHorizontalLayoutView()<VSHorizontalLayoutDelegate>

@end

@implementation VSHorizontalLayoutView {
    VSHorizontalLayout *_HorizontalLayout;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _HorizontalLayout = [[VSHorizontalLayout alloc] init];
        _HorizontalLayout.delegate = self;
    }
    return self;
}

- (void)dealloc {
    [_HorizontalLayout release];
    [super dealloc];
}

- (void)addSubviewForLayout:(UIView *)subview {
    [_HorizontalLayout addSubviewForLayout:subview];
    [super addSubview:subview];
}

- (void)willRemoveSubview:(UIView *)subview {
    [_HorizontalLayout removeSubviewForLayout:subview];
    [super willRemoveSubview:subview];
}

-(void)updateLayout {
    [_HorizontalLayout updateLayout];
}

#pragma mark - VSHorizontalLayoutDelegate

-(void)layoutViewDidChange:(VSHorizontalLayout*)HorizontalLayout {
}

-(void)layoutViewWillChange:(VSHorizontalLayout *)HorizontalLayout{
    
}

@end

//
// Created by William Zhao on 4/2/14.
// Copyright (c) 2014 Vipshop Holdings Limited. All rights reserved.
//

#import "VSVerticalLayoutView.h"
#import "VSVerticalLayout.h"

@interface VSVerticalLayoutView()<VSVerticalLayoutDelegate>

@end

@implementation VSVerticalLayoutView {
    VSVerticalLayout *_verticalLayout;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _verticalLayout = [[VSVerticalLayout alloc] init];
        _verticalLayout.delegate = self;
    }
    return self;
}

- (void)dealloc {
    [_verticalLayout release];
    [super dealloc];
}

- (void)addSubviewForLayout:(UIView *)subview {
    [_verticalLayout addSubviewForLayout:subview];
    [super addSubview:subview];
}

- (void)willRemoveSubview:(UIView *)subview {
    [_verticalLayout removeSubviewForLayout:subview];
    [super willRemoveSubview:subview];
}

-(void)updateLayout {
    [_verticalLayout updateLayout];
}

#pragma mark - VSVerticalLayoutDelegate

-(void)layoutViewDidChange:(VSVerticalLayout*)verticalLayout {
}

- (void)layoutViewWillChange:(VSVerticalLayout *)verticalLayout{
    
}

@end

//
// Created by William Zhao on 4/2/14.
// Copyright (c) 2014 Vipshop Holdings Limited. All rights reserved.
//

#import "VSHorizontalLayout.h"
#include <vector>

@implementation VSHorizontalLayout {
    std::vector<UIView *> *_layoutSubviewVector;
    CGFloat _contentHeight;
}

- (id)init {
    self = [super init];
    if (self) {
        _contentHeight = 0;
        _layoutSubviewVector = new std::vector<UIView *>();
    }
    return self;
}

- (void)dealloc {
    delete _layoutSubviewVector;
    [super dealloc];
}

-(CGFloat)contentHeight {
    return _contentHeight;
}

- (void)addSubviewForLayout:(UIView *)subview {
    _layoutSubviewVector->push_back(subview);
    [self updateLayout];
}

-(void)removeSubviewForLayout:(UIView*)subview {
    std::vector<UIView *>::iterator it = std::find(_layoutSubviewVector->begin(), _layoutSubviewVector->end(), subview);
    if (it != _layoutSubviewVector->end()) {
        _layoutSubviewVector->erase(it);
        [self updateLayout];
    }
}

- (void)updateLayout {
    if ([self.delegate respondsToSelector:@selector(layoutViewWillChange:)]){
        [self.delegate layoutViewWillChange:self];
    }
    UIView *prevView = nil;
    CGFloat contentHeight = 0;
    std::vector<UIView *>::iterator it;
    for (it = _layoutSubviewVector->begin(); it != _layoutSubviewVector->end(); it++) {
        UIView* view = *it;
        CGFloat y = 0;
        if (prevView) {
            y = prevView.frame.origin.y + prevView.frame.size.height;
        }
        if(view.frame.origin.y!=y) {
            CGRect rect = CGRectMake(view.frame.origin.x, y, view.frame.size.width, view.frame.size.height);
            view.frame = rect;
        }
        prevView = view;
        contentHeight = contentHeight + view.frame.size.height;
    }
    _contentHeight = contentHeight;
    if(_delegate && [_delegate respondsToSelector:@selector(layoutViewDidChange:)]){
        [_delegate layoutViewDidChange:self];
    }
}


@end

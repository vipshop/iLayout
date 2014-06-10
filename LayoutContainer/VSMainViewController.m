//
//  VSMainViewController.m
//  LayoutContainer
//
//  Created by William Zhao on 4/2/14.
//  Copyright (c) 2014 Vipshop Holdings Limited. All rights reserved.
//

#import "VSMainViewController.h"
#import "VSVerticalLayoutScrollView.h"
@import QuartzCore;

@interface VSMainViewController ()

@property(nonatomic, retain) VSVerticalLayoutScrollView *verticalLayoutView;

@end

@implementation VSMainViewController

- (id)init {
    self = [super init];
    if (self) {
        self.view.backgroundColor = [UIColor whiteColor];
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"LayoutView Test"];
    self.verticalLayoutView = [[[VSVerticalLayoutScrollView alloc] initWithFrame:self.view.bounds] autorelease];
    [self.view addSubview:self.verticalLayoutView];
    
    UIBarButtonItem *item=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addButton)];
    self.navigationItem.rightBarButtonItem=item;
    [item release];
}

- (void)initView{
    for (int i=0; i<5; i++) {
        [self addButton];
    }
}

- (void)removeSelf:(UIButton *)sender{
    [sender removeFromSuperview];
}

- (void)addButton{
    UIButton *button=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    //don't need set correct origin.y for button
    button.frame=CGRectMake(0, 0, 200, 30);
    [button.layer setCornerRadius:2.0f];
    [button.layer setBorderWidth:1.0f];
    [button.layer setBorderColor:[UIColor purpleColor].CGColor];
    [button setTitle:@"click For Remove" forState:UIControlStateNormal];
    button.tag=(long)button;
    [button addTarget:self action:@selector(removeSelf:) forControlEvents:UIControlEventTouchUpInside];
    [self.verticalLayoutView addSubviewForLayout:button];
}

@end
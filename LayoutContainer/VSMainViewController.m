//
//  VSMainViewController.m
//  LayoutContainer
//
//  Created by William Zhao on 4/2/14.
//  Copyright (c) 2014 Vipshop Holdings Limited. All rights reserved.
//

#import "VSMainViewController.h"
#import "VSVerticalLayoutScrollView.h"

@interface VSMainViewController ()

@property(nonatomic, retain) VSVerticalLayoutScrollView *verticalLayoutView;

@property (nonatomic, retain) UIButton *button1;
@property (nonatomic, retain) UISwitch *switch1;
@property (nonatomic, retain) UILabel *label1;

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
    self.verticalLayoutView = [[[VSVerticalLayoutScrollView alloc] initWithFrame:CGRectMake(0, 100, 320, 380)] autorelease];
    [self.view addSubview:self.verticalLayoutView];

    self.button1 = [UIButton buttonWithType:UIButtonTypeContactAdd];
    [self.button1 addTarget:self action:@selector(testClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.verticalLayoutView addSubviewForLayout:self.button1];

    self.switch1 = [[[UISwitch alloc] initWithFrame:CGRectMake(0, 0, 100, 30)] autorelease];
    [self.verticalLayoutView addSubviewForLayout:self.switch1];

    self.label1 = [[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 30)] autorelease];
    self.label1.text = @"LayoutView Test";
    [self.verticalLayoutView addSubviewForLayout:self.label1];
}

-(void)testClick:(id)sender {
    NSLog(@"%@",self.switch1.superview);
    [self.switch1 removeFromSuperview];
    NSLog(@"%@",self.switch1.superview);
}

@end
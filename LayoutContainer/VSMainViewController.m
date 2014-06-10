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


#import "VSGridLayoutScrollView.h"
#import "VSGridCell.h"
@interface VSMainViewController ()<VSGridViewDataSource,VSGridViewTapDelegate>
{
    int _gridCount ;
}

@property(nonatomic, retain) VSVerticalLayoutScrollView *verticalLayoutView;

@property (nonatomic, retain) UIButton *button1;
@property (nonatomic, retain) UISwitch *switch1;
@property (nonatomic, retain) UILabel *label1;
@property (nonatomic, retain) VSGridLayoutScrollView *gridView;

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
    
    _gridCount = 20;
    self.verticalLayoutView = [[[VSVerticalLayoutScrollView alloc] initWithFrame:CGRectMake(0, 10, 320, 380)] autorelease];
    
    [self.view addSubview:self.verticalLayoutView];
    
    UIBarButtonItem *item=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addButton)];
    self.navigationItem.rightBarButtonItem=item;
    [item release];
    
    
    self.label1 = [[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 30)] autorelease];
    self.label1.text = @"LayoutView Test";
    [self.verticalLayoutView addSubviewForLayout:self.label1];
    
    VSGridLayoutScrollView *grid = [[VSGridLayoutScrollView alloc] initWithFrame:CGRectMake(0, 200, 320, 240)];
    self.gridView = grid;
    grid.dataSource = self;
    grid.tapDelegate = self;
    [self.view addSubview:grid];
    [grid reloadData];
    
    
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    addBtn.frame = CGRectMake(0, 460, 80, 25);
    addBtn.backgroundColor = [UIColor blackColor];
    [addBtn setTitle:@"Add" forState:UIControlStateNormal];
    [addBtn addTarget:self action:@selector(addGrid:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addBtn];
    
    UIButton *deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    deleteBtn.frame = CGRectMake(100, 460, 80, 25);
    deleteBtn.backgroundColor = [UIColor blackColor];
    [deleteBtn setTitle:@"Delete" forState:UIControlStateNormal];
    [deleteBtn addTarget:self action:@selector(deleteGrid:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:deleteBtn];
    
    UIButton *replaceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    replaceBtn.frame = CGRectMake(190, 460, 80, 25);
    replaceBtn.backgroundColor = [UIColor blackColor];
    [replaceBtn setTitle:@"Replace" forState:UIControlStateNormal];
    [replaceBtn addTarget:self action:@selector(replaceGrid:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:replaceBtn];
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
    button.frame=CGRectMake(0, 0, 100, 30);
    [button.layer setCornerRadius:2.0f];
    [button.layer setBorderWidth:1.0f];
    [button.layer setBorderColor:[UIColor purpleColor].CGColor];
    [button setTitle:@"click For Remove" forState:UIControlStateNormal];
    button.tag=(long)button;
    [button addTarget:self action:@selector(removeSelf:) forControlEvents:UIControlEventTouchUpInside];
    [self.verticalLayoutView addSubviewForLayout:button];
}


- (void)addGrid:(id)sender
{
    VSGridCell *cell = [[VSGridCell alloc] initWithFrame:CGRectMake(0, 0, 20, 40)];
    cell.backgroundColor = [UIColor blueColor];
    [_gridView insertCell:cell atIndex:0 animated:YES];
    _gridCount++;
}

- (void)deleteGrid:(id)sender
{
    
    [_gridView removeCellAtIndex:0 animated:YES];
    _gridCount--;
}

- (void)replaceGrid:(id)sender
{
    VSGridCell *cell = [[VSGridCell alloc] initWithFrame:CGRectMake(0, 0, 20, 40)];
    cell.backgroundColor = [UIColor yellowColor];
    [_gridView replaceCell:cell atIndex:0 animated:YES];
    
}

#pragma mark grid datasource
- (NSInteger)numberOfItemsInGridView:(VSGridLayoutScrollView *)gridView
{
    return _gridCount;
}
- (VSGridCell *)gridView:(VSGridLayoutScrollView *)gridView cellForItemAtIndex:(NSInteger)index
{
    VSGridCell *cell = [[VSGridCell alloc] initWithFrame:CGRectMake(0, 0, 90, 50)];
    cell.backgroundColor = [UIColor redColor];
    return cell;
}
- (CGSize )sizeOfItemsInGridView:(VSGridLayoutScrollView *)gridView
{
    return CGSizeMake(90, 50);
}

- (void)gridView:(VSGridLayoutScrollView *)gridView didTapOnItemAtIndex:(NSInteger)index
{
    NSLog(@"%s at index:%d",__func__,index);
}



@end
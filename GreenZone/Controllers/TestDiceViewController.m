//
//  TestDiceViewController.m
//  GreenZone
//
//  Created by student on 15/6/25.
//  Copyright (c) 2015年 student. All rights reserved.
//

#define WinWidth [UIScreen mainScreen].bounds.size.width
#define WinHeight [UIScreen mainScreen].bounds.size.height

#define W(x) WinWidth*x/320.0  //屏幕适配，自动计算不同屏幕对应的x和y方向的坐标
#define H(y) WinHeight*y/568.0
#import "TestDiceViewController.h"
#import "DiceView.h"
@interface TestDiceViewController ()<DiceViewDelegate>

@end

@implementation TestDiceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
    [btn addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    btn.backgroundColor = [UIColor blueColor];
    [self.view addSubview:btn];
}

-(void)click{
    DiceView *view = [DiceView diceViewWithTotalNumber:@3];
    view.center = CGPointMake(WinWidth/2, WinHeight/2);
    view.delegate = self;
    [self.view addSubview:view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)DiceViewStart{
    NSLog(@"开始了");
}

-(void)DiceViewStopWithResult:(NSNumber *)resultNum{
    NSLog(@"结果是:%@",resultNum);
}

@end

//
//  TestMapViewController.m
//  GreenZone
//
//  Created by student on 15/6/30.
//  Copyright (c) 2015年 student. All rights reserved.
//

#import "TestMapViewController.h"

@interface TestMapViewController ()

@end

@implementation TestMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mapView = [[ScrollFreeMapView alloc]initWithMapImage:nil];
    self.mapView.map.frame = CGRectMake(0, 0, 32*13, 32*11);
    self.mapView.backgroundColor = [UIColor whiteColor];
    [self createMap];
    self.mapView.mapMoveArray = self.mapArr;
    [self.mapView CharacterWithLocation:CGPointMake(32, 64) withCharacterDirection:CharacterMoveDown withCharacterImageName:@"$Magie"];
    self.mapView.frame = CGRectMake(100, 100, 200, 200);
    [self.view addSubview:self.mapView];
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(100, 400, 100, 50)];
    btn.backgroundColor = [UIColor redColor];
    [btn addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

-(void)click{
    int stepNum = arc4random_uniform(6);
    //[self.mapView moveWithStepNum:[NSNumber numberWithInt:stepNum]];
}

-(NSArray *)mapArr{
    if (!_mapArr) {
        _mapArr = @[@0,@0,@0,@0,@0,@0,@0,@0,@0,@0,@0,@0,@0,
                    @0,@3,@1,@1,@1,@1,@1,@1,@1,@1,@1,@3,@0,
                    @0,@1,@0,@0,@0,@0,@0,@0,@0,@0,@0,@1,@0,
                    @0,@1,@0,@0,@0,@0,@0,@0,@0,@0,@3,@3,@0,
                    @0,@1,@0,@0,@0,@0,@0,@0,@0,@0,@1,@0,@0,
                    @0,@1,@0,@0,@0,@0,@0,@0,@3,@1,@3,@0,@0,
                    @0,@1,@0,@0,@0,@0,@0,@0,@1,@0,@0,@0,@0,
                    @0,@3,@1,@1,@1,@2,@1,@1,@2,@0,@0,@0,@0,
                    @0,@0,@0,@0,@0,@1,@0,@0,@1,@0,@0,@0,@0,
                    @0,@0,@0,@0,@0,@3,@1,@1,@3,@0,@0,@0,@0,
                    @0,@0,@0,@0,@0,@0,@0,@0,@0,@0,@0,@0,@0,
                    ];
    }
    return _mapArr;
}

-(void)createMap{
    for (int row = 0; row<11; row++) {
        for (int col = 0; col<13; col++) {
            UILabel *labelView = [[UILabel alloc]initWithFrame:CGRectMake(col*32, row*32, 32, 32)];
            labelView.layer.borderColor = [UIColor redColor].CGColor;
            labelView.layer.borderWidth = 0.5;
            labelView.textAlignment = NSTextAlignmentCenter;
            labelView.text = [NSString stringWithFormat:@"%@", self.mapArr[row*13+col]];
            [self.mapView.map addSubview:labelView];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end

//
//  MakeMapViewController.m
//  GreenZone
//
//  Created by student on 15/6/24.
//  Copyright (c) 2015年 student. All rights reserved.
//

#import "MakeMapViewController.h"
#import "ImageClip.h"
#import "MapZoneViewController.h"
#import "CharacterMove.h"
#import "ScrollMapView.h"
@interface MakeMapViewController ()<CharacterMoveDelegate>

@end

@implementation MakeMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mapView.bounces = NO;
    self.mapView.showsHorizontalScrollIndicator = NO;
    self.mapView.showsVerticalScrollIndicator = NO;
    self.mapView.layer.borderColor = [UIColor blackColor].CGColor;
    self.mapView.layer.borderWidth = 0.5;
    self.mapView.scrollEnabled = NO;
    [self createMap];
    //[self mapArr];
    self.mapView.contentSize = self.map.bounds.size;
    [self.mapView addSubview:self.map];
    UIImageView *characterView = [[UIImageView alloc]initWithFrame:CGRectMake(32, 32*3, 32, 32)];
    [self.map addSubview:characterView];
    self.character = [[CharacterMove alloc]initWithView:characterView withDirection:CharacterMoveDown withCharacterImageName:@"$Magie"];
    self.character.delegate = self;
    self.character.mapView = self.mapView;
    self.character.characterName = @"$Magie";
    self.character.contentOffset = CGPointMake(0, 0);
    self.lastCheckPoint = CGPointZero;
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
    self.map = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 32*13, 32*11)];
    for (int row = 0; row<11; row++) {
        for (int col = 0; col<13; col++) {
            UILabel *labelView = [[UILabel alloc]initWithFrame:CGRectMake(col*32, row*32, 32, 32)];
            labelView.layer.borderColor = [UIColor redColor].CGColor;
            labelView.layer.borderWidth = 0.5;
            labelView.textAlignment = NSTextAlignmentCenter;
            labelView.text = [NSString stringWithFormat:@"%@", self.mapArr[row*13+col]];
            [self.map addSubview:labelView];
        }
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)jumpToMapZone:(id)sender {
    self.character.characterDirection = CharacterMoveDown;
    [self.character characterMove];
}

- (IBAction)up:(id)sender {
    self.character.characterDirection = CharacterMoveUp;
    [self.character characterMove];
}

- (IBAction)right:(id)sender {
    self.character.characterDirection = CharacterMoveRight;
    [self.character characterMove];
}

- (IBAction)down:(id)sender {
    self.character.characterDirection = CharacterMoveLeft;
    [self.character characterMove];
}

- (IBAction)stop:(id)sender {
    self.stepNum = arc4random()%6+1;
    NSLog(@"%i",self.stepNum);
}

-(void)CharacterMoveEndAtPoint:(CGPoint)point{
    if (point.x!=self.lastCheckPoint.x||point.y!=self.lastCheckPoint.y) {
        int row=0;
        int col=0;
        if ((int)point.x%32==0&&(self.character.characterDirection==CharacterMoveLeft||self.character.characterDirection==CharacterMoveRight)) {
            self.stepNum--;
            col = point.x/32;
            row = point.y/32;
            [self checkPoint:point];
        }
        if ((int)point.y%32==0&&(self.character.characterDirection==CharacterMoveUp||self.character.characterDirection==CharacterMoveDown)) {
            self.stepNum--;
            col = point.x/32;
            row = point.y/32;
            [self checkPoint:point];
        }
        if (self.stepNum <= 0&&row!=0&&col!=0) {
            [self.character characterStopMove];
            NSLog(@"%i,%i",row,col);
        }
    }
}

-(void)checkPoint:(CGPoint)point{
    if (point.x!=self.lastCheckPoint.x||point.y!=self.lastCheckPoint.y) {
        int row=point.y/32,col=point.x/32;
        NSNumber *markNum = self.mapArr[row*13+col];
        NSNumber *markNumUp = self.mapArr[(row-1)*13+col];
        NSNumber *markNumDown = self.mapArr[(row+1)*13+col];
        NSNumber *markNumLeft = self.mapArr[row*13+col-1];
        NSNumber *markNumRight = self.mapArr[row*13+col+1];
        if ([markNum intValue]==3) {
            [self.character characterStopMove];
            if (self.character.characterDirection==CharacterMoveDown||self.character.characterDirection==CharacterMoveUp) {
                if ([markNumLeft intValue]!=0) {
                    self.character.characterDirection = CharacterMoveLeft;
                }
                if ([markNumRight intValue]!=0) {
                    self.character.characterDirection = CharacterMoveRight;
                }
            }
            else{
                if ([markNumUp intValue]!=0) {
                    self.character.characterDirection = CharacterMoveUp;
                }
                if ([markNumDown intValue]!=0) {
                    self.character.characterDirection = CharacterMoveDown;
                }
            }
            [self.character characterMove];
        }
        if ([markNum intValue]==2) {
            [self.character characterStopMove];
        }
        self.lastCheckPoint = point;
    }
}


-(void)CharacterMoveStart{
    
}
@end

//
//  MakeMapViewController.h
//  GreenZone
//
//  Created by student on 15/6/24.
//  Copyright (c) 2015年 student. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CharacterMove;

@interface MakeMapViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIScrollView *mapView;

@property(nonatomic,assign) int stepNum;
@property(nonatomic,strong) UIView *map;
@property(nonatomic,strong) NSArray *mapArr;
@property(nonatomic,assign) CGPoint lastCheckPoint;
@property(nonatomic,strong) CharacterMove *character;

- (IBAction)jumpToMapZone:(id)sender;
- (IBAction)up:(id)sender;
- (IBAction)right:(id)sender;
- (IBAction)down:(id)sender;
- (IBAction)stop:(id)sender;
@end

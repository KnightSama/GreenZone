//
//  TestViewController.h
//  GreenZone
//
//  Created by student on 15/6/23.
//  Copyright (c) 2015年 student. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CharacterMove;
@interface TestViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *nView;
@property(nonatomic,assign) BOOL isContinue;
@property(nonatomic,strong) NSTimer *timer;
@property(nonatomic,assign) CGFloat lastValue;
@property(nonatomic,strong) CharacterMove *character;
- (IBAction)up:(id)sender;
- (IBAction)left:(id)sender;
- (IBAction)right:(id)sender;
- (IBAction)down:(id)sender;
- (IBAction)stop:(id)sender;



@end

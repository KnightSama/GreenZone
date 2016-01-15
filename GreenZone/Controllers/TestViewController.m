//
//  TestViewController.m
//  GreenZone
//
//  Created by student on 15/6/23.
//  Copyright (c) 2015年 student. All rights reserved.
//

#import "TestViewController.h"
#import "ImageClip.h"
#import "UnReadBubbleView.h"
#import "CharacterMove.h"

#define WinWidth [UIScreen mainScreen].bounds.size.width
#define WinHeight [UIScreen mainScreen].bounds.size.height

#define W(x) WinWidth*x/320.0  //屏幕适配，自动计算不同屏幕对应的x和y方向的坐标
#define H(y) WinHeight*y/568.0

@interface TestViewController ()<UIGestureRecognizerDelegate,UnReadBubbleViewDelegate>{
    UnReadBubbleView *bubble;
}

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //NSString *path = [[NSBundle mainBundle]pathForResource:@"IMG_0152" ofType:@"jpg"];
    //self.oView.image = [UIImage imageWithContentsOfFile:path];
//    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(changeDirection:)];
//    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(changeDirection2:)];
//    [self.view addGestureRecognizer:panGesture];
    self.nView.frame = CGRectMake(0, 0, 32, 32);
    self.nView.center = CGPointMake(WinWidth/2, WinHeight/2);
    self.character = [[CharacterMove alloc]initWithView:self.nView withDirection:CharacterMoveUp withCharacterImageName:@""];
    self.character.characterName = @"$Magie";
    [self.character characterMoveAnimationStop];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)up:(id)sender {
    [self.character characterStopMove];
    self.character.characterDirection = CharacterMoveUp;
    [self.character characterMove];
}

- (IBAction)left:(id)sender {
    [self.character characterStopMove];
    self.character.characterDirection = CharacterMoveLeft;
    [self.character characterMove];
}

- (IBAction)right:(id)sender {
    [self.character characterStopMove];
    self.character.characterDirection = CharacterMoveRight;
    [self.character characterMove];
}

- (IBAction)down:(id)sender {
    [self.character characterStopMove];
    self.character.characterDirection = CharacterMoveDown;
    [self.character characterMove];
}

- (IBAction)stop:(id)sender {
    [self.character characterStopMove];
}































//- (IBAction)draw:(id)sender {
////    NSString *path = [[NSBundle mainBundle]pathForResource:@"IMG_0152" ofType:@"jpg"];
////    UIImage *image = [UIImage imageWithContentsOfFile:path];
////    //UIImage *image = [UIImage imageNamed:@"IMG_0152"];
//////    UIGraphicsBeginImageContext(image.size);
////    CGRect rect = CGRectMake(0, 0, image.size.width, image.size.height/2);
//////    CGContextClipToRect(UIGraphicsGetCurrentContext(), rect);
//////    //CGContextDrawImage(UIGraphicsGetCurrentContext(), rect, UIGraphicsGetImageFromCurrentImageContext().CGImage);
//////    self.nView.image = UIGraphicsGetImageFromCurrentImageContext();
//////    UIGraphicsEndImageContext();
////    
////    CGImageRef subImageRef = CGImageCreateWithImageInRect(image.CGImage, rect);
////    CGRect smallBounds = CGRectMake(0, 0, CGImageGetWidth(subImageRef), CGImageGetHeight(subImageRef));
////    UIGraphicsBeginImageContext(smallBounds.size);
////    CGContextRef context = UIGraphicsGetCurrentContext();
////    CGContextDrawImage(context, smallBounds, subImageRef);
////    UIImage* smallImage = [UIImage imageWithCGImage:subImageRef];
////    self.nView.image = smallImage;
////    UIGraphicsEndImageContext();
//    
//    UIImage *image = [UIImage imageNamed:@"$Magie"];
//    //CGRect rect = CGRectMake(0, 0, image.size.width/3, image.size.height/4);
//    CGSize size = CGSizeMake(image.size.width/3, image.size.height/4);
//    NSMutableArray *frontArr = [[NSMutableArray alloc]init];
//    NSMutableArray *leftArr = [[NSMutableArray alloc]init];
//    NSMutableArray *rightArr = [[NSMutableArray alloc]init];
//    NSMutableArray *backArr = [[NSMutableArray alloc]init];
//    for (int i=0; i<3; i++) {
//        CGRect rect = CGRectMake(i*size.width, 0, size.width,size.height);
//        UIImage *nimage = [ImageClip imageWithImage:image clipByRect:rect];
//        [frontArr addObject:nimage];
//    }
//    for (int i=0; i<3; i++) {
//        CGRect rect = CGRectMake(i*size.width, size.height, size.width,size.height);
//        UIImage *nimage = [ImageClip imageWithImage:image clipByRect:rect];
//        [leftArr addObject:nimage];
//    }
//    for (int i=0; i<3; i++) {
//        CGRect rect = CGRectMake(i*size.width, size.height*2, size.width,size.height);
//        UIImage *nimage = [ImageClip imageWithImage:image clipByRect:rect];
//        [rightArr addObject:nimage];
//    }
//    for (int i=0; i<3; i++) {
//        CGRect rect = CGRectMake(i*size.width, size.height*3, size.width,size.height);
//        UIImage *nimage = [ImageClip imageWithImage:image clipByRect:rect];
//        [backArr addObject:nimage];
//    }
//    //self.nView.image = [ImageClip imageWithImage:image clipByRect:rect];
//    self.nView.image = frontArr[0];
//    self.nView.animationImages = frontArr;
//    self.nView.animationRepeatCount = NSNotFound;
//    self.nView.animationDuration = 0.5;
//    //[self.nView startAnimating];
//}


//
//-(void)changeDirection2:(UIPanGestureRecognizer *)panGesture{
//    if (bubble) {
//        [bubble dragMe:panGesture];
//    }
//    CGPoint point = [panGesture translationInView:self.view];
//    UIImage *image = [UIImage imageNamed:@"$Magie"];
//    CGSize size = CGSizeMake(image.size.width/3, image.size.height/4);
//    NSMutableArray *frontArr = [[NSMutableArray alloc]init];
//    NSMutableArray *leftArr = [[NSMutableArray alloc]init];
//    NSMutableArray *rightArr = [[NSMutableArray alloc]init];
//    NSMutableArray *backArr = [[NSMutableArray alloc]init];
//    for (int i=0; i<3; i++) {
//        CGRect rect = CGRectMake(i*size.width, 0, size.width,size.height);
//        UIImage *nimage = [ImageClip imageWithImage:image clipByRect:rect];
//        [frontArr addObject:nimage];
//    }
//    [frontArr addObject:frontArr[0]];
//    [frontArr removeObjectAtIndex:0];
//    
//    for (int i=0; i<3; i++) {
//        CGRect rect = CGRectMake(i*size.width, size.height, size.width,size.height);
//        UIImage *nimage = [ImageClip imageWithImage:image clipByRect:rect];
//        [leftArr addObject:nimage];
//    }
//    for (int i=0; i<3; i++) {
//        CGRect rect = CGRectMake(i*size.width, size.height*2, size.width,size.height);
//        UIImage *nimage = [ImageClip imageWithImage:image clipByRect:rect];
//        [rightArr addObject:nimage];
//    }
//    for (int i=0; i<3; i++) {
//        CGRect rect = CGRectMake(i*size.width, size.height*3, size.width,size.height);
//        UIImage *nimage = [ImageClip imageWithImage:image clipByRect:rect];
//        [backArr addObject:nimage];
//    }
//    [backArr addObject:backArr[0]];
//    [backArr removeObjectAtIndex:0];
//
//    if (panGesture.state == UIGestureRecognizerStateBegan) {
//        if (!bubble) {
//            bubble = [[UnReadBubbleView alloc]initWithFrame:CGRectMake(point.x-15, point.y-15, 35, 35)];
//            [self.view addSubview:bubble];
//        }
//
//    }
//    if (panGesture.state == UIGestureRecognizerStateChanged) {
//        if (point.y<0&&self.lastValue>=0) {
//            [self.timer invalidate];
//            [self.nView stopAnimating];
//            self.lastValue = point.y;
//            self.nView.image = backArr[0];
//            self.nView.animationImages = backArr;
//            [self.nView startAnimating];
//            self.timer = [NSTimer scheduledTimerWithTimeInterval:0.5/20 target:self selector:@selector(goFront) userInfo:nil repeats:YES];
//            CABasicAnimation *animation=[CABasicAnimation animationWithKeyPath:@"position"];
//            //2.2动画的起始位置
//            CGPoint toPoint=self.nView.center;
//            toPoint.y=0;
//            //2.3动画的目标位置
//
//            animation.byValue = [NSValue valueWithCGVector:CGVectorMake(0, -1)];
//            animation.duration=0.5/20;//动画的持续时间
//            animation.repeatCount=1;//一直执行动画
//            animation.removedOnCompletion = NO;
//            animation.fillMode = kCAFillModeForwards;
//            animation.delegate = self;
//            //2.4把动画添加到图层
//            [self.nView.layer addAnimation:animation forKey:nil];
//            self.nView.center = CGPointMake(self.nView.center.x, self.nView.center.y-1);
//            
//        }
//        
//        if (point.y>0&&self.lastValue<=0) {
//            [self.timer invalidate];
//            [self.nView stopAnimating];
//            self.lastValue = point.y;
//            self.nView.image = frontArr[0];
//            self.nView.animationImages = frontArr;
//            [self.nView startAnimating];
//            self.timer = [NSTimer scheduledTimerWithTimeInterval:0.5/20 target:self selector:@selector(goBack) userInfo:nil repeats:YES];
//
//            CABasicAnimation *animation=[CABasicAnimation animationWithKeyPath:@"position"];
//            //2.2动画的起始位置
//
//            CGPoint toPoint=self.nView.center;
//            toPoint.y=0;
//            //2.3动画的目标位置
//
//            animation.byValue = [NSValue valueWithCGVector:CGVectorMake(0, 1)];
//            animation.duration=0.5/20;//动画的持续时间
//            animation.repeatCount=1;//一直执行动画
//            animation.removedOnCompletion = NO;
//            animation.fillMode = kCAFillModeForwards;
//            animation.delegate = self;
//            //2.4把动画添加到图层
//            [self.nView.layer addAnimation:animation forKey:nil];
//            self.nView.center = CGPointMake(self.nView.center.x, self.nView.center.y+1);
//        }
//    }
//    if (panGesture.state == UIGestureRecognizerStateEnded) {
//        [self.timer invalidate];
//        [self.nView stopAnimating];
//        self.lastValue = 0;
//    }
//}
//
//-(void)goFront{
//    CABasicAnimation *animation=[CABasicAnimation animationWithKeyPath:@"position"];
//    //2.2动画的起始位置
//    animation.fromValue=[NSValue valueWithCGPoint:self.nView.center];
//    CGPoint toPoint=self.nView.center;
//    toPoint.y=0;
//    //2.3动画的目标位置
//
//    animation.byValue = [NSValue valueWithCGVector:CGVectorMake(0, -1)];
//    animation.duration=0.5/20;//动画的持续时间
//    animation.repeatCount=1;//一直执行动画
//    animation.delegate = self;
//    //2.4把动画添加到图层
//    [self.nView.layer addAnimation:animation forKey:nil];
//
//    self.nView.center = CGPointMake(self.nView.center.x, self.nView.center.y-1);
//}
//
//-(void)goBack{
//    CABasicAnimation *animation=[CABasicAnimation animationWithKeyPath:@"position"];
//    //2.2动画的起始位置
//    animation.fromValue=[NSValue valueWithCGPoint:self.nView.center];
//    CGPoint toPoint=self.nView.center;
//    toPoint.y=0;
//    //2.3动画的目标位置
//    animation.byValue = [NSValue valueWithCGVector:CGVectorMake(0, 1)];
//    animation.duration=0.5/20;//动画的持续时间
//    animation.repeatCount=1;//一直执行动画
//    animation.delegate = self;
//    //2.4把动画添加到图层
//    [self.nView.layer addAnimation:animation forKey:nil];
//    self.nView.center = CGPointMake(self.nView.center.x, self.nView.center.y+1);
//}


@end

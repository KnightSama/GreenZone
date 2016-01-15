//
//  DiceView.m
//  GreenZone
//
//  Created by zqh on 15/6/25.
//  Copyright (c) 2015年 student. All rights reserved.
//

#import "DiceView.h"
#import "ImageClip.h"
/**
 *  色子的宽度
 */
#define DiceWidth 45
/**
 *  色子的间隔
 */
#define DiceSpacing 15
@implementation DiceView

/**
 *  通过色子总数初始化视图
 */
+ (instancetype)diceViewWithTotalNumber:(NSNumber *)totalNum{
    DiceView *diceView = [[[NSBundle mainBundle]loadNibNamed:@"DiceView" owner:self options:nil]lastObject];
    diceView.totalNumber = totalNum;
    diceView.showNumber = @1;
    if ([diceView.showNumber intValue] == [diceView.totalNumber intValue]) {
        diceView.addBtn.enabled = NO;
    }
    diceView.reduceBtn.enabled = NO;
    [diceView reloadDice];
    return diceView;
}

-(NSArray *)diceImageArr{
    if (!_diceImageArr) {
        _diceImageArr = @[@"1@2x",@"2@2x",@"3@2x",@"4@2x",@"5@2x",@"6@2x"];
    }
    return _diceImageArr;
}

-(NSArray *)animationArr{
    if (!_animationArr) {
        UIImage *image1 = [ImageClip imageWithPngName:@"dong1@2x"];
        UIImage *image2 = [ImageClip imageWithPngName:@"dong2@2x"];
        UIImage *image3 = [ImageClip imageWithPngName:@"dong3@2x"];
        _animationArr = @[image1,image2,image3];
    }
    return _animationArr;
}

-(void)awakeFromNib{
}

/**
 *  重置色子数量的方法
 */
-(void)reloadDice{
    for (UIImageView *view in self.diceView.subviews) {
        [view removeFromSuperview];
    }
    UIImage *image = [ImageClip imageWithPngName:self.diceImageArr[5]];
    if ([self.showNumber intValue]==1) {
        [self addDiceWithImage:image atPoint:CGPointMake(60, 0)];
    }else if ([self.showNumber intValue]==2){
        [self addDiceWithImage:image atPoint:CGPointMake(30, 0)];
        [self addDiceWithImage:image atPoint:CGPointMake(90, 0)];
    }else{
        for (int num = 0; num<[self.showNumber intValue]; num++) {
            [self addDiceWithImage:image atPoint:CGPointMake(num*(DiceWidth+DiceSpacing), 0)];
        }
    }
}

/**
 *  在指定位置添加色子
 */
-(void)addDiceWithImage:(UIImage *)image atPoint:(CGPoint)point{
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(point.x,point.y, DiceWidth, DiceWidth)];
    imageView.image = image;
    [self.diceView addSubview:imageView];
}


- (IBAction)reduceDice:(id)sender {
    self.showNumber = [NSNumber numberWithInt:([self.showNumber intValue]-1)];
    if (self.showNumber<self.totalNumber) {
        self.addBtn.enabled = YES;
    }
    if ([self.showNumber intValue]==1) {
        self.reduceBtn.enabled = NO;
    }
    [self reloadDice];
}

- (IBAction)addDice:(id)sender {
    self.showNumber = [NSNumber numberWithInt:([self.showNumber intValue]+1)];
    if (self.showNumber==self.totalNumber) {
        self.addBtn.enabled = NO;
    }
    if ([self.showNumber intValue]>1) {
        self.reduceBtn.enabled = YES;
    }
    [self reloadDice];
}

- (IBAction)startDice:(id)sender {
    if (self.delegate &&[self.delegate respondsToSelector:@selector(DiceViewStart)]) {
        [self.delegate DiceViewStart];
    }
    self.startBtn.enabled = NO;
    self.addBtn.enabled = NO;
    self.reduceBtn.enabled = NO;
    [self startAnimating];
}

/**
 *  为当前显示的色子添加动画
 */
- (void)startAnimating{
    BOOL timeMark = YES;
    for (UIImageView *imageView in self.diceView.subviews) {
        /**
         *  添加自身的动画
         */
        imageView.image = self.animationArr[0];
        imageView.animationImages = self.animationArr;
        imageView.animationDuration = 0.2;
        imageView.animationRepeatCount = NSNotFound;
        /**
         *  添加旋转动画
         */
        if (timeMark) {
            CABasicAnimation *spin = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
            [spin setToValue:[NSNumber numberWithFloat:M_PI * 0]];
            [spin setDuration:2];
            spin.delegate = self;
            [imageView.layer addAnimation:spin forKey:nil];
            timeMark = NO;
        }
        [imageView startAnimating];
    }
}

-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    int totalResult = 0;
    for (UIImageView *imageView in self.diceView.subviews) {
        [imageView stopAnimating];
        int result = arc4random_uniform(6);
        UIImage *image = [ImageClip imageWithPngName:self.diceImageArr[result]];
        imageView.image = image;
        totalResult+=result+1;
    }
    if (self.delegate&&[self.delegate respondsToSelector:@selector(DiceViewStopWithResult:)]) {
        [self.delegate DiceViewStopWithResult:[NSNumber numberWithInt:totalResult]];
    }
}
@end

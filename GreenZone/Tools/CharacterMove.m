//
//  CharacterMove.m
//  GreenZone
//
//  Created by zqh on 15/6/26.
//  Copyright (c) 2015年 student. All rights reserved.
//

#import "CharacterMove.h"
#import "ImageClip.h"

/**
 *  默认人物与地图块的宽度
 */
#define MapW 32

@implementation CharacterMove

-(NSArray *)mapPassArray{
    if (!_mapPassArray) {
        _mapPassArray = [[NSArray alloc]init];
    }
    return _mapPassArray;
}

/**
 *  通过初始坐标与角色所在View与方向初始化
 */
-(instancetype)initWithView:(UIImageView *)view withDirection:(direction)characterDir withCharacterImageName:(NSString *)imageName{
    if (self=[super init]) {
        self.characterName = imageName;
        self.characterView = view;
        self.currentPoint = self.characterView.frame.origin;
        self.characterDirection = characterDir;
        self.characterView.image = [self characterImageWithDirection:self.characterDirection];
    }
    return self;
}

/**
 *  显示原地行进动画
 */
-(void)characterMoveAnimationStart{
    NSArray *animatingArr = [self animatingImageArrWithDirection:self.characterDirection];
    self.characterView.animationImages = animatingArr;
    self.characterView.animationDuration = 0.5;
    self.characterView.animationRepeatCount = NSNotFound;
    [self.characterView startAnimating];
}

/**
 *  关闭原地行进的动画
 */
-(void)characterMoveAnimationStop{
    [self.characterView stopAnimating];
    self.characterView.image = [self characterImageWithDirection:self.characterDirection];
}


/**
 *  向当前方向一直前进
 */
-(void)characterMove{
    if (self.delegate && [self.delegate respondsToSelector:@selector(characterMoveAnimationStart)]) {
        [self.delegate CharacterMoveStart];
    }
    self.isCanMove = YES;
    switch (self.characterDirection) {
        case CharacterMoveUp:
            [self startGoUp];
            break;
        case CharacterMoveDown:
            [self startGoDown];
            break;
        case CharacterMoveLeft:
            [self startGoLeft];
            break;
        case CharacterMoveRight:
            [self startGoRight];
            break;
        default:
            break;
    }
}

/**
 *  停止前进
 */
-(void)characterStopMove{
    self.isCanMove = NO;
    [self.timer invalidate];
    [self.characterView.layer removeAllAnimations];
    [self.characterView stopAnimating];
    self.characterView.image = [self characterImageWithDirection:self.characterDirection];
}

/**
 *  通行性检测 0 不可通行  1 可通行  2分支路口
 */
-(void)checkIfCanPass{
    int colNum = self.characterView.superview.frame.size.width/32;
    int row,col;
    if (self.characterDirection==CharacterMoveDown) {
        row=(self.currentPoint.y+32)/32;
        col=self.currentPoint.x/32;
        if (self.currentPoint.y+32>=self.characterView.superview.frame.size.height||[self.mapPassArray[row*colNum+col] intValue]==0) {
            self.isCanMove = NO;
        }
    }
    if (self.characterDirection==CharacterMoveLeft) {
        row=self.currentPoint.y/32;
        col=(self.currentPoint.x)/32;
        if (self.currentPoint.x<=0||[self.mapPassArray[row*colNum+col] intValue]==0) {
            self.isCanMove = NO;
        }
    }
    if (self.characterDirection==CharacterMoveRight) {
        row=self.currentPoint.y/32;
        col=(self.currentPoint.x+32)/32;
        if (self.currentPoint.x+32>=self.characterView.superview.frame.size.width||[self.mapPassArray[row*colNum+col] intValue]==0) {
            self.isCanMove = NO;
        }
    }
    if (self.characterDirection==CharacterMoveUp) {
        row=(self.currentPoint.y)/32;
        col=self.currentPoint.x/32;
        if (self.currentPoint.y<=0||[self.mapPassArray[row*colNum+col] intValue]==0) {
            self.isCanMove = NO;
        }
    }
    if (!self.isCanMove) {
        if (self.delegate&&[self.delegate respondsToSelector:@selector(CharacterMoveCannotMoveAtPoint:WithDirection:)]) {
            [self.delegate CharacterMoveCannotMoveAtPoint:self.currentPoint WithDirection:self.characterDirection];
        }
    }
}

/**
 *  由前进的方向取到人物图片数组
 */
-(NSArray *)animatingImageArrWithDirection:(direction)characterDir{
    NSMutableArray *tmpArr = [[NSMutableArray alloc]init];
    UIImage *image = [ImageClip imageWithPngName:self.characterName];
    switch (characterDir) {
        case CharacterMoveUp:{
            for (int i=0; i<3; i++) {
                CGRect rect = CGRectMake(i*MapW,MapW*3, MapW,MapW);
                UIImage *nimage = [ImageClip imageWithImage:image clipByRect:rect];
                [tmpArr addObject:nimage];
            }
            break;
        }
        case CharacterMoveDown:{
            for (int i=0; i<3; i++) {
                CGRect rect = CGRectMake(i*MapW,0, MapW,MapW);
                UIImage *nimage = [ImageClip imageWithImage:image clipByRect:rect];
                [tmpArr addObject:nimage];
            }
            break;
        }
        case CharacterMoveLeft:{
            for (int i=0; i<3; i++) {
                CGRect rect = CGRectMake(i*MapW,MapW, MapW,MapW);
                UIImage *nimage = [ImageClip imageWithImage:image clipByRect:rect];
                [tmpArr addObject:nimage];
            }
            break;
        }
        default:{
            for (int i=0; i<3; i++) {
                CGRect rect = CGRectMake(i*MapW,MapW*2, MapW,MapW);
                UIImage *nimage = [ImageClip imageWithImage:image clipByRect:rect];
                [tmpArr addObject:nimage];
            }
            break;
        }
    }
    return tmpArr;
}

/**
 *  由前进的方向取到人物静止图片
 */
-(UIImage *)characterImageWithDirection:(direction)characterDir{
    UIImage *image = [ImageClip imageWithPngName:self.characterName];
    UIImage *resultImage = [[UIImage alloc]init];
    switch (characterDir) {
        case CharacterMoveUp:{
            CGRect rect = CGRectMake(MapW,MapW*3, MapW,MapW);
            resultImage = [ImageClip imageWithImage:image clipByRect:rect];
            break;
        }
        case CharacterMoveDown:{
            CGRect rect = CGRectMake(MapW,0, MapW,MapW);
            resultImage = [ImageClip imageWithImage:image clipByRect:rect];
            break;
        }
        case CharacterMoveLeft:{
            CGRect rect = CGRectMake(MapW,MapW, MapW,MapW);
            resultImage = [ImageClip imageWithImage:image clipByRect:rect];
            break;
        }
        default:{
            CGRect rect = CGRectMake(MapW,MapW*2, MapW,MapW);
            resultImage = [ImageClip imageWithImage:image clipByRect:rect];
            break;
        }
    }
    return resultImage;
}

/**
 *  开始向上行走的方法
 */
-(void)startGoUp{
    [self.timer invalidate];
    [self characterMoveAnimationStop];
    [self characterMoveAnimationStart];
    [self checkIfCanPass];
    if (self.isCanMove) {
        if ([self checkIfCanMoveMap]) {
            [self moveMap];
        }
        self.timer = [NSTimer scheduledTimerWithTimeInterval:0.025 target:self selector:@selector(goUp) userInfo:nil repeats:YES];
        CABasicAnimation *animation=[CABasicAnimation animationWithKeyPath:@"position"];
        animation.byValue = [NSValue valueWithCGVector:CGVectorMake(0, -1)];
        animation.duration=0.025;
        animation.repeatCount=1;
        animation.delegate = self;
        [self.characterView.layer addAnimation:animation forKey:nil];
        self.currentPoint = CGPointMake(self.currentPoint.x, self.currentPoint.y-1);
        self.characterView.frame = CGRectMake(self.currentPoint.x, self.currentPoint.y-1, MapW, MapW);
    }
}
/**
 *  向上行走的方法
 */
-(void)goUp{
    [self checkIfCanPass];
    if(self.isCanMove){
        if ([self checkIfCanMoveMap]) {
            [self moveMap];
        }
        CABasicAnimation *animation=[CABasicAnimation animationWithKeyPath:@"position"];
        animation.byValue = [NSValue valueWithCGVector:CGVectorMake(0, -1)];
        animation.duration=0.025;
        animation.repeatCount=1;
        animation.delegate = self;
        [self.characterView.layer addAnimation:animation forKey:nil];
        self.currentPoint = CGPointMake(self.currentPoint.x, self.currentPoint.y-1);
        self.characterView.frame = CGRectMake(self.currentPoint.x, self.currentPoint.y-1, MapW, MapW);
    }
}

/**
 *  开始向下行走的方法
 */
-(void)startGoDown{
    [self.timer invalidate];
    [self characterMoveAnimationStop];
    [self characterMoveAnimationStart];
    [self checkIfCanPass];
    if (self.isCanMove) {
        if ([self checkIfCanMoveMap]) {
            [self moveMap];
        }
        self.timer = [NSTimer scheduledTimerWithTimeInterval:0.025 target:self selector:@selector(goDown) userInfo:nil repeats:YES];
        CABasicAnimation *animation=[CABasicAnimation animationWithKeyPath:@"position"];
        animation.byValue = [NSValue valueWithCGVector:CGVectorMake(0, 1)];
        animation.duration=0.025;
        animation.repeatCount=1;
        animation.delegate = self;
        [self.characterView.layer addAnimation:animation forKey:nil];
        self.currentPoint = CGPointMake(self.currentPoint.x, self.currentPoint.y+1);
        self.characterView.frame = CGRectMake(self.currentPoint.x, self.currentPoint.y+1, MapW, MapW);
    }
}
/**
 *  向下行走的方法
 */
-(void)goDown{
    [self checkIfCanPass];
    if(self.isCanMove){
        if ([self checkIfCanMoveMap]) {
            [self moveMap];
        }
        CABasicAnimation *animation=[CABasicAnimation animationWithKeyPath:@"position"];
        animation.byValue = [NSValue valueWithCGVector:CGVectorMake(0, 1)];
        animation.duration=0.025;
        animation.repeatCount=1;
        animation.delegate = self;
        [self.characterView.layer addAnimation:animation forKey:nil];
        self.currentPoint = CGPointMake(self.currentPoint.x, self.currentPoint.y+1);
        self.characterView.frame = CGRectMake(self.currentPoint.x, self.currentPoint.y+1, MapW, MapW);
    }
}

/**
 *  开始向右行走的方法
 */
-(void)startGoRight{
    [self.timer invalidate];
    [self characterMoveAnimationStop];
    [self characterMoveAnimationStart];
    [self checkIfCanPass];
    if (self.isCanMove) {
        if ([self checkIfCanMoveMap]) {
            [self moveMap];
        }
        self.timer = [NSTimer scheduledTimerWithTimeInterval:0.025 target:self selector:@selector(goRight) userInfo:nil repeats:YES];
        CABasicAnimation *animation=[CABasicAnimation animationWithKeyPath:@"position"];
        animation.byValue = [NSValue valueWithCGVector:CGVectorMake(1, 0)];
        animation.duration=0.025;
        animation.repeatCount=1;
        animation.delegate = self;
        [self.characterView.layer addAnimation:animation forKey:nil];
        self.currentPoint = CGPointMake(self.currentPoint.x+1, self.currentPoint.y);
        self.characterView.frame = CGRectMake(self.currentPoint.x+1, self.currentPoint.y, MapW, MapW);
    }
}
/**
 *  向右行走的方法
 */
-(void)goRight{
    [self checkIfCanPass];
    if(self.isCanMove){
        if ([self checkIfCanMoveMap]) {
            [self moveMap];
        }
        CABasicAnimation *animation=[CABasicAnimation animationWithKeyPath:@"position"];
        animation.byValue = [NSValue valueWithCGVector:CGVectorMake(1, 0)];
        animation.duration=0.025;
        animation.repeatCount=1;
        animation.delegate = self;
        [self.characterView.layer addAnimation:animation forKey:nil];
        self.currentPoint = CGPointMake(self.currentPoint.x+1, self.currentPoint.y);
        self.characterView.frame = CGRectMake(self.currentPoint.x+1, self.currentPoint.y, MapW, MapW);
    }
}

/**
 *  开始向左行走的方法
 */
-(void)startGoLeft{
    [self.timer invalidate];
    [self characterMoveAnimationStop];
    [self characterMoveAnimationStart];
    [self checkIfCanPass];
    if (self.isCanMove) {
        if ([self checkIfCanMoveMap]) {
            [self moveMap];
        }
        self.timer = [NSTimer scheduledTimerWithTimeInterval:0.025 target:self selector:@selector(goLeft) userInfo:nil repeats:YES];
        CABasicAnimation *animation=[CABasicAnimation animationWithKeyPath:@"position"];
        animation.byValue = [NSValue valueWithCGVector:CGVectorMake(-1, 0)];
        animation.duration=0.025;
        animation.repeatCount=1;
        animation.delegate = self;
        [self.characterView.layer addAnimation:animation forKey:nil];
        self.currentPoint = CGPointMake(self.currentPoint.x-1, self.currentPoint.y);
        self.characterView.frame = CGRectMake(self.currentPoint.x-1, self.currentPoint.y, MapW, MapW);
    }
}
/**
 *  向左行走的方法
 */
-(void)goLeft{
    [self checkIfCanPass];
    if(self.isCanMove){
        if ([self checkIfCanMoveMap]) {
            [self moveMap];
        }
        CABasicAnimation *animation=[CABasicAnimation animationWithKeyPath:@"position"];
        animation.byValue = [NSValue valueWithCGVector:CGVectorMake(-1, 0)];
        animation.duration=0.025;
        animation.repeatCount=1;
        animation.delegate = self;
        [self.characterView.layer addAnimation:animation forKey:nil];
        self.currentPoint = CGPointMake(self.currentPoint.x-1, self.currentPoint.y);
        self.characterView.frame = CGRectMake(self.currentPoint.x-1, self.currentPoint.y, MapW, MapW);
    }
}

/**
 *  动画停止时的方法
 */
-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    if (self.delegate && [self.delegate respondsToSelector:@selector(CharacterMoveEndAtPoint:)]) {
        [self.delegate CharacterMoveEndAtPoint:self.currentPoint];
    }
}

/**
 *  检测地图是否应该移动
 */
-(BOOL)checkIfCanMoveMap{
    CGFloat x = self.characterView.center.x-self.contentOffset.x;
    CGFloat y = self.characterView.center.y-self.contentOffset.y;
    if (self.characterDirection==CharacterMoveDown) {
        if (y>=self.mapView.frame.size.height/2&&self.contentOffset.y<self.characterView.superview.frame.size.height-self.mapView.frame.size.height) {
            return YES;
        }else{
            return NO;
        }
    }
    if (self.characterDirection==CharacterMoveLeft) {
        if (x<=self.mapView.frame.size.width/2&&self.contentOffset.x>0) {
            return YES;
        }else{
            return NO;
        }
    }
    if (self.characterDirection==CharacterMoveRight) {
        if (x>=self.mapView.frame.size.width/2&&self.contentOffset.x<self.characterView.superview.frame.size.width-self.mapView.frame.size.width) {
            return YES;
        }else{
            return NO;
        }
    }
    if (self.characterDirection==CharacterMoveUp) {
        if (y<=self.mapView.frame.size.height/2&&self.contentOffset.y>0) {
            return YES;
        }else{
            return NO;
        }
    }
    return nil;
}

/**
 *  地图移动的方法
 */
-(void)moveMap{
    if (self.characterDirection==CharacterMoveDown) {
        self.contentOffset = CGPointMake(self.contentOffset.x, self.contentOffset.y+1);
        self.mapView.contentOffset = self.contentOffset;
    }
    if (self.characterDirection==CharacterMoveLeft) {
        self.contentOffset = CGPointMake(self.contentOffset.x-1, self.contentOffset.y);
        self.mapView.contentOffset = self.contentOffset;
    }
    if (self.characterDirection==CharacterMoveRight) {
        self.contentOffset = CGPointMake(self.contentOffset.x+1, self.contentOffset.y);
        self.mapView.contentOffset = self.contentOffset;
    }
    if (self.characterDirection==CharacterMoveUp) {
        self.contentOffset = CGPointMake(self.contentOffset.x, self.contentOffset.y-1);
        self.mapView.contentOffset = self.contentOffset;
    }
}

/**
 *  由数字转化为方向 @0向下  @1向左  @2向右   @3向上
 */
+(direction)changeNumberToDirection:(NSNumber *)number{
    direction tmpDirection;
    switch ([number intValue]) {
        case 0:
            tmpDirection = CharacterMoveDown;
            break;
        case 1:
            tmpDirection = CharacterMoveLeft;
            break;
        case 2:
            tmpDirection = CharacterMoveRight;
            break;
        default:
            tmpDirection = CharacterMoveUp;
            break;
    }
    return tmpDirection;
}

/**
 *  由方向转化为数字
 */
+(NSNumber *)changeDirectionToNumber:(direction)direction{
    NSNumber *number = [[NSNumber alloc]init];
    switch (direction) {
        case CharacterMoveDown:
            number = @0;
            break;
        case CharacterMoveLeft:
            number = @1;
            break;
        case CharacterMoveRight:
            number = @2;
            break;
        default:
            number = @3;
            break;
    }
    return number;
}
@end

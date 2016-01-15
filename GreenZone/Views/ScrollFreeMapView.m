//
//  ScrollFreeMapView.m
//  GreenZone
//
//  Created by zqh on 15/6/30.
//  Copyright (c) 2015年 student. All rights reserved.
//

#import "ScrollFreeMapView.h"

@implementation ScrollFreeMapView
/**
 *  初始化方法
 */
-(instancetype)initWithMapImage:(UIImage *)mapImage{
    if (self = [super init]) {
        self.bounces = NO;
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        self.scrollEnabled = NO;
        self.map = [[UIImageView alloc]initWithImage:mapImage];
        self.contentSize = self.map.bounds.size;
        self.map.userInteractionEnabled = YES;
        [self addSubview:self.map];
    }
    return self;
}

/**
 *  初始化角色的方法
 */
-(void)CharacterWithLocation:(CGPoint)point withCharacterDirection:(direction)characterDirection withCharacterImageName:(NSString *)name{
    self.characterView = [[UIImageView alloc]initWithFrame:CGRectMake(point.x, point.y, 32, 32)];
    self.character = [[CharacterMove alloc]initWithView:self.characterView withDirection:characterDirection withCharacterImageName:name];
    self.character.characterName = name;
    self.character.delegate = self;
    self.character.mapView = self;
    self.character.contentOffset = CGPointZero;
    self.character.mapPassArray = self.mapMoveArray;
    [self.map addSubview:self.characterView];
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(touchMapWithGesture:)];
    [self.map addGestureRecognizer:panGesture];
}

/**
 *  拖动手势调用的方法
 */
-(void)touchMapWithGesture:(UIPanGestureRecognizer *)panGesture{
    CGPoint translation = [panGesture translationInView:self.map];
    if (panGesture.state==UIGestureRecognizerStateBegan) {
        self.character.characterDirection = [self changeDirectionByTranslation:translation];
        self.lastDirection = self.character.characterDirection;
        [self.character characterMove];
    }
    if (panGesture.state==UIGestureRecognizerStateChanged) {
        direction currentDirection = [self changeDirectionByTranslation:translation];
        if (currentDirection!=self.lastDirection) {
            [self.character characterStopMove];
            self.character.characterDirection = currentDirection;
            self.lastDirection = currentDirection;
            [self.character characterMove];
        }
    }
    if (panGesture.state==UIGestureRecognizerStateEnded) {
        [self.character characterStopMove];
    }
}

/**
 *  改变方向
 */
-(direction)changeDirectionByTranslation:(CGPoint)translation{
    direction currentDirection;
    if (abs(translation.x)>abs(translation.y)) {
        if (translation.x>0) {
            currentDirection = CharacterMoveRight;
        }else{
            currentDirection = CharacterMoveLeft;
        }
    }else{
        if (translation.y>0) {
            currentDirection = CharacterMoveDown;
        }else{
            currentDirection = CharacterMoveUp;
        }
    }
    return currentDirection;
}

-(void)CharacterMoveCannotMoveAtPoint:(CGPoint)point WithDirection:(direction)currentDirection{
    if (self.delegate&&[self.delegate respondsToSelector:@selector(ScrollFreeMapViewMoveCannotMoveAtPoint:WithDirection:)]) {
        [self.delegate ScrollFreeMapViewMoveCannotMoveAtPoint:point WithDirection:currentDirection];
    }
}
@end

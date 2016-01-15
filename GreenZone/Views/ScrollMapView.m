//
//  ScrollMapView.m
//  GreenZone
//
//  Created by zqh on 15/6/29.
//  Copyright (c) 2015年 student. All rights reserved.
//

#import "ScrollMapView.h"
#import "ImageClip.h"

@implementation ScrollMapView

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
        self.lastCheckPoint = CGPointZero;
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
}

/**
 *  延迟实例化
 */
-(NSMutableArray *)arrawArray{
    if (!_arrawArray) {
        _arrawArray = [[NSMutableArray alloc]init];
    }
    return _arrawArray;
}

/**
 *  向当前方向行走自定义格
 */
-(void)moveWithStepNum:(NSNumber *)stepNum{
    self.stepNum = [stepNum intValue];
    [self.character characterMove];
}

/**
 *  向相反方向行走自定义格
 */
-(void)moveBackWithStepNum:(NSNumber *)stepNum{
    self.stepNum = [stepNum intValue];
    switch (self.character.characterDirection) {
        case CharacterMoveDown:
            self.character.characterDirection = CharacterMoveUp;
            break;
        case CharacterMoveUp:
            self.character.characterDirection = CharacterMoveDown;
            break;
        case CharacterMoveLeft:
            self.character.characterDirection = CharacterMoveRight;
            break;
        case CharacterMoveRight:
            self.character.characterDirection = CharacterMoveLeft;
            break;
        default:
            break;
    }
    [self.character characterMove];
}

/**
 *  代理方法
 */
- (void)CharacterMoveEndAtPoint:(CGPoint)point{
    if (point.x!=self.lastCheckPoint.x||point.y!=self.lastCheckPoint.y) {
        if (self.delegate&&[self.delegate respondsToSelector:@selector(ScrollMapViewSingleStepMoveStopAtPoint:)]) {
            [self.delegate ScrollMapViewSingleStepMoveStopAtPoint:point];
        }
        int row=0,col=0;
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
            if (self.delegate&&[self.delegate respondsToSelector:@selector(ScrollMapViewMoveStopAtPoint:)]) {
                [self.delegate ScrollMapViewMoveStopAtPoint:point];
            }
        }
    }
}

/**
 *  检查点判定
 */
-(void)checkPoint:(CGPoint)point{
    if (point.x!=self.lastCheckPoint.x||point.y!=self.lastCheckPoint.y) {
        int row=point.y/32,col=point.x/32;
        int colNum = self.characterView.superview.frame.size.width/32;
        NSNumber *markNum = self.mapMoveArray[row*colNum+col];
        NSNumber *markNumUp = self.mapMoveArray[(row-1)*colNum+col];
        NSNumber *markNumDown = self.mapMoveArray[(row+1)*colNum+col];
        NSNumber *markNumLeft = self.mapMoveArray[row*colNum+col-1];
        NSNumber *markNumRight = self.mapMoveArray[row*colNum+col+1];
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
            if (self.delegate&&[self.delegate respondsToSelector:@selector(ScrollMapViewNeedSelectRoad)]) {
                [self.delegate ScrollMapViewNeedSelectRoad];
            }
            [self findRoadForNextStep:point];
        }
        self.lastCheckPoint = point;
    }
}

/**
 *  岔路口选择下条路
 */
-(void)findRoadForNextStep:(CGPoint)point{
    int row=point.y/32,col=point.x/32;
    int colNum = self.characterView.superview.frame.size.width/32;
    NSNumber *markNumUp = self.mapMoveArray[(row-1)*colNum+col];
    NSNumber *markNumDown = self.mapMoveArray[(row+1)*colNum+col];
    NSNumber *markNumLeft = self.mapMoveArray[row*colNum+col-1];
    NSNumber *markNumRight = self.mapMoveArray[row*colNum+col+1];
    if ([markNumUp intValue]!=0&&self.character.characterDirection!=CharacterMoveDown) {
        CGPoint NewPoint = CGPointMake(point.x, point.y-32);
        [self addArrawViewForDirection:CharacterMoveUp AtPoint:NewPoint];
    }
    if ([markNumDown intValue]!=0&&self.character.characterDirection!=CharacterMoveUp) {
        CGPoint NewPoint = CGPointMake(point.x, point.y+32);
        [self addArrawViewForDirection:CharacterMoveDown AtPoint:NewPoint];
    }
    if ([markNumLeft intValue]!=0&&self.character.characterDirection!=CharacterMoveRight) {
        CGPoint NewPoint = CGPointMake(point.x-32, point.y);
        [self addArrawViewForDirection:CharacterMoveLeft AtPoint:NewPoint];
    }
    if ([markNumRight intValue]!=0&&self.character.characterDirection!=CharacterMoveLeft) {
        CGPoint NewPoint = CGPointMake(point.x+32, point.y);
        [self addArrawViewForDirection:CharacterMoveRight AtPoint:NewPoint];
    }
}

/**
 *  为某方向添加一个指向视图
 */
-(void)addArrawViewForDirection:(direction)arrawDirection AtPoint:(CGPoint)point{
    UIImageView *arrawView = [[UIImageView alloc]initWithFrame:CGRectMake(point.x, point.y, 32, 32)];
    arrawView.animationImages = [self animatingImageArrWithDirection:arrawDirection];
    arrawView.animationDuration = 0.5;
    arrawView.animationRepeatCount = NSNotFound;
    arrawView.userInteractionEnabled = YES;
    [self.map addSubview:arrawView];
    [arrawView startAnimating];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickArrawView:)];
    [arrawView addGestureRecognizer:tapGesture];
    [self.arrawArray addObject:arrawView];
}

/**
 *  轻击手势调用的方法
 */
-(void)clickArrawView:(UITapGestureRecognizer *)tapGesture{
    UIImageView *tapView = (UIImageView *)tapGesture.view;
    CGPoint point = tapView.frame.origin;
    if (point.x==self.character.currentPoint.x) {
        if (point.y>self.character.currentPoint.y) {
            self.character.characterDirection = CharacterMoveDown;
        }
        if (point.y<self.character.currentPoint.y) {
            self.character.characterDirection = CharacterMoveUp;
        }
    }
    else{
        if (point.x>self.character.currentPoint.x) {
            self.character.characterDirection = CharacterMoveRight;
        }
        if (point.x<self.character.currentPoint.x) {
            self.character.characterDirection = CharacterMoveLeft;
        }
    }
    [self removeAllArraw];
    if (self.delegate&&[self.delegate respondsToSelector:@selector(ScrollMapViewDidSelectRoad)]) {
        [self.delegate ScrollMapViewDidSelectRoad];
    }
    [self moveWithStepNum:[NSNumber numberWithInt:self.stepNum]];
}


/**
 *  移除所有的箭头视图
 */
-(void)removeAllArraw{
    for (UIImageView *view in self.arrawArray) {
        [view removeFromSuperview];
    }
    self.arrawArray = nil;
}

/**
 *  由方向取到箭头图片数组
 */
-(NSArray *)animatingImageArrWithDirection:(direction)characterDir{
    NSMutableArray *tmpArr = [[NSMutableArray alloc]init];
    UIImage *image = [ImageClip imageWithPngName:@"$system_arraw"];
    int width = 32;
    switch (characterDir) {
        case CharacterMoveDown:{
            for (int i=0; i<3; i++) {
                CGRect rect = CGRectMake(i*width,width*3, width,width);
                UIImage *nimage = [ImageClip imageWithImage:image clipByRect:rect];
                [tmpArr addObject:nimage];
            }
            break;
        }
        case CharacterMoveUp:{
            for (int i=0; i<3; i++) {
                CGRect rect = CGRectMake(i*width,0, width,width);
                UIImage *nimage = [ImageClip imageWithImage:image clipByRect:rect];
                [tmpArr addObject:nimage];
            }
            break;
        }
        case CharacterMoveRight:{
            for (int i=0; i<3; i++) {
                CGRect rect = CGRectMake(i*width,width, width,width);
                UIImage *nimage = [ImageClip imageWithImage:image clipByRect:rect];
                [tmpArr addObject:nimage];
            }
            break;
        }
        default:{
            for (int i=0; i<3; i++) {
                CGRect rect = CGRectMake(i*width,width*2, width,width);
                UIImage *nimage = [ImageClip imageWithImage:image clipByRect:rect];
                [tmpArr addObject:nimage];
            }
            break;
        }
    }
    return tmpArr;
}

@end

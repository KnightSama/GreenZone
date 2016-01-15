//
//  ScrollFreeMapView.h
//  GreenZone
//
//  Created by zqh on 15/6/30.
//  Copyright (c) 2015年 student. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CharacterMove.h"

@protocol ScrollFreeMapViewDelegate <NSObject>
/**
 *  角色行走完毕后执行的方法
 */
-(void)ScrollFreeMapViewMoveStopAtPoint:(CGPoint)point;
/**
 *  角色行走遇到障碍时的方法
 */
-(void)ScrollFreeMapViewMoveCannotMoveAtPoint:(CGPoint)point WithDirection:(direction)currentDirection;
@end

@interface ScrollFreeMapView : UIScrollView<CharacterMoveDelegate>
/**
 *  放置地图的view
 */
@property(nonatomic,strong) UIImageView *map;
/**
 *  地图的通行性数组
 */
@property(nonatomic,strong) NSArray *mapMoveArray;
/**
 *  行走角色人物图
 */
@property(nonatomic,strong) CharacterMove *character;
/**
 *  角色所在的view
 */
@property(nonatomic,strong) UIImageView *characterView;
/**
 *  角色上次的方向
 */
@property(nonatomic,assign) direction lastDirection;
@property(nonatomic,weak) id<UIScrollViewDelegate,ScrollFreeMapViewDelegate> delegate;

/**
 *  初始化地图的方法
 */
-(instancetype)initWithMapImage:(UIImage *)mapImage;
/**
 *  初始化角色的方法
 */
-(void)CharacterWithLocation:(CGPoint)point withCharacterDirection:(direction)characterDirection withCharacterImageName:(NSString *)name;
@end

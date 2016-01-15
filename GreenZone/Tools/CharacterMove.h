//
//  CharacterMove.h
//  GreenZone
//
//  Created by zqh on 15/6/26.
//  Copyright (c) 2015年 student. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 定义行走方向
 */
typedef enum {CharacterMoveUp,CharacterMoveDown,CharacterMoveLeft,CharacterMoveRight} direction;

@protocol CharacterMoveDelegate <NSObject>
/**
 *  角色开始移动时调用的方法
 */
-(void)CharacterMoveStart;
/**
 *  角色移动完成时调用的方法
 */
-(void)CharacterMoveEndAtPoint:(CGPoint)point;
/**
 *  行走遇到障碍时调用的方法
 */
-(void)CharacterMoveCannotMoveAtPoint:(CGPoint)point WithDirection:(direction)currentDirection;
@end

@interface CharacterMove : NSObject
/**
 *  地图通行性数组  0 不可通行  1 可通行  2分支路口
 */
@property(nonatomic,strong) NSArray *mapPassArray;
/**
 *  前方是否可移动
 */
@property(nonatomic,assign) BOOL isCanMove;
/**
 *  地图所在的View
 */
@property(nonatomic,strong) UIScrollView *mapView;
/**
 *  地图的当前偏移坐标
 */
@property(nonatomic,assign) CGPoint contentOffset;
/**
 *  角色行走图片名
 */
@property(nonatomic,strong) NSString *characterName;
/**
 *  角色行走方向
 */
@property(nonatomic,assign) direction characterDirection;
/**
 *  角色的当前坐标
 */
@property(nonatomic,assign) CGPoint currentPoint;
/**
 *  角色所在的view
 */
@property(nonatomic,strong) UIImageView *characterView;
/**
 *  动画定时器
 */
@property(nonatomic,strong) NSTimer *timer;

@property(nonatomic,weak) id<CharacterMoveDelegate> delegate;

#pragma mark 初始化方法
/**
 *  通过角色所在View与方向初始化
 */
-(instancetype)initWithView:(UIImageView *)view withDirection:(direction)characterDir withCharacterImageName:(NSString *)imageName;

#pragma mark 玩家所具有的方法
/**
 *  显示原地行进动画
 */
-(void)characterMoveAnimationStart;
/**
 *  关闭原地行进的动画
 */
-(void)characterMoveAnimationStop;
/**
 *  向当前方向一直前进
 */
-(void)characterMove;
/**
 *  停止前进
 */
-(void)characterStopMove;
/**
 *  通行性检测 0 不可通行  1 可通行  2分支路口
 */
-(void)checkIfCanPass;
/**
 *  检测地图是否应该移动
 */
-(BOOL)checkIfCanMoveMap;
/**
 *  地图移动的方法
 */
-(void)moveMap;
/**
 *  由数字转化为方向 @0向下  @1向左  @2向右   @3向上
 */
+(direction)changeNumberToDirection:(NSNumber *)number;
/**
 *  由方向转化为数字
 */
+changeDirectionToNumber:(direction)direction;
@end

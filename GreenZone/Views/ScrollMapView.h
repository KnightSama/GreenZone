//
//  ScrollMapView.h
//  GreenZone
//
//  Created by zqh on 15/6/29.
//  Copyright (c) 2015年 student. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CharacterMove.h"


@protocol ScrollMapViewDelegate <NSObject>
/**
 *  遇到岔路口时调用的方法
 */
-(void)ScrollMapViewNeedSelectRoad;
/**
 *  遇到岔路选择完毕后调用的方法
 */
-(void)ScrollMapViewDidSelectRoad;
/**
 *  角色行走完毕调用的方法
 */
-(void)ScrollMapViewMoveStopAtPoint:(CGPoint)point;
/**
 *  角色行走一步后调用的方法
 */
-(void)ScrollMapViewSingleStepMoveStopAtPoint:(CGPoint)point;
@end

@interface ScrollMapView : UIScrollView<CharacterMoveDelegate>
/**
 *  角色向前行走的路径
 */
@property(nonatomic,assign) int stepNum;
/**
 *  放置地图的view
 */
@property(nonatomic,strong) UIImageView *map;
/**
 *  地图的通行性数组
 */
@property(nonatomic,strong) NSArray *mapMoveArray;
/**
 *  上次检查的点
 */
@property(nonatomic,assign) CGPoint lastCheckPoint;
/**
 *  行走角色人物
 */
@property(nonatomic,strong) CharacterMove *character;
/**
 *  角色所在的view
 */
@property(nonatomic,strong) UIImageView *characterView;
/**
 *  指向图组
 */
@property(nonatomic,strong) NSMutableArray *arrawArray;
/**
 *  手势起点坐标
 */
@property(nonatomic,assign) CGPoint gesturePoint;
@property(nonatomic,weak) id<ScrollMapViewDelegate,UIScrollViewDelegate> delegate;


/**
 *  初始化地图的方法
 */
-(instancetype)initWithMapImage:(UIImage *)mapImage;
/**
 *  初始化角色的方法
 */
-(void)CharacterWithLocation:(CGPoint)point withCharacterDirection:(direction)characterDirection withCharacterImageName:(NSString *)name;
/**
 *  向当前方向行走自定义格
 */
-(void)moveWithStepNum:(NSNumber *)stepNum;
/**
 *  向相反方向行走自定义格
*/
-(void)moveBackWithStepNum:(NSNumber *)stepNum;
@end

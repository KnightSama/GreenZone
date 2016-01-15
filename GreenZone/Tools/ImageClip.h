//
//  ImageClip.h
//  GreenZone
//
//  Created by zqh on 15/6/23.
//  Copyright (c) 2015年 student. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ImageClip : NSObject

/**
 *  由图片名获得一张图片
 */
+(UIImage *)imageWithJpgName:(NSString *)name;
+(UIImage *)imageWithPngName:(NSString *)name;

/**
 *  由图片与矩形区域获得一张裁剪后的图片
 */
+(UIImage *)imageWithImage:(UIImage *)image clipByRect:(CGRect)rect;

/**
 *  通过指定宽度将图片裁剪为图片组
 */
+(NSArray *)imageArrWithImage:(UIImage *)image clipByWidth:(CGFloat)width;

/**
 *  通过脸图名与位置获得一张脸图
 */
+(UIImage *)imageWithFaceImage:(NSString *)imageName getByLocation:(NSNumber *)imageNum;

/**
 *  通过图片名与方向编号获得一张人物静止图  @0向下  @1向左  @2向右   @3向上
 */
+(UIImage *)imageWithCharacterImage:(NSString *)imageName getByDirectionNumber:(NSNumber *)directNum;

/**
 *  通过图片名与方向编号获得人物行走数组  @0向下  @1向左  @2向右   @3向上
 */
+(NSArray *)imageArrWithCharacterImage:(NSString *)imageName getByDirectionNumber:(NSNumber *)directNum;

/**
 *  通过图片名返回一张圆形脸图
 */
+(UIImage *)circleFaceImageWithName:(NSString *)name borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;

/**
 *  截取指定View的图像
 */
+ (UIImage *)getSnapshotImageWithView:(UIView *)view;
@end

//
//  ImageClip.m
//  GreenZone
//
//  Created by zqh on 15/6/23.
//  Copyright (c) 2015年 student. All rights reserved.
//

#import "ImageClip.h"

@implementation ImageClip

/**
 *  由图片名获得一张图片
 */
+(UIImage *)imageWithJpgName:(NSString *)name{
    NSString *path = [[NSBundle mainBundle]pathForResource:name ofType:@"jpg"];
    UIImage *image = [UIImage imageWithContentsOfFile:path];
    return image;
}

+(UIImage *)imageWithPngName:(NSString *)name{
    NSString *path = [[NSBundle mainBundle]pathForResource:name ofType:@"png"];
    UIImage *image = [UIImage imageWithContentsOfFile:path];
    return image;
}


/**
 *  由图片与矩形区域获得一张裁剪后的图片
 */
+(UIImage *)imageWithImage:(UIImage *)image clipByRect:(CGRect)rect{
    CGImageRef imageRef = CGImageCreateWithImageInRect(image.CGImage, rect);
    CGRect newRect = CGRectMake(0, 0, CGImageGetWidth(imageRef), CGImageGetHeight(imageRef));
    UIGraphicsBeginImageContext(newRect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextDrawImage(context, newRect, imageRef);
    UIImage *clipImage = [UIImage imageWithCGImage:imageRef];
    UIGraphicsEndImageContext();
    CGImageRelease(imageRef);
    return clipImage;
}

/**
 *  通过指定宽度将图片裁剪为图片组
 */
+(NSArray *)imageArrWithImage:(UIImage *)image clipByWidth:(CGFloat)width{
    int rowNum = image.size.height/width;
    int colNum = image.size.width/width;
    NSMutableArray *imageArr = [[NSMutableArray alloc]init];
    for (int row = 0; row<rowNum; row++) {
        for (int col = 0; col<colNum; col++) {
            CGRect rect = CGRectMake(col*width, row*width, width, width);
            CGImageRef imageRef = CGImageCreateWithImageInRect(image.CGImage, rect);
            CGRect newRect = CGRectMake(0, 0, CGImageGetWidth(imageRef), CGImageGetHeight(imageRef));
            UIGraphicsBeginImageContext(newRect.size);
            CGContextRef context = UIGraphicsGetCurrentContext();
            CGContextDrawImage(context, newRect, imageRef);
            UIImage *clipImage = [UIImage imageWithCGImage:imageRef];
            UIGraphicsEndImageContext();
            CGImageRelease(imageRef);
            [imageArr addObject:clipImage];
        }
    }
    return imageArr;
}

/**
 *  通过脸图名与位置获得一张脸图
 */
+(UIImage *)imageWithFaceImage:(NSString *)imageName getByLocation:(NSNumber *)imageNum{
    UIImage *faceImage = [self imageWithPngName:imageName];
    CGRect clipRect = CGRectMake(96*([imageNum intValue]%4), 96*([imageNum intValue]/4), 96, 96);
    faceImage = [self imageWithImage:faceImage clipByRect:clipRect];
    return faceImage;
}

/**
 *  通过图片名与方向编号获得一张人物静止图  @0向下  @1向左  @2向右   @3向上
 */
+(UIImage *)imageWithCharacterImage:(NSString *)imageName getByDirectionNumber:(NSNumber *)directNum{
    UIImage *characterImage = [self imageWithPngName:imageName];
    int directionNumber = [directNum intValue];
    CGRect clipRect = CGRectMake(32, directionNumber*32, 32, 32);
    return [self imageWithImage:characterImage clipByRect:clipRect];
}

/**
 *  通过图片名与方向编号获得人物行走数组  @0向下  @1向左  @2向右   @3向上
 */
+(NSArray *)imageArrWithCharacterImage:(NSString *)imageName getByDirectionNumber:(NSNumber *)directNum{
    UIImage *characterImage = [self imageWithPngName:imageName];
    int directionNumber = [directNum intValue];
    NSMutableArray *imageArr = [[NSMutableArray alloc]init];
    for (int i=0; i<3; i++) {
        [imageArr addObject:[self imageWithImage:characterImage clipByRect:CGRectMake(32*i,32*directionNumber, 32, 32)]];
    }
    return imageArr;
}

/**
 *  通过图片名返回一张圆形脸图
 */
+(UIImage *)circleFaceImageWithName:(NSString *)name borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor{
    //1、获得原来的图片
    UIImage *oldImge=[self imageWithFaceImage:name getByLocation:@0];
    //2、要绘图，首先得创建上下文
    CGFloat imgW=oldImge.size.width+2*borderWidth;
    CGFloat imgH=oldImge.size.height+2*borderWidth;
    CGSize imgSize=CGSizeMake(imgW, imgH);
    UIGraphicsBeginImageContext(imgSize);
    //3、得到绘图上下文
    CGContextRef ctx=UIGraphicsGetCurrentContext();
    [borderColor set];//设置填充颜色
    //4、画大圆（边框）
    CGFloat radius=imgW/2.0f;//大圆的半径
    CGFloat cenX=radius;
    CGFloat cenY=radius;
    CGContextAddArc(ctx, cenX, cenY, radius, 0, 2*M_PI, 0);
    CGContextFillPath(ctx);
    //5、画小圆
    CGFloat smallRadius=radius-borderWidth;//小圆的半径
    //画了一个小圆
    CGContextAddArc(ctx, cenX, cenY, smallRadius, 0,  2*M_PI, 0);
    //裁剪
    CGContextClip(ctx);
    //6、画图
    [oldImge drawInRect:CGRectMake(borderWidth, borderWidth, oldImge.size.width, oldImge.size.height)];
    //7、得到画好的后的图片
    UIImage *newImg=UIGraphicsGetImageFromCurrentImageContext();
    //8、结束上下文
    UIGraphicsEndImageContext();
    return newImg;
}

/**
 *  截取指定View的图像
 */
+ (UIImage *)getSnapshotImageWithView:(UIView *)view{
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(CGRectGetWidth(view.frame), CGRectGetHeight(view.frame)), NO, 1);
    [view drawViewHierarchyInRect:CGRectMake(0, 0, CGRectGetWidth(view.frame), CGRectGetHeight(view.frame)) afterScreenUpdates:NO];
    UIImage *snapshot = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return snapshot;
}

@end

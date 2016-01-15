//
//  faceModel.h
//  GreenZone
//
//  Created by student on 15/7/2.
//  Copyright (c) 2015年 student. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface faceModel : NSObject

/**
 *  脸的图像文件名
 */
@property (nonatomic,strong) NSString *face;

/**
 *  后部头发的图像文件名
 */
@property (nonatomic,strong) NSString *rearHair;

/**
 *  前部头发图像文件名
 */
@property (nonatomic,strong) NSString *frontHair;

/**
 *  眉毛图像文件名
 */
@property (nonatomic,strong) NSString *eyeBrows;

/**
 *  眼睛的图像文件名
 */
@property (nonatomic,strong) NSString *eye;

/**
 *  鼻子的图像文件名
 */
@property (nonatomic,strong) NSString *nose;

/**
 *  嘴巴的图像文件名
 */
@property (nonatomic,strong) NSString *mouth;


/**
 *  耳朵的图像文件名
 */
@property (nonatomic,strong) NSString *ears;


/**
 *  配件的图像文件名
 */
@property (nonatomic,strong) NSString *acc;

/**
 *  胡子的图像文件名
 */
@property (nonatomic,strong) NSString *beard;

/**
 *  脖子下的图像文件名
 */
@property (nonatomic,strong) NSString *neck;

@end

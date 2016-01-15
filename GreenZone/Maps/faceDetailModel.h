//
//  faceDetailModel.h
//  GreenZone
//
//  Created by student on 15/7/3.
//  Copyright (c) 2015年 student. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface faceDetailModel : NSObject

/**
 *  脸部图像数组
 */
@property (nonatomic,strong) NSArray *faceArr;

/**
 *  后部头发图像数组
 */
@property (nonatomic,strong) NSArray *rearHairArr;

/**
 *  前部头发图像数组
 */
@property (nonatomic,strong) NSArray *frontHairArr;

/**
 *  眉毛图像数组
 */
@property (nonatomic,strong) NSArray *eyeBrowsArr;

/**
 *  眼睛的图像数组
 */
@property (nonatomic,strong) NSArray *eyeArr;

/**
 *  鼻子的图像数组
 */
@property (nonatomic,strong) NSArray *noseArr;

/**
 *  嘴巴的图像数组
 */
@property (nonatomic,strong) NSArray *mouthArr;


/**
 *  耳朵的图像数组
 */
@property (nonatomic,strong) NSArray *earsArr;


/**
 *  配件的图像数组
 */
@property (nonatomic,strong) NSArray *accArr;

/**
 *  胡子的图像数组
 */
@property (nonatomic,strong) NSArray *beardArr;

/**
 *  脖子下的图像数组
 */
@property (nonatomic,strong) NSArray *neckArr;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)modelWithDict:(NSDictionary *)dict;



@end

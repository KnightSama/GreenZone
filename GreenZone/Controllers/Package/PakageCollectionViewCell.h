//
//  PakageCollectionViewCell.h
//  GreenZone
//
//  Created by student on 15/7/6.
//  Copyright (c) 2015年 student. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "packageThingsShowModel.h"

@interface PakageCollectionViewCell : UICollectionViewCell



/**
 *  物品图片展示
 */
@property (weak, nonatomic) IBOutlet UIImageView *thingsIcon;

/**
 *  物品拥有的数量
 */
@property (weak, nonatomic) IBOutlet UILabel *thingsCount;

/**
 *  传入一个拥有的物品展示model
 */
@property(nonatomic,strong) packageThingsShowModel *packageThing;

@end

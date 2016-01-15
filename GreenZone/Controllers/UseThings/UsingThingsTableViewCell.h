//
//  UsingThingsTableViewCell.h
//  GreenZone
//
//  Created by student on 15/7/7.
//  Copyright (c) 2015年 student. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "packageThingsShowModel.h"
#import "Save.h"

@protocol UsingThingsTableViewCellUsingDelegate <NSObject>

@optional

- (void)clickUsingThingsBtn:(Save *)save;

@end

@interface UsingThingsTableViewCell : UITableViewCell

/**
 *  物品的展示model
 */
@property(nonatomic,strong) packageThingsShowModel *thingShowModel;

/**
 *  存档数据
 */
@property(nonatomic,strong) Save *saveDataIncell;

/**
 *  代理
 */
@property(nonatomic,strong) id<UsingThingsTableViewCellUsingDelegate> delegate;

@end

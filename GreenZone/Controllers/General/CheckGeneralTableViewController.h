//
//  CheckGeneralTableViewController.h
//  GreenZone
//
//  Created by niit on 15-7-7.
//  Copyright (c) 2015年 student. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Save;
@class GeneralModel;
@class AVAudioPlayer;


@protocol checkGeneralDelegate <NSObject>

-(void)passValue:(GeneralModel *)general;

@end


@interface CheckGeneralTableViewController : UITableViewController
@property(nonatomic,strong) AVAudioPlayer *player;
/**
 *  取到存档
 */
@property(nonatomic,strong)Save *save;

/**
 *  符合条件的所有武将
 */
@property(nonatomic,strong)NSMutableArray *generals;

/**
 *  选择武将
 */
@property(nonatomic,strong)GeneralModel *general;

@property(nonatomic,strong)id<checkGeneralDelegate> delegate;


/**
 *  通过存档初始化
 */
-(instancetype)initWithSave:(Save *)save;

@end

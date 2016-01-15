//
//  faceMakeCell.h
//  GreenZone
//
//  Created by student on 15/7/2.
//  Copyright (c) 2015年 student. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "faceModel.h"

@protocol faceMakeCellDelegate <NSObject>

@optional

- (void)showTheFaceInTheShowViewWithImage:(UIImage *)img WithCellTag:(NSInteger)tag;

@end

@interface faceMakeCell : UITableViewCell



/**
 *  属性名
 */
@property(nonatomic,strong) UILabel *attriName;


/**
 *  属性展示View
 */
@property(nonatomic,strong) UIScrollView *attriShow;

/**
 *  属性选择View
 */
@property(nonatomic,strong) UIPickerView *attriChooseShow;


/**
 *  人物脸部细节图片数组
 */

@property(nonatomic,strong) NSArray *faceDetailArr;


/**
 *  人物脸部首张细节图片数组
 */
@property(nonatomic,strong) NSMutableArray *faceDetailFristArr;

/**
 *  存储脸部细节数组
 */
@property(nonatomic,strong) NSMutableArray *allFaceDetailArr;



@property(nonatomic,strong) id<faceMakeCellDelegate> delegate;


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

@end

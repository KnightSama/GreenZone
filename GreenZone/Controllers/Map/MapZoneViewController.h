//
//  MapZoneViewController.h
//  GreenZone
//
//  Created by student on 15/6/24.
//  Copyright (c) 2015年 student. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MapZoneViewControllerDelegate <NSObject>

-(void)translateImage:(UIImage *)image;

@end




@interface MapZoneViewController : UIViewController

@property(nonatomic,weak) id<MapZoneViewControllerDelegate> delegate;

@property(nonatomic,strong) UIImage *image;

@property(nonatomic,strong) NSArray *imageArr;

@property(nonatomic,strong) UIScrollView *scroll;
@end

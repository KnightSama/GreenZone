//
//  TestMapViewController.h
//  GreenZone
//
//  Created by student on 15/6/30.
//  Copyright (c) 2015年 student. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScrollFreeMapView.h"

@interface TestMapViewController : UIViewController


@property(nonatomic,strong) ScrollFreeMapView *mapView;

@property(nonatomic,strong) NSArray *mapArr;
@end

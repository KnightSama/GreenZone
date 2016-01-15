//
//  MapZoneViewController.m
//  GreenZone
//
//  Created by student on 15/6/24.
//  Copyright (c) 2015年 student. All rights reserved.
//

#import "MapZoneViewController.h"
#import "ImageClip.h"
@interface MapZoneViewController ()

@end

@implementation MapZoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.scroll = [[UIScrollView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.scroll.bounces = NO;
    UIImage *image = [ImageClip imageWithPngName:@"Dungeon_A2"];
    NSArray *imageArr = [ImageClip imageArrWithImage:image clipByWidth:32];
    int row = self.image.size.height/32;
    int col = self.image.size.width/32;
    for (int i =0; i<row; i++) {
        for (int j=0; j<col; j++) {
            UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(j*32, i*32, 32, 32)];
            int index = i*col+j;
            imageView.image = self.imageArr[index];
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickImage:)];
            [imageView addGestureRecognizer:tap];
            imageView.layer.borderColor = [UIColor redColor].CGColor;
            imageView.layer.borderWidth = 0.5;
            imageView.userInteractionEnabled = YES;
            [self.scroll addSubview:imageView];
        }
    }
    self.scroll.contentSize = self.image.size;
    [self.view addSubview:self.scroll];
}

-(NSArray *)imageArr{
    if (!_imageArr) {
        _imageArr = [[NSArray alloc]init];
    }
    return _imageArr;
}

-(void)viewWillAppear:(BOOL)animated{
    
}

-(void)viewDidAppear:(BOOL)animated{
    
}

-(void)clickImage:(UITapGestureRecognizer *)tap{
    UIImageView *imageView = (UIImageView *)tap.view;
    if (self.delegate&&[self.delegate respondsToSelector:@selector(translateImage:)]) {
        [self.delegate translateImage:imageView.image];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end

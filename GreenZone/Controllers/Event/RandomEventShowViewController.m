//
//  RandomEventShowViewController.m
//  GreenZone
//
//  Created by student on 15/7/8.
//  Copyright (c) 2015年 student. All rights reserved.
//

#import "RandomEventShowViewController.h"
#import "ImageClip.h"
#import "AudioTool.h"
@interface RandomEventShowViewController ()

@end

@implementation RandomEventShowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView *imageView = [[UIImageView alloc]initWithImage:self.backImage];
    [self.view addSubview:imageView];
    [self createWindowUI];
}

-(void)viewWillAppear:(BOOL)animated{
    self.player = [AudioTool playMusic:@"Item.mp3"];
}

-(void)viewWillDisappear:(BOOL)animated{
    [self.player stop];
}

/**
 *  通过消息初始化
 */
-(instancetype)initWithMessage:(NSString *)message withView:(UIView *)view{
    if (self = [super init]) {
        self.backImage = [ImageClip getSnapshotImageWithView:view];
        self.message = message;
        self.showView = view;
    }
    return self;
}

/**
 *  创建界面
 */
-(void)createWindowUI{
    //创建view显示在窗口上
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, W(294), H(225))];
    view.center = CGPointMake(WinWidth/2, WinHeight/2);
    self.showView = view;
    [self.view addSubview:view];
    //创建背景图
    UIImageView *imageBack = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, W(294), H(225))];
    imageBack.image = [ImageClip imageWithJpgName:@"messageBG"];
    [view addSubview:imageBack];
    //创建背景边框
    UIImageView *imageBorder = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, W(294), H(225))];
    imageBorder.image = [ImageClip imageWithPngName:@"messageBorder1"];
    [view addSubview:imageBorder];
    //创建消息View
    UITextView *textView = [[UITextView alloc]initWithFrame:CGRectMake(W(31), H(50), W(233), H(138))];
    textView.editable = NO;
    textView.backgroundColor = [UIColor clearColor];
    textView.text = self.message;
    textView.textAlignment = NSTextAlignmentCenter;
    textView.font = [UIFont systemFontOfSize:20];
    [view addSubview:textView];
    //创建确定按钮
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(W(111), H(165), W(73), H(27))];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.layer.borderWidth = 1.0;
    [button setTitle:@"确定" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button];
}

/**
 *  返回的方法
 */
-(void)back{
    [self dismissViewControllerAnimated:NO completion:^{
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

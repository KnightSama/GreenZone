//
//  BattleResultViewController.m
//  GreenZone
//
//  Created by student on 15/7/8.
//  Copyright (c) 2015年 student. All rights reserved.
//

#import "BattleResultViewController.h"
#import "ImageClip.h"
#import "AppDelegate.h"
#import "AudioTool.h"
@interface BattleResultViewController ()

@end

@implementation BattleResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView *imageView = [[UIImageView alloc]initWithImage:self.backImage];
    [self.view addSubview:imageView];
    [self createWindowUI];
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [self.player stop];
}

/**
 *  通过消息初始化
 */
-(instancetype)initWithMessage:(NSString *)message withResult:(NSNumber *)result withView:(UIView *)view{
    if (self = [super init]) {
        self.backImage = [ImageClip getSnapshotImageWithView:view];
        self.message = message;
        self.result = result;
        self.showView = view;
    }
    return self;
}

/**
 *  创建界面
 */
-(void)createWindowUI{
    //创建view显示在窗口上
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, W(294), H(442))];
    view.center = CGPointMake(WinWidth/2, WinHeight/2);
    self.showView = view;
    [self.view addSubview:view];
    //创建背景图
    UIImageView *imageBack = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, W(294), H(442))];
    imageBack.image = [ImageClip imageWithJpgName:@"messageBG"];
    [view addSubview:imageBack];
    //创建标题背景
    UIImageView *titleImage = [[UIImageView alloc]initWithFrame:CGRectMake(W(0), H(0), W(300), H(219))];
    if ([self.result intValue]==2) {
        self.player = [AudioTool playMusic:@"attackCityDefeat.mp3"];
        titleImage.image = [ImageClip imageWithPngName:@"battleDefeat"];
    }else if([self.result intValue]==1){
        NSArray *arr = @[@"attackCityVictory.mp3",@"attackMonsterVictory.mp3"];
        titleImage.image = [ImageClip imageWithPngName:@"battlevictory"];
        self.player = [AudioTool playMusic:arr[arc4random_uniform(2)]];
    }else{
        titleImage.image = [ImageClip imageWithPngName:@"gameOver"];
        self.player = [AudioTool playMusic:@"Gameover.mp3"];
    }
    self.player.numberOfLoops = 0;
    [view addSubview:titleImage];
    //创建消息View
    UITextView *textView = [[UITextView alloc]initWithFrame:CGRectMake(W(8), H(237), W(278), H(120))];
    textView.editable = NO;
    textView.backgroundColor = [UIColor clearColor];
    textView.text = self.message;
    textView.textAlignment = NSTextAlignmentCenter;
    textView.font = [UIFont systemFontOfSize:20];
    [view addSubview:textView];
    //创建确定按钮
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(W(105), H(375), W(84), H(27))];
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
    if ([self.result intValue]!=0) {
        [self.player stop];
        [self dismissViewControllerAnimated:NO completion:^{
        }];
    }else{
        [self.player stop];
        UIApplication *app = [UIApplication sharedApplication];
        AppDelegate *delegate = app.delegate;
        [delegate gotoStartView];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

//
//  AboutUsViewController.m
//  GreenZone
//
//  Created by student on 15-7-6.
//  Copyright (c) 2015年 student. All rights reserved.
//

#import "AboutUsViewController.h"
#import "ImageClip.h"
#import "AudioTool.h"
@interface AboutUsViewController ()

@end

@implementation AboutUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"关于我们";
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(gotoBack)];
    self.navigationItem.leftBarButtonItem = item;
    [self createWindowUI];
}

-(void)viewWillAppear:(BOOL)animated{
    self.player = [AudioTool playMusic:@"aboutUs.mp3"];
    self.player.numberOfLoops = NSNotFound;
}

-(void)viewWillDisappear:(BOOL)animated{
    [self.player stop];
}

/**
 *  返回上个界面
 */
-(void)gotoBack{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

/**
 *  创建界面
 */
-(void)createWindowUI{
    UIImageView *backView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, WinWidth, WinHeight)];
    backView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:backView];
    //创建标题
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(W(109), H(13), W(102), H(21))];
    titleLabel.text = @"7313工作室";
    titleLabel.backgroundColor = [UIColor whiteColor];
    titleLabel.layer.borderWidth = 1.0;
    [self.view addSubview:titleLabel];
    //创建策划
    UIImageView *cehuaImageView = [[UIImageView alloc]initWithFrame:CGRectMake(W(14), H(59), W(64), H(64))];
    cehuaImageView.image = [ImageClip imageWithPngName:@"cehua"];
    [self.view addSubview:cehuaImageView];
    UILabel *cehuaLabel = [[UILabel alloc]initWithFrame:CGRectMake(W(109), H(59), W(34), H(21))];
    cehuaLabel.text = @"策划";
    cehuaLabel.textColor = [UIColor whiteColor];
    cehuaLabel.backgroundColor = [UIColor blackColor];
    cehuaLabel.layer.borderWidth = 1.0;
    [self.view addSubview:cehuaLabel];
    UILabel *cehuaNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(W(109), H(88), W(102), H(21))];
    cehuaNameLabel.text = @"7313工作室";
    cehuaNameLabel.textColor = [UIColor whiteColor];
    cehuaNameLabel.backgroundColor = [UIColor blackColor];
    cehuaNameLabel.layer.borderWidth = 1.0;
    [self.view addSubview:cehuaNameLabel];
    //创建程序
    UIImageView *chenxuImageView = [[UIImageView alloc]initWithFrame:CGRectMake(W(14), H(155), W(64), H(64))];
    chenxuImageView.image = [ImageClip imageWithPngName:@"chenxu"];
    [self.view addSubview:chenxuImageView];
    UILabel *chenxuLabel = [[UILabel alloc]initWithFrame:CGRectMake(W(109), H(155), W(34), H(21))];
    chenxuLabel.text = @"程序";
    chenxuLabel.textColor = [UIColor whiteColor];
    chenxuLabel.backgroundColor = [UIColor blackColor];
    chenxuLabel.layer.borderWidth = 1.0;
    [self.view addSubview:chenxuLabel];
    UILabel *chenxuNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(W(109), H(184), W(102), H(21))];
    chenxuNameLabel.text = @"7313工作室";
    chenxuNameLabel.textColor = [UIColor whiteColor];
    chenxuNameLabel.backgroundColor = [UIColor blackColor];
    chenxuNameLabel.layer.borderWidth = 1.0;
    [self.view addSubview:chenxuNameLabel];
    //创建美术
    UIImageView *meishuImageView = [[UIImageView alloc]initWithFrame:CGRectMake(W(14), H(245), W(64), H(64))];
    meishuImageView.image = [ImageClip imageWithPngName:@"meishu"];
    [self.view addSubview:meishuImageView];
    UILabel *meishuLabel = [[UILabel alloc]initWithFrame:CGRectMake(W(109), H(245), W(34), H(21))];
    meishuLabel.text = @"美术";
    meishuLabel.textColor = [UIColor whiteColor];
    meishuLabel.backgroundColor = [UIColor blackColor];
    meishuLabel.layer.borderWidth = 1.0;
    [self.view addSubview:meishuLabel];
    UILabel *meishuNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(W(109), H(274), W(102), H(21))];
    meishuNameLabel.text = @"7313工作室";
    meishuNameLabel.textColor = [UIColor whiteColor];
    meishuNameLabel.backgroundColor = [UIColor blackColor];
    meishuNameLabel.layer.borderWidth = 1.0;
    [self.view addSubview:meishuNameLabel];
    //创建音乐
    UIImageView *yinyueImageView = [[UIImageView alloc]initWithFrame:CGRectMake(W(14), H(335), W(64), H(64))];
    yinyueImageView.image = [ImageClip imageWithPngName:@"yinyue"];
    [self.view addSubview:yinyueImageView];
    UILabel *yinyueLabel = [[UILabel alloc]initWithFrame:CGRectMake(W(109), H(335), W(34), H(21))];
    yinyueLabel.text = @"音乐";
    yinyueLabel.textColor = [UIColor whiteColor];
    yinyueLabel.backgroundColor = [UIColor blackColor];
    yinyueLabel.layer.borderWidth = 1.0;
    [self.view addSubview:yinyueLabel];
    UILabel *yinyueNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(W(109), H(364), W(102), H(21))];
    yinyueNameLabel.text = @"7313工作室";
    yinyueNameLabel.textColor = [UIColor whiteColor];
    yinyueNameLabel.backgroundColor = [UIColor blackColor];
    yinyueNameLabel.layer.borderWidth = 1.0;
    [self.view addSubview:yinyueNameLabel];
    //创建QQ群
    UILabel *qqLabel = [[UILabel alloc]initWithFrame:CGRectMake(W(53), H(437), W(68), H(21))];
    qqLabel.text = @"反馈信息";
    qqLabel.textColor = [UIColor whiteColor];
    qqLabel.backgroundColor = [UIColor blackColor];
    qqLabel.layer.borderWidth = 1.0;
    [self.view addSubview:qqLabel];
    UILabel *qqNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(W(135), H(437), W(134), H(21))];
    qqNameLabel.text = @"QQ群:205818565";
    qqNameLabel.textColor = [UIColor whiteColor];
    qqNameLabel.backgroundColor = [UIColor blackColor];
    qqNameLabel.layer.borderWidth = 1.0;
    [self.view addSubview:qqNameLabel];
    //创建点赞
    UIImageView *dianzanImageView = [[UIImageView alloc]initWithFrame:CGRectMake(W(53), H(476), W(74), H(75))];
    dianzanImageView.image = [ImageClip imageWithPngName:@"dianzan"];
    [self.view addSubview:dianzanImageView];
    UIButton *dianzanBtn = [[UIButton alloc]initWithFrame:CGRectMake(W(135), H(476), W(142), H(75))];
    [dianzanBtn setTitle:@"点赞哦" forState:UIControlStateNormal];
    dianzanBtn.backgroundColor = [UIColor whiteColor];
    [dianzanBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    dianzanBtn.layer.cornerRadius = 20;
    [self.view addSubview:dianzanBtn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}



@end

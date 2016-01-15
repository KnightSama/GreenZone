//
//  EquipmentViewController.m
//  GreenZone
//
//  Created by student on 15-7-7.
//  Copyright (c) 2015年 student. All rights reserved.
//

#import "EquipmentViewController.h"
#import "Save.h"
#import "ImageClip.h"
#import "CharacterModel.h"
#import "ThingModel.h"
#import "AudioTool.h"

@interface EquipmentViewController ()

@end

@implementation EquipmentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.thingsArr = [ThingModel allThingsList];
    self.weaponArr = [[NSMutableArray alloc]init];
    self.armorArr = [[NSMutableArray alloc]init];
    self.gemArr = [[NSMutableArray alloc]init];
    for (NSNumber *tmp in self.save.characterModel.equiped) {
        if ([tmp integerValue]>999&&[tmp integerValue]<3000) {
            [self.weaponArr addObject:tmp];
        }
        else if ([tmp integerValue]>2999&&[tmp integerValue]<5000) {
            [self.armorArr addObject:tmp];
        }
        else if([tmp integerValue]>6999&&[tmp integerValue]<9000){
            [self.gemArr addObject:tmp];
        }
    }
    
    self.navigationItem.title = @"装备";
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(gotoBack)];
    self.navigationItem.leftBarButtonItem = item;
    self.view.backgroundColor = [UIColor whiteColor];
    [self createWindowUI];
}

/**
 *  返回上个界面
 */
-(void)gotoBack{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}


- (void)viewWillAppear:(BOOL)animated
{
    self.player = [AudioTool playMusic:@"map1.mp3"];
    self.player.numberOfLoops = NSNotFound;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self.player stop];
}

/**
 *  通过存档初始化
 */
-(instancetype)initWithSave:(Save *)save{
    if (self = [super init]) {
        self.save = save;
    }
    return self;
}

/**
 *  创建界面
 */
-(void)createWindowUI{
    
    //创建背景
    UIImageView *backView = [[UIImageView alloc]initWithFrame:CGRectMake(W(0), H(0), WinWidth, WinHeight)];
    backView.image = [ImageClip imageWithPngName:@"Sword"];
    backView.alpha = 0.6;
    [self.view addSubview:backView];
    //创建武器框
    UIImageView *weaponView = [[UIImageView alloc]initWithFrame:CGRectMake(W(145), H(67), W(93), H(93))];
    weaponView.layer.borderWidth = 2.0;
    if (self.weaponArr.count>0) {
        for (ThingModel *tmp in self.thingsArr) {
            if ([self.weaponArr[0] isEqualToString:tmp.thingId]) {
                weaponView.image = [ImageClip imageWithPngName:tmp.image];
            }
        }
    }
    
    [self.view addSubview:weaponView];
    
    //创建武器标题
    UILabel *weaponLabel = [[UILabel alloc]initWithFrame:CGRectMake(W(51), H(91), W(60), H(45))];
    weaponLabel.text = @"武器";
    weaponLabel.layer.borderWidth = 2.0;
    weaponLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:weaponLabel];
    //创建防具框
    UIImageView *armorView = [[UIImageView alloc]initWithFrame:CGRectMake(W(145), H(195), W(93), H(93))];
    armorView.layer.borderWidth = 2.0;
    if (self.armorArr.count>0) {
        for (ThingModel *tmp in self.thingsArr) {
            if ([self.armorArr[0] isEqualToString:tmp.thingId]) {
                armorView.image = [ImageClip imageWithPngName:tmp.image];
            }
        }
    }
    [self.view addSubview:armorView];
    //创建防具标题
    UILabel *armorLabel = [[UILabel alloc]initWithFrame:CGRectMake(W(51), H(219), W(60), H(45))];
    armorLabel.text = @"防具";
    armorLabel.layer.borderWidth = 2.0;
    armorLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:armorLabel];
    
    //创建宝石标题
    UILabel *gemLabel = [[UILabel alloc]initWithFrame:CGRectMake(W(116), H(333), W(60), H(45))];
    gemLabel.text = @"宝石";
    gemLabel.layer.borderWidth = 2.0;
    gemLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:gemLabel];
    //创建6个宝石框
    //1-6
    UIImageView *gemView1 = [[UIImageView alloc]initWithFrame:CGRectMake(W(28), H(396), W(60), H(60))];
    gemView1.layer.borderWidth = 1.0;
    if (self.gemArr.count>0) {
        for (ThingModel *tmp in self.thingsArr) {
            if (self.gemArr[0]==tmp.thingId) {
                gemView1.image = [ImageClip imageWithPngName:tmp.image];
            }
        }
    }
    [self.view addSubview:gemView1];
    
    UIImageView *gemView2 = [[UIImageView alloc]initWithFrame:CGRectMake(W(116), H(396), W(60), H(60))];
    
    gemView2.layer.borderWidth = 1.0;
    if (self.gemArr.count>1) {
        for (ThingModel *tmp in self.thingsArr) {
            if (self.gemArr[1]==tmp.thingId) {
                gemView2.image = [ImageClip imageWithPngName:tmp.image];
            }
        }
    }
    [self.view addSubview:gemView2];
    
    UIImageView *gemView3 = [[UIImageView alloc]initWithFrame:CGRectMake(W(210), H(396), W(60), H(60))];
    gemView3.layer.borderWidth = 1.0;
    if (self.gemArr.count>2) {
        for (ThingModel *tmp in self.thingsArr) {
            if (self.gemArr[2]==tmp.thingId) {
                gemView3.image = [ImageClip imageWithPngName:tmp.image];
            }
        }
    }
    [self.view addSubview:gemView3];
    
    UIImageView *gemView4 = [[UIImageView alloc]initWithFrame:CGRectMake(W(28), H(474), W(60), H(60))];
    gemView4.layer.borderWidth = 1.0;
    if (self.gemArr.count>3) {
        for (ThingModel *tmp in self.thingsArr) {
            if (self.gemArr[3]==tmp.thingId) {
                gemView4.image = [ImageClip imageWithPngName:tmp.image];
            }
        }
    }
    [self.view addSubview:gemView4];
    
    UIImageView *gemView5 = [[UIImageView alloc]initWithFrame:CGRectMake(W(116), H(474), W(60), H(60))];
    gemView5.layer.borderWidth = 1.0;
    if (self.gemArr.count>4) {
        for (ThingModel *tmp in self.thingsArr) {
            if (self.gemArr[4]==tmp.thingId) {
                gemView5.image = [ImageClip imageWithPngName:tmp.image];
            }
        }
    }
    [self.view addSubview:gemView5];
    
    UIImageView *gemView6 = [[UIImageView alloc]initWithFrame:CGRectMake(W(210), H(474), W(60), H(60))];
    gemView6.layer.borderWidth = 1.0;
    if (self.gemArr.count>5) {
        for (ThingModel *tmp in self.thingsArr) {
            if (self.gemArr[5]==tmp.thingId) {
                gemView6.image = [ImageClip imageWithPngName:tmp.image];
            }
        }
    }
    [self.view addSubview:gemView6];

    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}


@end

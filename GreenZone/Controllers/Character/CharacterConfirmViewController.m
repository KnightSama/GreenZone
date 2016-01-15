//
//  CharacterConfirmViewController.m
//  GreenZone
//
//  Created by zqh on 15/7/2.
//  Copyright (c) 2015年 student. All rights reserved.
//

#import "CharacterConfirmViewController.h"
#import "CharacterModel.h"
#import "ImageClip.h"
#import "MBProgressHUD+MJ.h"
#import "MBProgressHUD.h"
#import "GameFunction.h"
@interface CharacterConfirmViewController ()<UIAlertViewDelegate>

@end

@implementation CharacterConfirmViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"创建角色";
    [self createView];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ClickStarImage:)];
    [self.starImageView addGestureRecognizer:tapGesture];
    self.starImageView.userInteractionEnabled = YES;
}

/**
 *  创建视图
 */
-(void)createView{
    self.faceImageView.image = [ImageClip imageWithFaceImage:self.character.faceImage getByLocation:@0];
    self.nameView.text = self.character.name;
    self.nameView.enabled = NO;
    self.nameView.backgroundColor = [UIColor clearColor];
    self.attakView.text = [NSString stringWithFormat:@"攻击力: %@",self.character.attack];
    self.defenceView.text = [NSString stringWithFormat:@"防御力: %@",self.character.defence];
    self.powerView.text = [NSString stringWithFormat:@"行动值: %@",self.character.power];
    self.leadView.text = [NSString stringWithFormat:@"领导力: %@",self.character.leadAbility];
    self.descriptionView.text = self.character.characterDescription;
    self.descriptionView.font = [UIFont systemFontOfSize:23];
    self.descriptionView.backgroundColor = [UIColor clearColor];
    self.frontView.animationImages = [ImageClip imageArrWithCharacterImage:self.character.animationImage getByDirectionNumber:@0];
    self.frontView.animationDuration = 0.5;
    [self.frontView startAnimating];
    self.leftView.animationImages = [ImageClip imageArrWithCharacterImage:self.character.animationImage getByDirectionNumber:@1];
    self.leftView.animationDuration = 0.5;
    [self.leftView startAnimating];
    self.rightView.animationImages = [ImageClip imageArrWithCharacterImage:self.character.animationImage getByDirectionNumber:@2];
    self.rightView.animationDuration = 0.5;
    [self.rightView startAnimating];
    self.backView.animationImages = [ImageClip imageArrWithCharacterImage:self.character.animationImage getByDirectionNumber:@3];
    self.backView.animationDuration = 0.5;
    [self.backView startAnimating];
    [self createAnimatingForStar];
}

/**
 *  创建按钮并添加动画
 */
-(void)createAnimatingForStar{
    CABasicAnimation *animation=[CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation.fromValue=[NSNumber numberWithFloat:0];
    animation.toValue=[NSNumber numberWithFloat:2*M_PI];//旋转360°
    animation.duration=3;
    animation.repeatCount=NSNotFound;
    animation.autoreverses=NO;
    [self.starImageView.layer addAnimation:animation forKey:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)changName:(id)sender {
    UIButton *button = sender;
    if (self.nameView.enabled) {
        self.nameView.enabled = NO;
        [button setTitle:@"修改" forState:UIControlStateNormal];
    }else{
        self.nameView.enabled = YES;
        [button setTitle:@"确定" forState:UIControlStateNormal];
        [self.view endEditing:YES];
    }
}

/**
 *  点击图形后的方法
 */
-(void)ClickStarImage:(UITapGestureRecognizer *)tapGesture{
    if (![self.nameView.text isEqualToString:@""]) {
        NSString *msg = [NSString stringWithFormat:@"是否与%@签订契约",self.nameView.text];
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"契约声明" message:msg delegate:self cancelButtonTitle:@"再考虑一下" otherButtonTitles:@"决定了", nil];
        [alert show];
    }else{
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"契约不成立" message:@"不考虑起一个名字吗?" delegate:self cancelButtonTitle:@"考虑一下" otherButtonTitles:nil, nil];
        [alert show];
    }
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==1) {
        GameFunction *game = [[GameFunction alloc]init];
        self.character.name = self.nameView.text;
        [game startNewGameByCharacter:self.character];
    }
}
@end

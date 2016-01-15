//
//  CreateCharacterSelectViewController.m
//  GreenZone
//
//  Created by zqh on 15/7/1.
//  Copyright (c) 2015年 student. All rights reserved.
//

#import "CreateCharacterSelectViewController.h"
#import "CharacterModel.h"
#import "AppDelegate.h"
#import "ImageClip.h"
#import "CharacterConfirmViewController.h"
#import "AudioTool.h"
@interface CreateCharacterSelectViewController ()

@end

@implementation CreateCharacterSelectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIApplication *application = [UIApplication sharedApplication];
    application.statusBarHidden = NO;
    self.CharacterArray = [CharacterModel allCharactersList];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    self.player = [AudioTool playMusic:@"chooseCharactor.mp3"];
    self.player.numberOfLoops = NSNotFound;
}

#pragma mark tableView代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.CharacterArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    for (UIView *view in cell.subviews) {
        [view removeFromSuperview];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    CharacterModel *character = (CharacterModel *)self.CharacterArray[indexPath.row];
    //添加背景
    UIImageView *backGround = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0,WinWidth, CellHeight)];
    backGround.image = [ImageClip imageWithPngName:@"characterSelectBG"];
    //添加数据
    UIImageView *faceView = [[UIImageView alloc]initWithFrame:CGRectMake(20, 10, 96, 96)];
    faceView.image = [ImageClip imageWithFaceImage:character.faceImage getByLocation:@0];
    UILabel *attrackLable = [[UILabel alloc]initWithFrame:CGRectMake(126, 10, 100, 45)];
    attrackLable.text = [NSString stringWithFormat:@"攻击力: %@",character.attack];
    UILabel *defenceLable = [[UILabel alloc]initWithFrame:CGRectMake(126, 61, 100, 45)];
    defenceLable.text = [NSString stringWithFormat:@"防御力: %@",character.defence];
    UILabel *activeLable = [[UILabel alloc]initWithFrame:CGRectMake(236, 10, 100, 45)];
    activeLable.text = [NSString stringWithFormat:@"行动值: %@",character.power];
    UILabel *leaderLable = [[UILabel alloc]initWithFrame:CGRectMake(236, 61, 100, 45)];
    leaderLable.text = [NSString stringWithFormat:@"统帅值: %@",character.leadAbility];
    //添加视图
    [backGround addSubview:attrackLable];
    [backGround addSubview:defenceLable];
    [backGround addSubview:activeLable];
    [backGround addSubview:leaderLable];
    [backGround addSubview:faceView];
    [cell addSubview:backGround];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return CellHeight;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 70;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WinWidth, 70)];
    backView.backgroundColor = [UIColor yellowColor];
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, WinWidth, 70)];
    imageView.image = [ImageClip imageWithPngName:@"bgBTN5"];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 50)];
    label.center = CGPointMake(backView.frame.size.width/2, backView.frame.size.height/2);
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"请选择一个初始角色";
    [backView addSubview:imageView];
    [backView addSubview:label];
    return backView;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CharacterConfirmViewController *confirmController = [[UIStoryboard storyboardWithName:@"CreateCharacter" bundle:nil]instantiateViewControllerWithIdentifier:@"characterConfirm"];
    confirmController.character = self.CharacterArray[indexPath.row];
    [self.navigationController pushViewController:confirmController animated:YES];
}


/**
 *  返回到开始界面
 */
- (IBAction)gotoStartViewController:(id)sender {
    UIApplication *application = [UIApplication sharedApplication];
    AppDelegate *delegate = application.delegate;
    [delegate gotoStartView];
}
@end

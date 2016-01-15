//
//  LoadGameTableViewController.m
//  GreenZone
//
//  Created by zqh on 15/7/3.
//  Copyright (c) 2015年 student. All rights reserved.
//

#import "LoadGameTableViewController.h"
#import "Save.h"
#import "ImageClip.h"
#import "GameFunction.h"
#import "AudioTool.h"
@interface LoadGameTableViewController ()<UIAlertViewDelegate>

@end

@implementation LoadGameTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"读取游戏";
    //创建左侧按钮
    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(gotoBackView)];
    self.navigationItem.leftBarButtonItem = leftBtn;
    //创建右侧按钮
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc]initWithTitle:@"编辑" style:UIBarButtonItemStyleDone target:self action:@selector(editSave)];
    self.navigationItem.rightBarButtonItem = rightBtn;
}

-(void)viewWillAppear:(BOOL)animated{
    self.player = [AudioTool playMusic:@"saveGame.mp3"];
    self.player.numberOfLoops = NSNotFound;
}

-(void)viewWillDisappear:(BOOL)animated{
    [self.player stop];
}

/**
 *  延迟实例化
 */
-(NSMutableArray *)saveList{
    if (!_saveList) {
        _saveList = [[NSMutableArray alloc]init];
        for (Save *save in [Save loadAllGameSave]) {
            [_saveList insertObject:save atIndex:0];
        }
    }
    return _saveList;
}

/**
 *  通过返回方式创建 @0模态返回  @1导航返回
 */
-(instancetype)initWithBackStyle:(NSNumber *)number{
    if (self = [super init]) {
        self.backStyle = number;
    }
    return self;
}

/**
 *  返回上一个视图
 */
-(void)gotoBackView{
    if ([self.backStyle intValue]==0) {
        [self dismissViewControllerAnimated:YES completion:^{
        }];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}

/**
 *  编辑
 */
-(void)editSave{
    [self setEditing:!self.editing animated:YES];
    [self.navigationItem.rightBarButtonItem setTitle:self.editing?@"确定":@"编辑"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.saveList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    for (UIView *oldView in cell.subviews) {
        [oldView removeFromSuperview];
    }
    UIImageView *backImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, WinWidth, H(103))];
    backImage.image = [ImageClip imageWithPngName:@"saveSelectBG"];
    [cell addSubview:backImage];
    Save *oldSave = self.saveList[indexPath.row];
    //添加头像
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(W(38), H(19), W(66), H(66))];
    imageView.image = [ImageClip imageWithFaceImage:oldSave.characterModel.faceImage getByLocation:@0];
    [cell addSubview:imageView];
    //添加时间标签
    UILabel *timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(W(110), H(19), W(179), H(21))];
    timeLabel.font = [UIFont systemFontOfSize:15];
    timeLabel.textColor = [UIColor orangeColor];
    //设置日期显示格式
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"MM-dd HH:mm:ss"];
    NSString *dateStr = [formatter stringFromDate:oldSave.date];
    timeLabel.text = [NSString stringWithFormat:@"时间:%@",dateStr];
    [cell addSubview:timeLabel];
    //添加血量显示标签
    UILabel *hpLabel = [[UILabel alloc]initWithFrame:CGRectMake(W(110), H(41), W(72), H(21))];
    hpLabel.font = [UIFont systemFontOfSize:15];
    hpLabel.textColor = [UIColor greenColor];
    hpLabel.text = [NSString stringWithFormat:@"HP:%@",oldSave.characterModel.currentBlood];
    [cell addSubview:hpLabel];
    //添加钱币显示标签
    UILabel *moneyLabel = [[UILabel alloc]initWithFrame:CGRectMake(W(190), H(41), W(99), H(21))];
    moneyLabel.font = [UIFont systemFontOfSize:15];
    moneyLabel.textColor = [UIColor yellowColor];
    moneyLabel.text = [NSString stringWithFormat:@"金钱:%@",oldSave.characterModel.money];
    [cell addSubview:moneyLabel];
    //添加位置显示标签
    UILabel *locationLabel = [[UILabel alloc]initWithFrame:CGRectMake(W(110), H(64), W(179), H(21))];
    locationLabel.font = [UIFont systemFontOfSize:15];
    locationLabel.textColor = [UIColor purpleColor];
    locationLabel.text = [NSString stringWithFormat:@"位置:(%@,%@)",oldSave.characterPointX,oldSave.characterPointY];
    [cell addSubview:locationLabel];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return H(103);
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

/**
 *  编辑完成的方法
 */
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        self.indexPath = indexPath;
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:@"确定要删除这个存档吗?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        alert.tag = 101;
        [alert show];
    }
}

/**
 *  选中的方法
 */
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.location = indexPath.row;
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:@"确定要载入这个存档吗?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alert.tag = 100;
    [alert show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag==100) {
        if (buttonIndex==1) {
            //载入存档的方法
            [self.player stop];
            Save *save = self.saveList[self.location];
            GameFunction *game = [[GameFunction alloc]init];
            [game startGameBySaveData:save];
        }
    }
    if (alertView.tag==101) {
        if (buttonIndex==1) {
            //删除存档的方法
            Save *save = self.saveList[self.indexPath.row];
            [save deleteSaveData];
            [self.saveList removeObjectAtIndex:self.indexPath.row];
            [self.tableView deleteRowsAtIndexPaths:@[self.indexPath] withRowAnimation:UITableViewRowAnimationFade];
        }
    }
}

@end

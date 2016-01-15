//
//  SaveGameTableViewController.m
//  GreenZone
//
//  Created by zqh on 15/7/5.
//  Copyright (c) 2015年 student. All rights reserved.
//

#import "SaveGameTableViewController.h"
#import "Save.h"
#import "ImageClip.h"
#import "LoadGameTableViewController.h"
#import "AudioTool.h"
@interface SaveGameTableViewController ()<UIAlertViewDelegate>

@end

@implementation SaveGameTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"保存游戏";
    //创建左侧按钮
    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(gotoBackView)];
    self.navigationItem.leftBarButtonItem = leftBtn;
    //创建右侧按钮
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc]initWithTitle:@"读取存档" style:UIBarButtonItemStyleDone target:self action:@selector(gotoLoadSave)];
    self.navigationItem.rightBarButtonItem = rightBtn;
}


-(void)viewWillAppear:(BOOL)animated{
    self.player = [AudioTool playMusic:@"saveGame.mp3"];
    self.player.numberOfLoops = NSNotFound;
    [self.tableView reloadData];
}

-(void)viewWillDisappear:(BOOL)animated{
    [self.player stop];
}

/**
 *  延迟实例化
 */
-(NSMutableArray *)saveList{
    if (!_saveList) {
        _saveList = [[NSMutableArray alloc]initWithArray:[Save loadAllGameSave]];
    }
    return _saveList;
}

/**
 *  通过新的存档创建
 */
-(instancetype)initWithSave:(Save *)save{
    if (self = [super init]) {
        self.save = save;
    }
    return self;
}

/**
 *  返回上一个视图
 */
-(void)gotoBackView{
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}

/**
 *  跳转到读取存档
 */
-(void)gotoLoadSave{
    LoadGameTableViewController *loadController = [[LoadGameTableViewController alloc]initWithBackStyle:@1];
    [self.navigationController pushViewController:loadController animated:YES];
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
    return self.saveList.count+1;
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
    if (indexPath.row==self.saveList.count) {
        UILabel *saveLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, WinWidth, H(103))];
        saveLabel.backgroundColor = [UIColor clearColor];
        saveLabel.textAlignment = NSTextAlignmentCenter;
        saveLabel.textColor = [UIColor whiteColor];
        saveLabel.font = [UIFont systemFontOfSize:40];
        saveLabel.text = @"新 数 据";
        [cell addSubview:saveLabel];
    }else{
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
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return H(103);
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //初始化存档标志
    NSDate *now=[NSDate date];
    //设置日期显示格式
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"MMddHHmmss"];
    NSString *dateStr = [formatter stringFromDate:now];
    NSNumber *number = [NSNumber numberWithInt:dateStr.intValue];
    self.save.sId = number;
    self.save.name = [NSString stringWithFormat:@"save%@",dateStr];
    self.save.date = now;
    if (indexPath.row==self.saveList.count) {
        [self.saveList addObject:self.save];
        [self.save saveGame];
        [self.tableView reloadData];
    }else{
        self.location = indexPath.row;
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:@"确定覆盖这个存档吗?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert show];
    }
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==1) {
        Save *save = self.saveList[self.location];
        [self.saveList removeObjectAtIndex:self.location];
        self.save.sId = save.sId;
        [self.saveList insertObject:self.save atIndex:self.location];
        [self.save saveGameByDeleteSaveId:save.sId];
        [self.tableView reloadData];
    }
}

@end

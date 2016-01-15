//
//  GeneralSelectTableViewController.m
//  GreenZone
//
//  Created by student on 15-7-6.
//  Copyright (c) 2015年 student. All rights reserved.
//

#import "GeneralSelectTableViewController.h"
#import "Save.h"
#import "ImageClip.h"
#import "GeneralModel.h"
@interface GeneralSelectTableViewController ()

@end

@implementation GeneralSelectTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"选择出战武将";
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(gotoBack)];
    self.navigationItem.leftBarButtonItem = item;
    
}

/**
 *  返回上个界面
 */
-(void)gotoBack{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}


/**
 *  通过存档和武将体力初始化
 */
-(instancetype)initWithSave:(Save *)save andNumber:(NSNumber *)number{
    if (self = [super init]) {
        self.save = save;
        self.number = number;
    }
    return self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.save.characterModel.carryingGeneral.count;
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
    
    UIImageView *backImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, WinWidth, H(113))];
    backImage.image = [ImageClip imageWithPngName:@"Sword"];
    backImage.alpha = 0.5;
    [cell addSubview:backImage];
    GeneralModel *oneGeneral = self.save.characterModel.carryingGeneral[indexPath.row];
    //添加头像
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(W(8), H(8), W(96), H(96))];
    imageView.image = [ImageClip imageWithFaceImage:oneGeneral.image getByLocation:@0];
    imageView.layer.borderWidth = 1.0;
    [cell addSubview:imageView];
    //添加姓名
    UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(W(112), H(8), W(193), H(30))];
    nameLabel.text = oneGeneral.name;
    nameLabel.layer.borderWidth = 1.0;
    [cell addSubview:nameLabel];
    //添加攻击力
    UIView *atkView = [[UIView alloc]initWithFrame:CGRectMake(W(112), H(41), W(95), H(30))];
    atkView.layer.borderWidth = 1.0;
    [cell addSubview:atkView];
    UIImageView *atkImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0,0, W(30), H(30))];
    atkImageView.image = [ImageClip imageWithPngName:@"icon07"];
    [atkView addSubview:atkImageView];
    UILabel *atkLabel = [[UILabel alloc]initWithFrame:CGRectMake(W(30), 0, W(95)-W(30), H(30))];
    atkLabel.text = [NSString stringWithFormat:@"%@",oneGeneral.attack];
    [atkView addSubview:atkLabel];
    //添加防御力
    UIView *defView = [[UIView alloc]initWithFrame:CGRectMake(W(210), H(41), W(95), H(30))];
    defView.layer.borderWidth = 1.0;
    [cell addSubview:defView];
    UIImageView *defImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0,0, W(30), H(30))];
    defImageView.image = [ImageClip imageWithPngName:@"icon01"];
    [defView addSubview:defImageView];
    UILabel *defLabel = [[UILabel alloc]initWithFrame:CGRectMake(W(30), 0, WinWidth-W(30), H(30))];
    defLabel.text = [NSString stringWithFormat:@"%@",oneGeneral.defence];
    [defView addSubview:defLabel];
    //添加体力值
    UIView *powerView = [[UIView alloc]initWithFrame:CGRectMake(W(112), H(74), W(95), H(30))];
    powerView.layer.borderWidth = 1.0;
    [cell addSubview:powerView];
    UIImageView *powerImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0,0, W(30), H(30))];
    powerImageView.image = [ImageClip imageWithPngName:@"icon55"];
    [powerView addSubview:powerImageView];
    UILabel *powerLabel = [[UILabel alloc]initWithFrame:CGRectMake(W(30), 0, WinWidth-W(30), H(30))];
    powerLabel.text = [NSString stringWithFormat:@"%@",oneGeneral.power];
    [defView addSubview:powerLabel];
    //添加带兵数
    UIView *maxSoldiersView = [[UIView alloc]initWithFrame:CGRectMake(W(210), H(74), W(95), H(30))];
    [cell addSubview:maxSoldiersView];
    maxSoldiersView.layer.borderWidth = 1.0;
    UIImageView *maxSoldiersImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, W(30), H(30))];
    maxSoldiersImageView.image = [ImageClip imageWithPngName:@"icon80b"];
    [maxSoldiersView addSubview:maxSoldiersImageView];
    UILabel *maxSoldiersLabel = [[UILabel alloc]initWithFrame:CGRectMake(W(30), 0, WinWidth-W(30), H(30))];
    maxSoldiersLabel.text =[NSString stringWithFormat:@"%@",oneGeneral.maxSoldiers];
    [maxSoldiersView addSubview:maxSoldiersLabel];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}




@end

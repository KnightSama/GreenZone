//
//  CheckGeneralTableViewController.m
//  GreenZone
//
//  Created by niit on 15-7-7.
//  Copyright (c) 2015年 student. All rights reserved.
//

#define WinWidth [UIScreen mainScreen].bounds.size.width
#define WinHeight [UIScreen mainScreen].bounds.size.height

#define W(x) WinWidth*x/320.0
#define H(y) WinHeight*y/568.0

#import "CheckGeneralTableViewController.h"
#import "Save.h"
#import "GeneralModel.h"
#import "ImageClip.h"
#import "AudioTool.h"

@interface CheckGeneralTableViewController ()

@end

@implementation CheckGeneralTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSMutableArray *allGenerals = self.save.characterModel.carryingGeneral;
    
    self.title = @"携带武将列表";
    UIBarButtonItem *left = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(gotoBack)];
    self.navigationItem.leftBarButtonItem = left;
    
    
    //搜索符合条件的武将
    for (GeneralModel *tmp in allGenerals)
    {
        if ([tmp.power integerValue]>=10)
        {
            [self.generals addObject:tmp];
        }
    }
}

-(void)viewWillAppear:(BOOL)animated{
    self.player  = [AudioTool playMusic:@"chooseCharactor.mp3"];
}

-(void)viewWillDisappear:(BOOL)animated{
    [self.player stop];
}



//返回上一层
-(void)gotoBack
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(passValue:)])
    {
        [self.delegate passValue:self.general];
    }
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

/**
 *  延迟实例化
 */
-(NSMutableArray *)generals
{
    if (!_generals)
    {
        _generals = [[NSMutableArray alloc]init];
    }
    return _generals;
}

/**
 *  通过存档初始化
 */
-(instancetype)initWithSave:(Save *)save
{
    if (self = [super init])
    {
        self.save = save;
    }
    return self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.generals.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.frame = CGRectMake(0, 0, W(320), H(91));
    cell.backgroundColor = [UIColor clearColor];
    
    GeneralModel *general = self.generals[indexPath.row];
    
    //武将图片
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(W(16), H(12), W(78), H(68))];
    imageView.image = [ImageClip imageWithFaceImage:general.image getByLocation:@0];
    [cell addSubview:imageView];
    
    //武将攻击力和防御力
    
    UILabel *attLabel = [[UILabel alloc]initWithFrame:CGRectMake(W(33), H(0), W(44), H(32))];
    attLabel.text = [NSString stringWithFormat:@"%li",[general.attack integerValue]];
    attLabel.textAlignment = NSTextAlignmentCenter;
    attLabel.layer.borderWidth = 1.0;
    
    UIImageView *attackImageView = [[UIImageView alloc]init];
    attackImageView.image = [ImageClip imageWithPngName:@"icon07"];
    attackImageView.frame = CGRectMake(W(0), H(0), W(33), H(32));
    
    UIView *attackView = [[UIView alloc]initWithFrame:CGRectMake(W(107), H(50), W(77), H(32))];
    attackView.layer.borderWidth = 1.0;
    
    [cell addSubview:attackView];
    [attackView addSubview:attackImageView];
    [attackView addSubview:attLabel];
    
    UILabel *defenceLabel = [[UILabel alloc]initWithFrame:CGRectMake(W(33), H(0), W(44), H(32))];
    defenceLabel.text = [NSString stringWithFormat:@"%li",[general.defence integerValue]];
    defenceLabel.textAlignment = NSTextAlignmentCenter;
    defenceLabel.layer.borderWidth = 1.0;
    
    UIImageView *defenceimageView = [[UIImageView alloc]init];
    defenceimageView.image = [ImageClip imageWithPngName:@"icon01"];
    defenceimageView.frame = CGRectMake(W(0), H(0), W(33), H(32));
    
    UIView *defenceView = [[UIView alloc]initWithFrame:CGRectMake(W(212), H(50), W(77), H(32))];
    defenceView.layer.borderWidth = 1.0;
    
    [cell addSubview:defenceView];
    [defenceView addSubview:defenceLabel];
    [defenceView addSubview:defenceimageView];

    
    //武将名字和体力值
    
    UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(W(107), H(10), W(77), H(32))];
    nameLabel.textAlignment = NSTextAlignmentCenter;
    nameLabel.text = general.name;
    nameLabel.layer.borderWidth = 1.0;
    [cell addSubview:nameLabel];
    
    UILabel *powerLabel = [[UILabel alloc]initWithFrame:CGRectMake(W(33), H(0), W(44), H(32))];
    powerLabel.text = [NSString stringWithFormat:@"%li",[general.power integerValue]];
    powerLabel.textAlignment = NSTextAlignmentCenter;
    powerLabel.layer.borderWidth = 1.0;
    
    UIImageView *powerImage = [[UIImageView alloc]initWithFrame:CGRectMake(W(0), H(0), W(33), H(32))];
    powerImage.image = [ImageClip imageWithPngName:@"icon55"];
    
    UIView *powerView = [[UIView alloc]initWithFrame:CGRectMake(W(212), H(10), W(77), H(32))];
    powerView.layer.borderWidth = 1.0;
    
    [cell addSubview:powerView];
    [powerView addSubview:powerLabel];
    [powerView addSubview:powerImage];
    
    
    
    return cell;
}

/**
 *  设置行高
 */
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return H(91);
}

/**
 *  取到选择的行
 */
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.general = self.generals[indexPath.row];
    if (self.delegate&&[self.delegate respondsToSelector:@selector(passValue:)]) {
        [self.delegate passValue:self.general];
    }
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}




@end

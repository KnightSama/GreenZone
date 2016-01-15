//
//  UsingThingsTBVC.m
//  GreenZone
//
//  Created by student on 15/7/7.
//  Copyright (c) 2015年 student. All rights reserved.
//

#import "UsingThingsTBVC.h"
#import "ThingModel.h"
#import "packageThingsShowModel.h"
#import "UsingThingsTableViewCell.h"
#import "AudioTool.h"


#define mainWidth [UIScreen mainScreen].bounds.size.width
#define mainHeight [UIScreen mainScreen].bounds.size.height

#define W(x) (mainWidth*x/320)
#define H(y) (mainHeight*y/528)

@interface UsingThingsTBVC ()<UsingThingsTableViewCellUsingDelegate>

/**
 *  存档中的所有物品数组
 */
@property(nonatomic,strong) NSArray *allThings;
/**
 *  包裹中的物品数组
 */
@property(nonatomic,strong) NSMutableArray *thingsArr;

/**
 *  使用的一次性物品数组
 */
@property(nonatomic,strong) NSArray *oneTimeUsingthings;

/**
 *  显示详细物品信息View
 */
@property(nonatomic,strong) UIView *showDetail;

/**
 *  存档数据
 */
@property(nonatomic,strong) Save *saveData;

@end

@implementation UsingThingsTBVC


/**
 *  获取所有物品
 */
- (NSArray *)allThings
{
    if (_allThings == nil) {
        _allThings = [ThingModel allThingsList];
    }
    return _allThings;
}


- (void)usingThingWithSavedata:(Save *)save
{
    self.saveData = [[Save alloc]init];
    self.saveData = save;
    self.thingsArr = [[NSMutableArray alloc]init];
    CharacterModel *character = save.characterModel;
    NSDictionary *tmpdict = character.package;
    NSArray *tmpArr = [tmpdict allKeys];
    for (NSString *thingID in tmpArr) {
        for (ThingModel *model in self.allThings){
            if ([model.thingId isEqual:thingID]) {
                
                packageThingsShowModel *thingsModel = [[packageThingsShowModel alloc]init];//存储的是物品及其数量
                thingsModel.thing = model;
                
                NSNumber *thingCount = [tmpdict objectForKey:thingID];
                thingsModel.thingsCount = thingCount.intValue;
                [self.thingsArr addObject:thingsModel];
            }
        }
    }
}
/**
 *  筛选出使用物品
 */
- (NSArray *)oneTimeUsingthings
{
//    if (_oneTimeUsingthings == nil) {
        NSMutableArray *tmpArr = [NSMutableArray array];
        for (packageThingsShowModel *model in self.thingsArr) {
            if([model.thing.thingId integerValue]<7000&&[model.thing.thingId integerValue]>5000)
            {
                [tmpArr addObject:model];
            }
        }
        _oneTimeUsingthings = tmpArr;
//    }
    return _oneTimeUsingthings;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"物品列表";
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(gotoBack)];
    self.navigationItem.leftBarButtonItem = item;
    self.tableView.rowHeight = H(100);
    
}

- (void)viewWillAppear:(BOOL)animated
{
    self.player = [AudioTool playMusic:@"eventList.mp3"];
    self.player.numberOfLoops = NSNotFound;
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self.player stop];
}

-(void)gotoBack{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.oneTimeUsingthings.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *indentifier = @"cell";
    UsingThingsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
    if (cell == nil) {
        cell = [[UsingThingsTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.thingShowModel = self.oneTimeUsingthings[indexPath.row];
    cell.saveDataIncell = self.saveData;
    cell.delegate = self;
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.showDetail != nil) {
        [self.showDetail removeFromSuperview];
    }
    tableView.scrollEnabled = NO;
    packageThingsShowModel *model = self.oneTimeUsingthings[indexPath.row];
    
    self.showDetail = [[UIView alloc]initWithFrame:CGRectMake(W(50), H(150), W(210), H(210))];
    self.showDetail.alpha = 0;
    //    self.showDetail.layer.borderColor = [UIColor redColor].CGColor;
    //    self.showDetail.layer.borderWidth = 1;
    self.showDetail.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.showDetail];
    
    UIImageView *bg1 = [[UIImageView alloc]initWithFrame:CGRectMake(W(0), H(0), W(210), H(210))];
    bg1.image = [UIImage imageNamed:@"messageBG.jpg"];
    [self.showDetail addSubview:bg1];
    
    UIImageView *bg2 = [[UIImageView alloc]initWithFrame:CGRectMake(W(0), H(0), W(210), H(210))];
    bg2.image = [UIImage imageNamed:@"边框"];
    [self.showDetail addSubview:bg2];
    
    
    UIImageView *thingsIcon = [[UIImageView alloc]initWithFrame:CGRectMake(W(10), H(20), W(80), W(80))];
    thingsIcon.image = [UIImage imageNamed:model.thing.image];
    [self.showDetail addSubview:thingsIcon];
    
    UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(thingsIcon.frame)+W(10), thingsIcon.frame.origin.y, W(80), H(20))];
    nameLabel.text = model.thing.name;
    nameLabel.numberOfLines = 0;
    [self.showDetail addSubview:nameLabel];
    
    UILabel *moneyLabel = [[UILabel alloc]initWithFrame:CGRectMake(nameLabel.frame.origin.x, H(60), W(80), H(20))];
    moneyLabel.text = [NSString stringWithFormat:@"$ %.3f",model.thing.price.floatValue];
    [self.showDetail addSubview:moneyLabel];
    
    UITextView *descriLabel = [[UITextView alloc]initWithFrame:CGRectMake(W(15),H(110), W(180), H(60))];
    descriLabel.text = model.thing.thingDescription;
    descriLabel.backgroundColor = [UIColor clearColor];
    descriLabel.editable = NO;
    [self.showDetail addSubview:descriLabel];
    
    UIButton *resignBtn = [[UIButton alloc]initWithFrame:CGRectMake(W(80), CGRectGetMaxY(descriLabel.frame)+H(5), W(40), H(20))];
    [resignBtn setTitle:@"确认" forState:UIControlStateNormal];
    [resignBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [resignBtn addTarget:self action:@selector(clickResignBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.showDetail addSubview:resignBtn];
    
    
    [UIView animateWithDuration:0.6 animations:^{
        self.showDetail.alpha = 1.0;
    }];
}

- (void)clickResignBtn:(UIButton *)btn
{
    [self.showDetail removeFromSuperview];
    self.tableView.scrollEnabled = YES;
}

- (void)clickUsingThingsBtn:(Save *)save
{
    [self usingThingWithSavedata:save];
    [self.tableView reloadData];
}

@end

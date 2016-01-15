//
//  BackpackViewController.m
//  backpack
//
//  Created by student on 15/7/6.
//  Copyright (c) 2015年 youki. All rights reserved.
//

#define mainWidth [UIScreen mainScreen].bounds.size.width
#define mainHeight [UIScreen mainScreen].bounds.size.height

#define W(x) (mainWidth*x/320)
#define H(y) (mainHeight*y/528)

#define chooseTypeBtnCount 4
#define chooseTypeBtnWidth 70
#define chooseTypeBtnHeight 40
#define padding 10

#import "BackpackViewController.h"
#import "ThingModel.h"
#import "packageThingsShowModel.h"
#import "PakageCollectionViewCell.h"
#import "ImageClip.h"
#import "AudioTool.h"

@interface BackpackViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UIAlertViewDelegate>

/**
 *  物品类型选择按钮承载View
 */
@property (weak, nonatomic) IBOutlet UIView *chooseTypeView;

/**
 *  物品显示UICollectionView
 */
@property (weak, nonatomic) IBOutlet UICollectionView *thingsShow;

/**
 *  攻击类型
 */
@property (weak, nonatomic) IBOutlet UIButton *attackBtn;
/**
 *  防御类型
 */
@property (weak, nonatomic) IBOutlet UIButton *defenseBtn;
/**
 *  回复类型
 */
@property (weak, nonatomic) IBOutlet UIButton *recoverBtn;
/**
 *  卡片类型
 */
@property (weak, nonatomic) IBOutlet UIButton *cardBtn;

/**
 *  攻击类型物品数组
 */
@property(nonatomic,strong) NSArray *attackTypeArr;

/**
 *  防御类型物品数组
 */
@property(nonatomic,strong) NSArray *defenseTypeArr;

/**
 *  回复类型物品数组
 */
@property(nonatomic,strong) NSArray *recoverTypeArr;

/**
 *  卡片物品数组
 */
@property(nonatomic,strong) NSArray *cardTypeArr;

/**
 *  人物物品的字典
 */
@property(nonatomic,strong) NSDictionary *packageList;

/**
 *  所有物品
 */
@property(nonatomic,strong) NSArray *allThings;

/**
 *  人物所拥有的物品数组
 */
@property(nonatomic,strong) NSMutableArray *packageThingsArr;



/**
 *  collectionView的数据源数组
 */
@property(nonatomic,strong) NSArray *collectionDataSourceArr;


/**
 *  物品展示窗口view
 */
@property(nonatomic,strong) UIView *showDetail;

/**
 *  人物
 */
@property(nonatomic,strong) CharacterModel *character;


/**
 *  每个collectionView cell的物品model
 */
@property(nonatomic,strong) ThingModel *cellThingModel;



@end

@implementation BackpackViewController


- (void)packageWithSavedata:(Save *)save
{
    self.packageThingsArr = [[NSMutableArray alloc]init];
    self.cellThingModel = [[ThingModel alloc]init];
    self.character = save.characterModel;
    NSDictionary *tmpdict = self.character.package;
    NSArray *tmpArr = [tmpdict allKeys];
    for (NSString *thingID in tmpArr) {
         for (ThingModel *model in self.allThings){
            if ([model.thingId isEqual:thingID]) {
                
                packageThingsShowModel *thingsModel = [[packageThingsShowModel alloc]init];
                thingsModel.thing = model;
                
                NSNumber *thingCount = [tmpdict objectForKey:thingID];
                thingsModel.thingsCount = thingCount.intValue;
                [self.packageThingsArr addObject:thingsModel];
            }
        }
    }
}

- (void)setPackageList:(NSDictionary *)packageList
{
    _packageList = packageList;
}

- (NSArray *)allThings
{
    if (_allThings == nil) {
        _allThings = [ThingModel allThingsList];
    }
    return _allThings;
}

- (NSArray *)attackTypeArr
{
    //if(_attackTypeArr == nil)
    //{
        NSMutableArray *tmpArr = [NSMutableArray array];
        for (packageThingsShowModel *model in self.packageThingsArr) {
            if([model.thing.thingId integerValue]<3000&&[model.thing.thingId integerValue]>1000)
            {
                [tmpArr addObject:model];
            }
        }
        _attackTypeArr = tmpArr;
    //}
    return _attackTypeArr;
    
    
}

- (NSArray *)defenseTypeArr
{
    //if(_defenseTypeArr == nil)
    //{
        NSMutableArray *tmpArr = [NSMutableArray array];
        for (packageThingsShowModel *model in self.packageThingsArr) {
            if([model.thing.thingId integerValue]<5000&&[model.thing.thingId integerValue]>3000)
            {
                [tmpArr addObject:model];
            }
        }
        _defenseTypeArr = tmpArr;
    //}
    return _defenseTypeArr;
}

- (NSArray *)recoverTypeArr
{
    //if (_recoverTypeArr == nil) {
        NSMutableArray *tmpArr = [NSMutableArray array];
        for (packageThingsShowModel *model in self.packageThingsArr) {
            if([model.thing.thingId integerValue]<7000&&[model.thing.thingId integerValue]>5000)
            {
                [tmpArr addObject:model];
            }
        }
        _recoverTypeArr = tmpArr;
   // }
    return _recoverTypeArr;
}

- (NSArray *)cardTypeArr
{
    //if (_cardTypeArr == nil) {
        NSMutableArray *tmpArr = [NSMutableArray array];
        for (packageThingsShowModel *model in self.packageThingsArr) {
            if([model.thing.thingId integerValue]>7000 && [model.thing.thingId integerValue]<9000)
            {
                [tmpArr addObject:model];
            }
        }
        _cardTypeArr = tmpArr;
   // }
    return _cardTypeArr;
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

- (void)viewDidLoad {
    
//    UIImageView *bkImage = [[UIImageView alloc]initWithFrame:self.view.bounds];
//    bkImage.image = [UIImage imageNamed:@"messageBG.jpg"];
//    [self.view addSubview:bkImage];
    
//    self.chooseTypeView.backgroundColor = [UIColor clearColor];
    
    self.navigationItem.title = @"物品列表";
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(gotoBack)];
    self.navigationItem.leftBarButtonItem = item;
    
    self.attackBtn.layer.borderWidth = 1;
    self.attackBtn.layer.borderColor = [UIColor blackColor].CGColor;
    self.attackBtn.backgroundColor = [UIColor clearColor];
    
    self.defenseBtn.layer.borderWidth = 1;
    self.defenseBtn.layer.borderColor = [UIColor blackColor].CGColor;
    self.defenseBtn.backgroundColor = [UIColor clearColor];
    
    self.recoverBtn.layer.borderWidth = 1;
    self.recoverBtn.layer.borderColor = [UIColor blackColor].CGColor;
    self.recoverBtn.backgroundColor = [UIColor clearColor];
    
    self.cardBtn.layer.borderWidth = 1;
    self.cardBtn.layer.borderColor = [UIColor blackColor].CGColor;
    self.cardBtn.backgroundColor = [UIColor clearColor];
    
    self.thingsShow.showsHorizontalScrollIndicator = NO;
    self.thingsShow.showsVerticalScrollIndicator = NO;
    self.thingsShow.layer.borderColor = [UIColor blackColor].CGColor;
    self.thingsShow.layer.borderWidth = 1;
    self.thingsShow.delegate = self;
    self.thingsShow.dataSource = self;
    self.thingsShow.backgroundColor = [UIColor clearColor];
    self.collectionDataSourceArr = self.packageThingsArr;
}

-(void)gotoBack{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{

    return self.collectionDataSourceArr.count;

}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *indentifier = @"cell";
    PakageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:indentifier forIndexPath:indexPath];
    cell.layer.borderWidth = 1;
    cell.layer.borderColor = [UIColor blackColor].CGColor;
    cell.packageThing = self.collectionDataSourceArr[indexPath.row];
    cell.backgroundColor = [UIColor colorWithWhite:0.4 alpha:0.7];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.showDetail != nil) {
        [self.showDetail removeFromSuperview];
    }
    packageThingsShowModel *model = self.collectionDataSourceArr[indexPath.row];
    self.cellThingModel = model.thing;
    self.showDetail = [[UIView alloc]initWithFrame:CGRectMake(W(50), H(150), W(200), H(200))];
    self.showDetail.alpha = 0;
    
    //创建背景图
    UIImageView *imageBack = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, W(200), H(200))];
    imageBack.image = [ImageClip imageWithJpgName:@"messageBG"];
    [self.showDetail addSubview:imageBack];
    //创建背景边框
    UIImageView *imageBorder = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, W(200), H(200))];
    imageBorder.image = [ImageClip imageWithPngName:@"边框"];
    [self.showDetail addSubview:imageBorder];
    
//    self.showDetail.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.showDetail];
    
    UIImageView *thingsIcon = [[UIImageView alloc]initWithFrame:CGRectMake(W(10), H(10), W(80), W(80))];
    thingsIcon.image = [UIImage imageNamed:model.thing.image];
    [self.showDetail addSubview:thingsIcon];
    
    UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(thingsIcon.frame)+W(10), thingsIcon.frame.origin.y, W(80), H(20))];
    nameLabel.text = model.thing.name;
    [self.showDetail addSubview:nameLabel];
    
    UILabel *moneyLabel = [[UILabel alloc]initWithFrame:CGRectMake(nameLabel.frame.origin.x, H(50), W(80), H(20))];
    moneyLabel.text = [NSString stringWithFormat:@"$ %.3f",model.thing.price.floatValue];
    [self.showDetail addSubview:moneyLabel];
    
    UITextView *descriLabel = [[UITextView alloc]initWithFrame:CGRectMake(W(10),H(100), W(180), H(60))];
    descriLabel.text = model.thing.thingDescription;
    descriLabel.backgroundColor = [UIColor clearColor];
    descriLabel.editable = NO;
    [self.showDetail addSubview:descriLabel];
    
    UIButton *resignBtn = [[UIButton alloc]initWithFrame:CGRectMake(W(80), CGRectGetMaxY(descriLabel.frame)+H(10), W(40), H(20))];
    [resignBtn setTitle:@"关闭" forState:UIControlStateNormal];
    [resignBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [resignBtn addTarget:self action:@selector(clickResignBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.showDetail addSubview:resignBtn];
    
    if(([model.thing.thingId integerValue]<3000&&[model.thing.thingId integerValue]>1000) || ([model.thing.thingId integerValue]<5000&&[model.thing.thingId integerValue]>3000))
    {
        UIButton *usingBtn = [[UIButton alloc]initWithFrame:CGRectMake(W(40), CGRectGetMaxY(descriLabel.frame)+H(10), W(40), H(20))];
        [usingBtn setTitle:@"装备" forState:UIControlStateNormal];
        [usingBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [usingBtn addTarget:self action:@selector(clickUsingBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self.showDetail addSubview:usingBtn];
        
        resignBtn.frame = CGRectMake(W(110), CGRectGetMaxY(descriLabel.frame)+H(10), W(40), H(20));
        
    }
    
    [UIView animateWithDuration:0.6 animations:^{
        self.showDetail.alpha = 1.0;
    }];
    
}

- (void)clickResignBtn:(UIButton *)btn
{
    
    [self.showDetail removeFromSuperview];
}

- (void)clickUsingBtn:(UIButton *)btn
{
    [self.showDetail removeFromSuperview];
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"是否使用" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"是", nil];
    [alert show];
    alert.delegate = self;
}

//UIAlertView 的代理方法
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    
    if (buttonIndex == 1) {
        //1.判断装备栏里是否有东西，有替换，无添加

        if (self.character.equiped.count == 0) {
            NSMutableArray *tmpArr = [NSMutableArray arrayWithArray:self.character.equiped];
            [tmpArr addObject:self.cellThingModel.thingId];
            self.character.equiped = tmpArr;
            [self usingThingChangeCharacterAttri];
        }
        else if(self.character.equiped.count == 1)
        {

            NSString *tmpModel = self.character.equiped[0];
            
            if ([tmpModel intValue] > 1000 && [tmpModel intValue] < 3000 && [self.cellThingModel.thingId intValue] < 3000 && [self.cellThingModel.thingId intValue] > 1000) {//攻击道具
                
                NSMutableArray *tmpArr = [NSMutableArray arrayWithArray:self.character.equiped];
                [tmpArr replaceObjectAtIndex:0 withObject:self.cellThingModel.thingId];
                self.character.equiped = tmpArr;
                
                [self replaceThingChangeCharacterAttriWiththingid:tmpModel];
            }
            else if ([tmpModel intValue] > 3000 && [tmpModel intValue] < 5000 && [self.cellThingModel.thingId intValue] > 3000 && [self.cellThingModel.thingId intValue] < 5000)//防御道具
            {
                NSMutableArray *tmpArr = [NSMutableArray arrayWithArray:self.character.equiped];
                [tmpArr replaceObjectAtIndex:0 withObject:self.cellThingModel.thingId];
                self.character.equiped = tmpArr;
                
                [self replaceThingChangeCharacterAttriWiththingid:tmpModel];
            }
            else
            {
                NSMutableArray *tmpArr = [NSMutableArray arrayWithArray:self.character.equiped];
                [tmpArr addObject:self.cellThingModel.thingId];
                self.character.equiped = tmpArr;
//                [self.character.equiped addObject:self.cellThingModel.thingId];
                [self usingThingChangeCharacterAttri];
            }
        }
        else if(self.character.equiped.count == 2)
        {
           NSString *tmpModel = self.character.equiped[0];
            NSString *tmpModel1 = self.character.equiped[1];
            
            if ([self.cellThingModel.thingId intValue] < 3000 && [self.cellThingModel.thingId intValue] > 1000) {//攻击道具
                
                if ([tmpModel intValue] < 3000 && [tmpModel intValue] > 1000) {
                    
                    NSMutableArray *tmpArr = [NSMutableArray arrayWithArray:self.character.equiped];
                    [tmpArr replaceObjectAtIndex:0 withObject:self.cellThingModel.thingId];
                    self.character.equiped = tmpArr;
                    [self replaceThingChangeCharacterAttriWiththingid:tmpModel];
                }
                else
                {
//                    [self.character.equiped replaceObjectAtIndex:1 withObject:self.cellThingModel.thingId];
                    NSMutableArray *tmpArr = [NSMutableArray arrayWithArray:self.character.equiped];
                    [tmpArr replaceObjectAtIndex:1 withObject:self.cellThingModel.thingId];
                    self.character.equiped = tmpArr;
                    
                    [self replaceThingChangeCharacterAttriWiththingid:tmpModel1];
                }
            }
            else if([self.cellThingModel.thingId intValue] < 5000 && [self.cellThingModel.thingId intValue] > 3000)
            {//防御道具
                if ([tmpModel intValue] < 5000 && [tmpModel intValue] > 3000) {
//                    [self.character.equiped replaceObjectAtIndex:0 withObject:self.cellThingModel.thingId];
                    NSMutableArray *tmpArr = [NSMutableArray arrayWithArray:self.character.equiped];
                    [tmpArr replaceObjectAtIndex:0 withObject:self.cellThingModel.thingId];
                    self.character.equiped = tmpArr;
                    
                    [self replaceThingChangeCharacterAttriWiththingid:tmpModel1];
                }
                else
                {
                    NSMutableArray *tmpArr = [NSMutableArray arrayWithArray:self.character.equiped];
                    [tmpArr replaceObjectAtIndex:1 withObject:self.cellThingModel.thingId];
                    self.character.equiped = tmpArr;
//                    [self.character.equiped replaceObjectAtIndex:1 withObject:self.cellThingModel.thingId];
                    [self replaceThingChangeCharacterAttriWiththingid:tmpModel];
                }
            }
        }
    }
}



//装备物品后修改人物属性
- (void)usingThingChangeCharacterAttri
{
    switch ([self.cellThingModel.eventId intValue]) {
        case 803://增加攻击力
        {
            int tmpAttack = self.character.attack.intValue;
            tmpAttack += [self.cellThingModel.thingId intValue]-1000;
            self.character.attack = [NSNumber numberWithInt:tmpAttack];
            break;
        }
        case 804://增加防御力
        {
            int tmpDefence = self.character.defence.intValue;
            tmpDefence += [self.cellThingModel.thingId intValue]-3000;
            self.character.defence = [NSNumber numberWithInt:tmpDefence];
            break;
        }
        default:
            break;
    }
}


//替代装备修改人物属性
- (void)replaceThingChangeCharacterAttriWiththingid:(NSString *)thingid
{
    
    if ([thingid intValue] < 3000) {
        int attack = self.character.attack.intValue;
        attack -= ([thingid intValue]-1000);
        self.character.attack = [NSNumber numberWithInt:attack];
    }
    else{
        int attack = self.character.attack.intValue;
        attack -= ([thingid intValue]-3000);
        self.character.attack = [NSNumber numberWithInt:attack];
    }
    
    
    switch ([self.cellThingModel.eventId intValue]) {
        case 803://增加攻击力
        {
            int tmpAttack = self.character.attack.intValue;
            tmpAttack += [self.cellThingModel.thingId intValue]-1000;
            self.character.attack = [NSNumber numberWithInt:tmpAttack];
            break;
        }
        case 804://增加防御力
        {
            int tmpDefence = self.character.defence.intValue;
            tmpDefence += [self.cellThingModel.thingId intValue]-3000;
            self.character.defence = [NSNumber numberWithInt:tmpDefence];
            break;
        }
        default:
            break;
    }
}



/**
 *  点击攻击类型按钮
 */
- (IBAction)clickAttackBtn:(UIButton *)sender {
    self.collectionDataSourceArr = self.attackTypeArr;
    [self.thingsShow reloadData];
}
/**
 *  点击防御类型按钮
 */
- (IBAction)clickDefenseBtn:(UIButton *)sender {
    self.collectionDataSourceArr = self.defenseTypeArr;
    [self.thingsShow reloadData];
}
/**
 *  点击回复类型按钮
 */
- (IBAction)clickRecoverBtn:(UIButton *)sender {
    self.collectionDataSourceArr = self.recoverTypeArr;
    [self.thingsShow reloadData];
}
/**
 *  点击卡片类型按钮
 */
- (IBAction)clickCardBtn:(UIButton *)sender {
    self.collectionDataSourceArr = self.cardTypeArr;
    [self.thingsShow reloadData];
}


@end

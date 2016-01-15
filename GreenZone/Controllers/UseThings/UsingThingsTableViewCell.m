//
//  UsingThingsTableViewCell.m
//  GreenZone
//
//  Created by student on 15/7/7.
//  Copyright (c) 2015年 student. All rights reserved.
//

#define mainWidth [UIScreen mainScreen].bounds.size.width
#define mainHeight [UIScreen mainScreen].bounds.size.height

#define W(x) (mainWidth*x/320)
#define H(y) (mainHeight*y/528)


#import "UsingThingsTableViewCell.h"

@interface UsingThingsTableViewCell()<UIAlertViewDelegate>

/**
 *  物品的图片展示
 */
@property(nonatomic,strong) UIImageView *thingIcon;

/**
 *  物品的名称展示
 */
@property(nonatomic,strong) UILabel *thingName;

/**
 *  拥有的物品数量
 */
@property(nonatomic,strong) UILabel *thingCount;

/**
 *  确认使用按钮
 */
@property(nonatomic,strong) UIButton *confirmBtn;

@end

@implementation UsingThingsTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"边框"]];
        
        UIImageView *bg1 = [[UIImageView alloc]initWithFrame:CGRectMake(W(0), H(0), W(320), H(100))];
        bg1.image = [UIImage imageNamed:@"messageBG.jpg"];
        [self.contentView addSubview:bg1];
        
        UIImageView *bg2 = [[UIImageView alloc]initWithFrame:CGRectMake(W(0), H(0), W(320), H(100))];
        bg2.image = [UIImage imageNamed:@"边框"];
        [self.contentView addSubview:bg2];
        
        self.thingIcon = [[UIImageView alloc]initWithFrame:CGRectMake(W(30), H(20), W(60), H(60))];
        [self.contentView addSubview:self.thingIcon];
        
        self.thingName = [[UILabel alloc]initWithFrame:CGRectMake(W(100), H(25), W(150), H(20))];
        [self.contentView addSubview:self.thingName];
        
        self.thingCount = [[UILabel alloc]initWithFrame:CGRectMake(W(100), H(45), W(150), H(20))];
        [self.contentView addSubview:self.thingCount];
        
        self.confirmBtn = [[UIButton alloc]initWithFrame:CGRectMake(W(250), H(37), W(50), H(30))];
        self.confirmBtn.layer.borderColor = [UIColor blackColor].CGColor;
        self.confirmBtn.layer.borderWidth = 1;
        [self.confirmBtn setTitle:@"使用" forState:UIControlStateNormal];
        [self.confirmBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        [self.confirmBtn setTitle:@"使用" forState:UIControlStateHighlighted];
        [self.confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        
        
        [self.contentView addSubview:self.confirmBtn];
        [self.confirmBtn addTarget:self action:@selector(clickConfirmBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)clickConfirmBtn:(UIButton *)btn
{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"确认使用?" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"是", nil];
    [alert show];

}
//当点击点击确认按钮后执行
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        
        CharacterModel *character = self.saveDataIncell.characterModel;
        
        NSMutableDictionary *tmpdict = character.package;
        NSArray *tmpArr = [tmpdict allKeys];//存储的是物品ID
        for (NSString *thingID in tmpArr) {
                if ([self.thingShowModel.thing.thingId isEqual:thingID]) {
                    NSNumber *thingCount = [tmpdict objectForKey:thingID];
                    int count = thingCount.intValue - 1;
                    if (count == 0) {
                        [tmpdict removeObjectForKey:thingID];
                    }
                    else
                    {
                        NSNumber *tmpThingCount = [[NSNumber alloc]initWithInt:count];
                        [tmpdict setObject:tmpThingCount forKey:thingID];
                    }
            }
        }
        
        if(self.thingShowModel.thing.thingId.intValue > 6000)//增加属性的物品
        {
            switch ([self.thingShowModel.thing.eventId intValue]) {
                case 801:
                {
                    int tmpBloodCount = character.currentBlood.intValue;
                    tmpBloodCount += [self.thingShowModel.thing.thingId intValue] - 6000;
                    if(tmpBloodCount > character.blood.intValue )
                    {
                        tmpBloodCount = character.blood.intValue;
                    }
                    character.currentBlood = [NSNumber numberWithInt:tmpBloodCount];
                    break;
                }
                case 802:
                {
                    int tmpPowerCount = character.power.intValue;
                    tmpPowerCount += [self.thingShowModel.thing.thingId intValue] - 6000;
                    if (tmpPowerCount>100) {
                        tmpPowerCount = 100;
                    }
                    character.power = [NSNumber numberWithInt:tmpPowerCount];
                    break;
                }
                case 803:
                {
                    int tmpAttackCount = character.attack.intValue;
                    tmpAttackCount += [self.thingShowModel.thing.thingId intValue] - 6000;
                    character.attack = [NSNumber numberWithInt:tmpAttackCount];
                    break;
                }
                case 804:
                {
                    int tmpDefenseCount = character.defence.intValue;
                    tmpDefenseCount += [self.thingShowModel.thing.thingId intValue] - 6000;
                    character.defence = [NSNumber numberWithInt:tmpDefenseCount];
                    break;
                }
                case 805:
                {
                    int tmpMoenyCount = character.money.intValue;
                    tmpMoenyCount += [self.thingShowModel.thing.thingId intValue] - 6000;
                    character.money = [NSNumber numberWithInt:tmpMoenyCount];
                    break;
                }
                case 806:
                {
                    int tmpBloodCount = character.blood.intValue;
                    tmpBloodCount += [self.thingShowModel.thing.thingId intValue] - 6000;
                    character.blood = [NSNumber numberWithInt:tmpBloodCount];
                    break;
                }
                default:
                    break;
            }
            
        }
        else
        {
            switch ([self.thingShowModel.thing.eventId intValue]) {//减少属性
                case 801:
                {
                    int tmpBloodCount = character.currentBlood.intValue;
                    tmpBloodCount -= ([self.thingShowModel.thing.thingId intValue] - 5000);
                    if(tmpBloodCount < 0 )
                    {
                        tmpBloodCount = 0;
                    }
                    character.currentBlood = [NSNumber numberWithInt:tmpBloodCount];
                    break;
                }
                case 802:
                {
                    int tmpPowerCount = character.power.intValue;
                    tmpPowerCount -= ([self.thingShowModel.thing.thingId intValue] - 5000);
                    if (tmpPowerCount<0) {
                        tmpPowerCount = 0;
                    }
                    character.power = [NSNumber numberWithInt:tmpPowerCount];
                    break;
                }
                case 803:
                {
                    int tmpAttackCount = character.attack.intValue;
                    tmpAttackCount -= ([self.thingShowModel.thing.thingId intValue] - 5000);
                    character.attack = [NSNumber numberWithInt:tmpAttackCount];
                    break;
                }
                case 804:
                {
                    int tmpDefenseCount = character.defence.intValue;
                    tmpDefenseCount -= ([self.thingShowModel.thing.thingId intValue] - 5000);
                    character.defence = [NSNumber numberWithInt:tmpDefenseCount];
                    break;
                }
                case 805:
                {
                    int tmpMoenyCount = character.money.intValue;
                    tmpMoenyCount -= ([self.thingShowModel.thing.thingId intValue] - 5000);
                    character.money = [NSNumber numberWithInt:tmpMoenyCount];
                    break;
                }
                case 806:
                {
                    int tmpBloodCount = character.blood.intValue;
                    tmpBloodCount -= ([self.thingShowModel.thing.thingId intValue] - 6000);
                    character.blood = [NSNumber numberWithInt:tmpBloodCount];
                    break;
                }
                default:
                    break;
            }

        }
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(clickUsingThingsBtn:)]) {
            [self.delegate clickUsingThingsBtn:self.saveDataIncell];
        }
    }
}

- (void)setThingShowModel:(packageThingsShowModel *)thingShowModel
{
    _thingShowModel = thingShowModel;
    ThingModel *model = thingShowModel.thing;
    self.thingIcon.image = [UIImage imageNamed:model.image];
    self.thingName.text = model.name;
    self.thingCount.text = [NSString stringWithFormat:@"拥有：%d 个",thingShowModel.thingsCount];
    if (thingShowModel.thingsCount <= 0) {
        self.confirmBtn.enabled = NO;
    }
}

@end

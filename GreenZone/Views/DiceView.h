//
//  DiceView.h
//  GreenZone
//
//  Created by zqh on 15/6/25.
//  Copyright (c) 2015年 student. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DiceViewDelegate <NSObject>
/**
 *  掷色子开始时调用的方法
 */
-(void)DiceViewStart;
/**
 *  掷色子完成后调用的方法，返回结果的和
 */
-(void)DiceViewStopWithResult:(NSNumber *)resultNum;
/**
 *  掷色子完成后调用的方法，返回详细的结果
 */
-(void)DiceViewStopWithDetailResult:(NSDictionary *)detailResult;

@end

@interface DiceView : UIView
/**
 *  减少一个色子的按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *reduceBtn;
/**
 *  增加色子的按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *addBtn;
/**
 *  开始掷色子的按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *startBtn;
/**
 *  放置色子的视图
 */
@property (weak, nonatomic) IBOutlet UIView *diceView;
/**
 *  一共可以使用的色子数量
 */
@property(nonatomic,strong) NSNumber *totalNumber;
/**
 *  已经显示的色子数量
 */
@property(nonatomic,strong) NSNumber *showNumber;
/**
 *  代理
 */
@property(nonatomic,weak) id<DiceViewDelegate> delegate;
/**
 *  色子图片数组
 */
@property(nonatomic,strong) NSArray *diceImageArr;
/**
 *  色子摇动时的数组
 */
@property(nonatomic,strong) NSArray *animationArr;
//-------------------------------------------------------------

/**
 *  通过色子总数初始化视图
 */
+ (instancetype)diceViewWithTotalNumber:(NSNumber *)totalNum;
/**
 *  减少一个色子的方法
 */
- (IBAction)reduceDice:(id)sender;
/**
 *  增加一个色子的方法
 */
- (IBAction)addDice:(id)sender;
/**
 *  开始掷色子的方法
 */
- (IBAction)startDice:(id)sender;
@end

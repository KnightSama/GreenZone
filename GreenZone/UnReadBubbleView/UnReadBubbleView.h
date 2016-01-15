//
//  UnReadBubbleView.h
//  BubbleViewDemo
//
//  Created by Zhao Yiqi on 15/3/18.
//  Copyright (c) 2015年 Zhao Yiqi. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UnReadBubbleViewDelegate <NSObject>

-(void)UnReadBubbleViewPanGestureStartWithBackView:(UIView *)backView withfrontView:(UIView *)frontView;
-(void)UnReadBubbleViewPanGestureChangeWithBackView:(UIView *)backView withfrontView:(UIView *)frontView;
-(void)UnReadBubbleViewPanGestureEndWithBackView:(UIView *)backView withfrontView:(UIView *)frontView;

@end



@interface UnReadBubbleView : UIView

//气泡上显示数字的label
//the label on the bubble
@property (nonatomic,strong)UILabel *bubbleLabel;

//气泡的直径
//bubble's diameter
@property (nonatomic,assign)CGFloat bubbleWidth;

//气泡粘性系数，越大可以拉得越长
//viscosity of the bubble,the bigger you set,the longer you drag
@property (nonatomic,assign)CGFloat viscosity;

@property (nonatomic,assign)CGFloat breakViscosity;

//气泡颜色
//bubble's color
@property (nonatomic,strong)UIColor *bubbleColor;

//GameCenter动画 default NO
//if you want show GameCenter Animation you can set it yes default NO
@property (nonatomic,assign)BOOL showGameCenterAnimation;

//允许拖拽手势 default yes
//allow PanGestureRecognizer default yes
@property (nonatomic,assign)BOOL allowPan;

@property(nonatomic,weak) id<UnReadBubbleViewDelegate> delegate;

-(void)start;

-(void)dragMe:(UIPanGestureRecognizer *)ges;
@end

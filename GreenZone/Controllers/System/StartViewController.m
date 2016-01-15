//
//  StartViewController.m
//  GreenZone
//
//  Created by zqh on 15/6/15.
//  Copyright (c) 2015年 student. All rights reserved.
//

#define WinWidth [UIScreen mainScreen].bounds.size.width
#define WinHeight [UIScreen mainScreen].bounds.size.height

#define W(x) WinWidth*x/320.0  //屏幕适配，自动计算不同屏幕对应的x和y方向的坐标
#define H(y) WinHeight*y/568.0

#define SingleCircleViewWidth 100
#define CircleViewWidth WinWidth-20

#import "StartViewController.h"
#import "CircleView.h"
#import "DragImageView.h"
#import "AudioTool.h"
#import "MapViewController.h"
#import "AppDelegate.h"
#import "ImageClip.h"
#import "SystemSetting.h"
#import "LoadGameTableViewController.h"
#import "KKNavigationController.h"
#import "AboutUsViewController.h"
#import "HelpViewController.h"
@interface StartViewController ()<CircleViewDelegate,DragImageViewDelegate>

@end

@implementation StartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createCircleViewMenuArr];
    [self createOtherView];
}

-(void)viewWillAppear:(BOOL)animated{
    self.titleView.alpha = 0;
    [UIView animateWithDuration:2.0 animations:^{
        self.titleView.alpha = 1;
    }];
    [self showCircleView];
    [self addStarView];
    self.player = [AudioTool playMusic:@"Theme1.mp3"];
    
}

-(void)viewWillDisappear:(BOOL)animated{
    [self.player stop];
    [self.starView removeFromSuperview];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 *  延迟实例化数组
 */
-(NSMutableArray *)viewArr{
    if (!_viewArr) {
        _viewArr = [[NSMutableArray alloc]init];
    }
    return _viewArr;
}

/**
 *  添加声音与设置视图
 */
-(void)createOtherView{
    SystemSetting *setting = [SystemSetting systemSetting];
    if ([setting.isHasSound intValue]==1) {
        self.soundView.image = [ImageClip imageWithPngName:@"openSound"];
    }else{
        self.soundView.image = [ImageClip imageWithPngName:@"closeSound"];
    }
    UITapGestureRecognizer *tapGesture1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(openCloseSound:)];
    [self.soundView addGestureRecognizer:tapGesture1];
    UITapGestureRecognizer *tapGesture2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(openSetting:)];
    [self.settingView addGestureRecognizer:tapGesture2];
}

/**
 *  调解声音的方法
 */
-(void)openCloseSound:(UITapGestureRecognizer *)tapGesture{
    SystemSetting *setting = [SystemSetting systemSetting];
    if ([setting.isHasSound intValue]==1) {
        setting.isHasSound = @0;
        self.soundView.image = [ImageClip imageWithPngName:@"closeSound"];
    }else{
        setting.isHasSound = @1;
        self.soundView.image = [ImageClip imageWithPngName:@"openSound"];
    }
    [setting reloadSetting];
}

/**
 *  打开设置菜单
 */
-(void)openSetting:(UITapGestureRecognizer *)tapGesture{
    NSLog(@"设置");
}

/**
 *  创建旋转菜单单个菜单的样式
 */
-(DragImageView *)createViewStyleWithTag:(int)tag withImageName:(NSString *)imageName{
    DragImageView *view = [[DragImageView alloc]initWithFrame:CGRectMake(0, 0, SingleCircleViewWidth-20, SingleCircleViewWidth-20)];
    view.center = CGPointMake(WinWidth/2, WinWidth/2);
    view.backgroundColor = [UIColor clearColor];
    view.tag = tag;
    view.image = [ImageClip imageWithPngName:imageName];
    view.delegate = self;
    view.userInteractionEnabled = YES;
    return view;
}

/**
 *  创建旋转菜单的按钮组与视图
 */
-(void)createCircleViewMenuArr{
    DragImageView *view = [self createViewStyleWithTag:0 withImageName:@"help"];
    [self.viewArr addObject:view];
    view = [self createViewStyleWithTag:1 withImageName:@"makeface"];
    [self.viewArr addObject:view];
    view = [self createViewStyleWithTag:2 withImageName:@"continueGame"];
    [self .viewArr addObject:view];
    view = [self createViewStyleWithTag:3 withImageName:@"newGame"];
    [self.viewArr addObject:view];
    view = [self createViewStyleWithTag:4 withImageName:@"aboutUs"];
    [self.viewArr addObject:view];
    self.circleMenu = [[CircleView alloc]initWithFrame:CGRectMake(0, 0, CircleViewWidth, CircleViewWidth)];
    self.circleMenu.center = CGPointMake(WinWidth/2, WinHeight/2+50);
    self.circleMenu.arrImages = self.viewArr;
    self.circleMenu.delegate = self;
    [self.view addSubview:self.circleMenu];
}

/**
 *  显示旋转菜单视图
 */
-(void)showCircleView{
    [self.circleMenu loadView];
}

/**
 *  添加中间的五角星视图
 */
-(void)addStarView{
    self.starView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SingleCircleViewWidth, SingleCircleViewWidth)];
    self.starView.center = CGPointMake(WinWidth/2, WinHeight/2+50);
    self.starView.image = [ImageClip imageWithPngName:@"fiveStar"];
    [self.view addSubview:self.starView];
    [self addAnimatonForView];
}

/**
 *  添加旋转动画
 */
-(void)addAnimatonForView{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation.fromValue = @0;
    animation.toValue=@(2*M_PI);
    animation.duration = 10;
    animation.repeatCount = NSNotFound;
    [self.starView.layer addAnimation:animation forKey:@"animation1"];
    animation.toValue=@(-2*M_PI);
}

/**
 *  移除旋转动画
 */
-(void)removeAnimationForView{
    [self.starView.layer removeAnimationForKey:@"animation1"];
}

/**
 *  当检测到手指开始拖动菜单时的方法
 */
-(void)circleViewGestureStart{
    //[self removeAnimationForView];
}

/**
 *  当检测到手指停止拖动菜单时的方法
 */
-(void)circleViewGestureEnd{
    //[self addAnimatonForView];
}

/**
 *  页面跳转方法
 */
-(void)DragImageViewClick:(DragImageView *)view{
    int tag = view.tag;
    switch (tag) {
        case 0:
            [self gotoHelp];
            break;
        case 1:
            [self gotoMakeFace];
            break;
        case 2:
            [self gotoLoadView];
            break;
        case 3:
            [self gotoCreateCharacterView];
            break;
        case 4:
            [self gotoAboutUs];
            break;
        default:
            break;
    }
}

- (void)gotoLoadView{
    LoadGameTableViewController *loadController = [[LoadGameTableViewController alloc]initWithBackStyle:@0];
    KKNavigationController *navigation = [[KKNavigationController alloc]initWithRootViewController:loadController];
    CATransition *animation = [CATransition animation];
    animation.duration = 2;
    animation.type = @"rippleEffect";
    animation.subtype = kCATransitionFromRight;
    [self.view.window.layer addAnimation:animation forKey:nil];
    [self presentViewController:navigation animated:YES completion:^{
    }];
}

- (void)gotoCreateCharacterView{
    UIApplication *application = [UIApplication sharedApplication];
    AppDelegate *delegate = (AppDelegate *)application.delegate;
    [delegate gotoCreateCharacterView];
}

-(void)gotoMakeFace{
    UIApplication *application = [UIApplication sharedApplication];
    AppDelegate *delegate = (AppDelegate *)application.delegate;
    [delegate gotoMakeFace];
}

-(void)gotoAboutUs{
    AboutUsViewController *aboutController = [[AboutUsViewController alloc]init];
    KKNavigationController *kkController = [[KKNavigationController alloc]initWithRootViewController:aboutController];
    [self presentViewController:kkController animated:YES completion:^{
        
    }];
}

-(void)gotoHelp{
    HelpViewController *helpController = [[HelpViewController alloc]init];
    KKNavigationController *kkController = [[KKNavigationController alloc]initWithRootViewController:helpController];
    [self presentViewController:kkController animated:YES completion:^{
        
    }];
}

@end

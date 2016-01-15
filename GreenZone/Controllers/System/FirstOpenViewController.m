//
//  FirstOpenViewController.m
//  GreenZone
//
//  Created by zqh on 15/6/15.
//  Copyright (c) 2015年 student. All rights reserved.
//

#import "FirstOpenViewController.h"
#import "AppDelegate.h"
#import "ImageClip.h"
#import "AudioTool.h"
#define WinWidth [UIScreen mainScreen].bounds.size.width
#define WinHeight [UIScreen mainScreen].bounds.size.height

#define W(x) WinWidth*x/320.0  //屏幕适配，自动计算不同屏幕对应的x和y方向的坐标
#define H(y) WinHeight*y/568.0
@interface FirstOpenViewController ()<UIScrollViewDelegate>

@end

@implementation FirstOpenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIApplication *app = [UIApplication sharedApplication];
    app.statusBarHidden = YES;
    self.player = [AudioTool playMusic:@"Airship.mp3"];
    [self addViewLayout];
}

-(void)viewWillDisappear:(BOOL)animated{
    [self.player stop];
}

/**
 *  为控制器添加视图布局
 */
-(void)addViewLayout{
    self.pageView.center = CGPointMake(WinWidth/2, WinHeight-80);
    self.showView.pagingEnabled = YES;
    self.showView.delegate = self;
    self.showView.showsHorizontalScrollIndicator = NO;
    self.showView.contentSize = CGSizeMake(WinWidth *3, WinHeight);
    self.showView.backgroundColor = [UIColor greenColor];
    UIImageView *imageV1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, WinWidth, WinHeight)];
    imageV1.backgroundColor = [UIColor redColor];
    
    UIImageView *imageV2 = [[UIImageView alloc]initWithFrame:CGRectMake(WinWidth, 0, WinWidth, WinHeight)];
    imageV2.backgroundColor = [UIColor blueColor];
    
    UIImageView *imageV3 = [[UIImageView alloc]initWithFrame:CGRectMake(WinWidth*2, 0, WinWidth, WinHeight)];
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
    imageV3.userInteractionEnabled = YES;
    btn.center = CGPointMake(WinWidth/2, WinHeight-50);
    [btn setTitle:@"进入魔法阵" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(gotoStartView) forControlEvents:UIControlEventTouchUpInside];
    btn.backgroundColor = [UIColor purpleColor];
    btn.layer.cornerRadius = 10;
    imageV3.backgroundColor = [UIColor greenColor];
    
    [self.showView addSubview:imageV1];
    [self.showView addSubview:imageV2];
    [self.showView addSubview:imageV3];
    
    UIImageView *pageImageView1 = [[UIImageView alloc]initWithFrame:CGRectMake(W(0), H(0), W(320), H(371))];
    pageImageView1.image = [ImageClip imageWithPngName:@"page1"];
    UITextView *pageTextView1 = [[UITextView alloc]initWithFrame:CGRectMake(W(0), H(371), W(320), H(197))];
    pageTextView1.font = [UIFont systemFontOfSize:16];
    pageTextView1.text = @"我是一个周游世界的冒险家,在一次地下城的探险中，跟随我们的团队打到了守护着巨大宝藏的恶龙。但是遗憾的是我们也受到了巨大的损失,全团只有我一个人侥幸存活了下来。这张像是藏宝图的古老地图就是那条巨龙守护的东西,我以得到这张地图上最终的宝藏为目标,三十年如一日地不停锻炼自己。终于,我现在成为了世界第一强者,而我也发现了这张藏宝图的秘密。现在,终于到了获得最终宝藏的时候了。";
    pageTextView1.editable = NO;
    [imageV1 addSubview:pageImageView1];
    [imageV1 addSubview:pageTextView1];
    
    UIImageView *pageImageView2 = [[UIImageView alloc]initWithFrame:CGRectMake(W(0), H(0), W(320), H(371))];
    pageImageView2.image = [ImageClip imageWithPngName:@"page2"];
    UITextView *pageTextView2 = [[UITextView alloc]initWithFrame:CGRectMake(W(0), H(371), W(320), H(197))];
    pageTextView2.font = [UIFont systemFontOfSize:16];
    pageTextView2.text = @"到了藏宝图所指向的最终的宝藏所在的地点,竟然是一座无人的岛屿,岛屿的正中心矗立着一座直冲天际的巨大高塔。最终的宝藏竟然不是宝箱也不是武器什么的而是一座塔,身为世界第一强者的我感觉自己被人耍了。但是我全力的一击竟然并不能打碎这座塔的墙壁,或许这座塔里面有什么正真的宝藏存在着。抬头看了看塔门上挂的刻着真理两个字的牌子,我迈步走进了这座神秘的高塔。";
    pageTextView2.editable = NO;
    [imageV2 addSubview:pageImageView2];
    [imageV2 addSubview:pageTextView2];
    
    UIImageView *pageImageView3 = [[UIImageView alloc]initWithFrame:CGRectMake(W(0), H(0), W(320), H(371))];
    pageImageView3.image = [ImageClip imageWithPngName:@"page3"];
    UITextView *pageTextView3 = [[UITextView alloc]initWithFrame:CGRectMake(W(0), H(371), W(320), H(197))];
    pageTextView3.font = [UIFont systemFontOfSize:16];
    pageTextView3.text = @"塔里面空空荡荡的,只有中心的位置刻画着一个巨大的神秘魔法阵。然而这座法阵使用的文字我一个都不认识。身为堂堂世界第一强者居然连字都不认识,这种事说出去岂不是要让人笑掉大牙!我决定毁掉这个法阵,这个世界就不存在我不认识的字了!我猛力一拳向法阵中心打去,然而一阵强光闪过,法阵突然启动了...";
    pageTextView3.editable = NO;
    [imageV3 addSubview:pageImageView3];
    [imageV3 addSubview:pageTextView3];
    [imageV3 addSubview:btn];
    
}


-(void)gotoStartView{
    AppDelegate *app = [UIApplication sharedApplication].delegate;
    [app gotoStartView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    CGFloat page = scrollView.contentOffset.x / WinWidth;
    self.pageView.currentPage = page;

}


@end

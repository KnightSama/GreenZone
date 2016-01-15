//
//  EventTableViewController.m
//  GreenZone
//
//  Created by niit on 15-7-7.
//  Copyright (c) 2015年 student. All rights reserved.
//

#define WinWidth [UIScreen mainScreen].bounds.size.width
#define WinHeight [UIScreen mainScreen].bounds.size.height

#define W(x) WinWidth*x/320.0
#define H(y) WinHeight*y/568.0

#import "EventTableViewController.h"
#import "EventRecorded.h"
#import "ImageClip.h"
#import "AudioTool.h"
@interface EventTableViewController ()

@end

@implementation EventTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"事件列表";
    UIBarButtonItem *left = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(gotoBack)];
    self.navigationItem.leftBarButtonItem = left;
}

-(void)viewWillAppear:(BOOL)animated{
    self.player = [AudioTool playMusic:@"eventList.mp3"];
    self.player.numberOfLoops = NSNotFound;
}

-(void)viewWillDisappear:(BOOL)animated{
    [self.player stop];
}

/**
 *  返回上一层
 */
-(void)gotoBack
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

/**
 *   通过事件表初始化
 */
-(instancetype)initWithEventsList:(EventRecorded *)eventsRecord
{
    if (self = [super init])
    {
        self.eventsRecord = eventsRecord;
        self.evenstDict = [self.eventsRecord.eventsDict mutableCopy];
        self.keysArr = [self.eventsRecord.keysArr mutableCopy];
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
    return self.keysArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
//    cell.backgroundColor = [UIColor greenColor];
    cell .frame = CGRectMake(0, 0, W(320), H(100));
    cell.selected = NO;
    //背景
    UIImageView *BG = [[UIImageView alloc]initWithFrame:cell.frame];
    BG.image = [ImageClip imageWithJpgName:@"messageBG"];
    [cell addSubview:BG];
    UIImageView *border = [[UIImageView alloc]initWithFrame:cell.frame];
    border.image = [ImageClip imageWithPngName:@"messageBorder2"];
    [cell addSubview:border];

    
    //显示时间label
    UILabel *timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(W(95), 0, W(130), H(20))];
    NSString *keyStr = self.keysArr[indexPath.row];
    timeLabel.text = keyStr;
    timeLabel.textAlignment = NSTextAlignmentCenter;
    timeLabel.layer.borderWidth = 1.0;
    
    //显示事件textfield
    UITextView *event = [[UITextView alloc]initWithFrame:CGRectMake(W(10), H(25), W(300), H(75))];
    NSString *eventStr = [self.evenstDict valueForKey:keyStr];
    event.backgroundColor = [UIColor clearColor];
    event.font = [UIFont systemFontOfSize:15];
    event.text = eventStr;
    event.editable = NO;
    
    [cell addSubview:event];
    [cell addSubview:timeLabel];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return H(100);
}


@end

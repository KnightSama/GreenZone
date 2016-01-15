//
//  faceMake.m
//  GreenZone
//
//  Created by student on 15/7/2.
//  Copyright (c) 2015年 student. All rights reserved.
//
#define mainWidth [UIScreen mainScreen].bounds.size.width
#define mainHeight [UIScreen mainScreen].bounds.size.height

#define W(x) (mainWidth*x/320)
#define H(y) (mainHeight*y/528)

#import "faceMake.h"
#import "faceMakeCell.h"
#import "faceModel.h"
#import "ImageClip.h"
#import "faceDetailModel.h"
#import "AppDelegate.h"
#import "AudioTool.h"


@interface faceMake ()<UITableViewDataSource,UITableViewDelegate,faceMakeCellDelegate>
/**
 *  人物总览
 */
@property (weak, nonatomic) IBOutlet UIImageView *characterView;
/**
 *  性别选择
 */
@property (weak, nonatomic) IBOutlet UISegmentedControl *chooseSex;

/**
 *  人物细节选择
 */
@property (weak, nonatomic) IBOutlet UITableView *characterDetailChoose;


/**
 *  女性属性数组
 */
@property(nonatomic,strong) NSArray *femaleAttri;

/**
 *  男性属性数组
 */
@property(nonatomic,strong) NSArray *maleAttri;

/**
 *  玩家选择的头部数据数组
 */
@property(nonatomic,strong) NSMutableArray *playerChooseData;

/**
 *  男性脸部细节模型
 */
@property(nonatomic,strong) faceDetailModel *maleFaceDetailModel;

/**
 *  男性玩家细节模型数组
 */
@property(nonatomic,strong) NSMutableArray *maleFaceDetailModelArr;


/**
 *  女性脸部细节模型
 */
@property(nonatomic,strong) faceDetailModel *femaleFaceDetailModel;

/**
 *  女性玩家细节模型数组
 */
@property(nonatomic,strong) NSMutableArray *femaleFaceDetailModelArr;


@property (weak, nonatomic) IBOutlet UIButton *backToMainMenu;

@property (weak, nonatomic) IBOutlet UIButton *saveToPhoto;


@end

@implementation faceMake


/**
 *  保存图像到相册
 */
- (IBAction)saveToPhoto:(UIButton *)sender {
    UIImage *saveImg = self.characterView.image;
    UIImageWriteToSavedPhotosAlbum(saveImg, nil, nil, nil);
    UILabel *finishAlertLabel = [[UILabel alloc]initWithFrame:CGRectMake(W(95), H(300), W(100), H(30))];
    [self.view addSubview:finishAlertLabel];
    finishAlertLabel.alpha = 0;
    finishAlertLabel.textColor = [UIColor whiteColor];
    finishAlertLabel.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];
    finishAlertLabel.text = @"保存成功";
    finishAlertLabel.textAlignment = UITextAlignmentCenter;
    [UIView animateWithDuration:1.5 animations:^{
        finishAlertLabel.alpha = 1;
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.7 animations:^{
            finishAlertLabel.alpha = 0;
        }];
    }];
}

/**
 *   返回到主界面
 */
- (IBAction)backToMainMenu:(UIButton *)sender {
    AppDelegate *app = [UIApplication sharedApplication].delegate;
    if (app && [app respondsToSelector:@selector(gotoStartView)]) {
        [app gotoStartView];
    }
    
}

-(void)viewWillAppear:(BOOL)animated{
    self.player = [AudioTool playMusic:@"makeFace.mp3"];
    self.player.numberOfLoops = NSNotFound;
}

-(void)viewWillDisappear:(BOOL)animated{
    [self.player stop];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.saveToPhoto.enabled = NO;
    
    self.maleFaceDetailModelArr = [NSMutableArray array];
    NSString *path = [[NSBundle mainBundle]pathForResource:@"maleFaceMake.plist" ofType:nil];
    
    NSDictionary *arrDict = [NSDictionary dictionaryWithContentsOfFile:path];
    
    self.maleFaceDetailModel = [faceDetailModel modelWithDict:arrDict];
    
    
    self.femaleFaceDetailModelArr = [NSMutableArray array];
    NSString *pathFe = [[NSBundle mainBundle]pathForResource:@"femaleFaceMake.plist" ofType:nil];
    
    NSDictionary *feArrDict = [NSDictionary dictionaryWithContentsOfFile:pathFe];
    self.femaleFaceDetailModel = [faceDetailModel modelWithDict:feArrDict];
    

    
    self.characterDetailChoose.delegate = self;
    self.characterDetailChoose.dataSource = self;
    self.characterDetailChoose.rowHeight = H(150);
    [self.chooseSex addTarget:self action:@selector(DidChooseSex:) forControlEvents:UIControlEventValueChanged];
    
//    self.characterDetailChoose.allowsSelection = NO;
    
    self.maleAttri = @[@"头发",@"脸",@"留海",@"眉毛",@"眼睛",@"耳朵",@"鼻子",@"嘴",@"胡子",@"领子",@"装饰配件"];
    self.femaleAttri = @[@"头发",@"脸",@"留海",@"眉毛",@"眼睛",@"耳朵",@"鼻子",@"嘴",@"领子",@"装饰配件"];

    
    [self.maleFaceDetailModelArr addObject:self.maleFaceDetailModel.rearHairArr];
    [self.maleFaceDetailModelArr addObject:self.maleFaceDetailModel.faceArr];
    [self.maleFaceDetailModelArr addObject:self.maleFaceDetailModel.frontHairArr];
    [self.maleFaceDetailModelArr addObject:self.maleFaceDetailModel.eyeBrowsArr];
    [self.maleFaceDetailModelArr addObject:self.maleFaceDetailModel.eyeArr];
    [self.maleFaceDetailModelArr addObject:self.maleFaceDetailModel.earsArr];
    [self.maleFaceDetailModelArr addObject:self.maleFaceDetailModel.noseArr];
    [self.maleFaceDetailModelArr addObject:self.maleFaceDetailModel.mouthArr];
    [self.maleFaceDetailModelArr addObject:self.maleFaceDetailModel.beardArr];
    [self.maleFaceDetailModelArr addObject:self.maleFaceDetailModel.neckArr];
    [self.maleFaceDetailModelArr addObject:self.maleFaceDetailModel.accArr];
    
    
    [self.femaleFaceDetailModelArr addObject:self.femaleFaceDetailModel.rearHairArr];
    [self.femaleFaceDetailModelArr addObject:self.femaleFaceDetailModel.faceArr];
    [self.femaleFaceDetailModelArr addObject:self.femaleFaceDetailModel.frontHairArr];
    [self.femaleFaceDetailModelArr addObject:self.femaleFaceDetailModel.eyeBrowsArr];
    [self.femaleFaceDetailModelArr addObject:self.femaleFaceDetailModel.eyeArr];
    [self.femaleFaceDetailModelArr addObject:self.femaleFaceDetailModel.earsArr];
    [self.femaleFaceDetailModelArr addObject:self.femaleFaceDetailModel.noseArr];
    [self.femaleFaceDetailModelArr addObject:self.femaleFaceDetailModel.mouthArr];
    [self.femaleFaceDetailModelArr addObject:self.femaleFaceDetailModel.neckArr];
    [self.femaleFaceDetailModelArr addObject:self.femaleFaceDetailModel.accArr];
    
    self.playerChooseData = [[NSMutableArray alloc]init];
    for (int i = 0; i < 11; i++) {
        UIImage *img = [[UIImage alloc]init];
        [self.playerChooseData addObject:img];
    }
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)DidChooseSex:(UISegmentedControl *)sge
{
    
    self.saveToPhoto.enabled = NO;
    
    [self.playerChooseData removeAllObjects];
    for (int i = 0; i < 11; i++) {
        UIImage *img = [[UIImage alloc]init];
        [self.playerChooseData addObject:img];
    }
    [self showHearderFaceShow];
    [self.characterDetailChoose reloadData];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.chooseSex.selectedSegmentIndex == 0) {
        return self.maleAttri.count;
    }
    else
        return self.femaleAttri.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = [NSString stringWithFormat:@"cell%lu",indexPath.row];
//    faceMakeCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    if (cell == nil) {
       faceMakeCell *cell = [[faceMakeCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
//    }
    cell.contentView.tag = indexPath.row;

    if (self.chooseSex.selectedSegmentIndex == 0) {
        cell.attriName.text = self.maleAttri[indexPath.row];

        cell.faceDetailArr = self.maleFaceDetailModelArr[indexPath.row];
    }
    else
    {
        cell.attriName.text = self.femaleAttri[indexPath.row];

        cell.faceDetailArr = self.femaleFaceDetailModelArr[indexPath.row];
    }
    cell.delegate =self;

    return cell;
}

- (void)showTheFaceInTheShowViewWithImage:(UIImage *)img WithCellTag:(NSInteger)tag
{
        BOOL isHas = NO;
        
        for (UIImage *tmpImg in self.playerChooseData) {
            if ([img isEqual:tmpImg]) {
                isHas = YES;
            }
        }
        
        if (isHas == NO) {
            [self.playerChooseData replaceObjectAtIndex:tag withObject:img];
        }
        
        [self showHearderFaceShow];
}

- (void) showHearderFaceShow
{
    if (self.playerChooseData.count>0) {

        UIImage *faceImage = [[UIImage alloc]init];
        
        UIGraphicsBeginImageContext(CGSizeMake(128, 128));
        for (int i = 0; i < self.playerChooseData.count; i++) {
            UIImage *tmpImg = self.playerChooseData[i];
            [tmpImg drawInRect:CGRectMake(0, 0, tmpImg.size.width, tmpImg.size.height)];
            faceImage = UIGraphicsGetImageFromCurrentImageContext();
        }
        UIGraphicsEndImageContext();
        self.characterView.image = faceImage;
        
        self.saveToPhoto.enabled = YES;
        
    }
    
}

@end

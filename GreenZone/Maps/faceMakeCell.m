//
//  faceMakeCell.m
//  GreenZone
//
//  Created by student on 15/7/2.
//  Copyright (c) 2015年 student. All rights reserved.
//

#define mainWidth [UIScreen mainScreen].bounds.size.width
#define mainHeight [UIScreen mainScreen].bounds.size.height

#define W(x) (mainWidth*x/320)
#define H(y) (mainHeight*y/528)

#import "faceMakeCell.h"
#import "ImageClip.h"

@interface faceMakeCell()<UIScrollViewDelegate,UIPickerViewDataSource,UIPickerViewDelegate>



@end

@implementation faceMakeCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

- (void)setFaceDetailArr:(NSArray *)faceDetailArr
{
    _faceDetailArr = faceDetailArr;
    [self.allFaceDetailArr removeAllObjects];
    [self.faceDetailFristArr removeAllObjects];
    for (NSString *imgName in faceDetailArr) {
         NSArray *tmpArr= [ImageClip imageArrWithImage:[UIImage imageNamed: imgName] clipByWidth:128];
        [self.allFaceDetailArr addObject:tmpArr];
        [self.faceDetailFristArr addObject:tmpArr[0]];
    }
}

- (void)setFaceDetailFristArr:(NSMutableArray *)faceDetailFristArr
{
    _faceDetailFristArr = faceDetailFristArr;
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.allFaceDetailArr = [NSMutableArray array];
        self.faceDetailFristArr = [NSMutableArray array];
        
        self.attriName = [[UILabel alloc]initWithFrame:CGRectMake(W(10), H(65), W(70), H(20))];

        self.attriName.font = [UIFont systemFontOfSize:19];
        [self.contentView addSubview:self.attriName];
        
        self.attriChooseShow = [[UIPickerView alloc]initWithFrame:CGRectMake(W(100), H(10), W(200), H(100))];
        self.attriChooseShow.dataSource = self;
        self.attriChooseShow.delegate = self;
        [self.contentView addSubview:self.attriChooseShow];
    }
    return self;
}

#pragma mark UIPickViewDataSource
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    return W(95);
}
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return H(95);
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0) {
        return self.faceDetailFristArr.count;
    }
    else{
        NSArray *tmpArr = self.allFaceDetailArr[component];
        return tmpArr.count;
    }
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    if (component == 0) {
        UIImageView *leftView = [[UIImageView alloc]init];
        leftView.image = self.faceDetailFristArr[row];
        return leftView;
    }
    else
    {
        UIImageView *rightView = [[UIImageView alloc]init];
        NSArray *tmpArr = self.allFaceDetailArr[[pickerView selectedRowInComponent:0]];
        UIImage *tmpImg = tmpArr[row];
        rightView.image = tmpImg;
        return rightView;
    }
}

#pragma mark UIPickViewDelegate

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (component == 0) {
        [pickerView selectRow:0 inComponent:1 animated:NO];
        [pickerView reloadComponent:1];
        
    }
    else
    {
        if ([pickerView isMemberOfClass:[UIPickerView class]]) {
            
            if (self.delegate && [self.delegate respondsToSelector:@selector(showTheFaceInTheShowViewWithImage:WithCellTag:)] ) {
                NSArray *tmpArr = self.allFaceDetailArr[[pickerView selectedRowInComponent:0]];
                UIImage *tmpImg = tmpArr[row];
                
                [self.delegate showTheFaceInTheShowViewWithImage:tmpImg WithCellTag:pickerView.superview.tag];

            }
        }
    }
}

@end

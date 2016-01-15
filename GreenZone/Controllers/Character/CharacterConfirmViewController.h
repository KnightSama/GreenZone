//
//  CharacterConfirmViewController.h
//  GreenZone
//
//  Created by zqh on 15/7/2.
//  Copyright (c) 2015年 student. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CharacterModel;
@interface CharacterConfirmViewController : UIViewController

/**
 *  角色的信息
 */
@property(nonatomic,strong) CharacterModel *character;
@property (weak, nonatomic) IBOutlet UIImageView *faceImageView;
@property (weak, nonatomic) IBOutlet UITextField *nameView;
- (IBAction)changName:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *attakView;
@property (weak, nonatomic) IBOutlet UILabel *defenceView;
@property (weak, nonatomic) IBOutlet UILabel *powerView;
@property (weak, nonatomic) IBOutlet UILabel *leadView;
@property (weak, nonatomic) IBOutlet UITextView *descriptionView;
@property (weak, nonatomic) IBOutlet UIImageView *frontView;
@property (weak, nonatomic) IBOutlet UIImageView *leftView;
@property (weak, nonatomic) IBOutlet UIImageView *rightView;
@property (weak, nonatomic) IBOutlet UIImageView *backView;
@property (weak, nonatomic) IBOutlet UIImageView *starImageView;




@end

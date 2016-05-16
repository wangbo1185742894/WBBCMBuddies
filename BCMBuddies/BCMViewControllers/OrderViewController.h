//
//  OrderViewController.h
//  BCMBuddies
//
//  Created by 王博 on 16/5/10.
//  Copyright © 2016年 鲁智星. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BCMDefineFile.h"

@interface OrderViewController : BaseViewController

@property(strong,nonatomic) BCMContent *modelContent;
@property (weak, nonatomic) IBOutlet UILabel *labSerName;
- (IBAction)actionSelectTime:(UIButton *)sender;
- (IBAction)actionSure:(UIButton *)sender;
- (IBAction)actionBack:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIView *viewSelectDate;
- (IBAction)actionDateBack:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnSelectDate;

- (IBAction)actionDateSubmit:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIDatePicker *picDate;
@property (weak, nonatomic) IBOutlet UIView *viewSuccess;
@property (weak, nonatomic) IBOutlet UILabel *labSerSuccessName;

@property (weak, nonatomic) IBOutlet UILabel *labSuccessInfo;

- (IBAction)actionSuccessSure:(UIButton *)sender;

@end

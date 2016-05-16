//
//  CallMeViewController.h
//  BCMBuddies
//
//  Created by 王博 on 16/5/9.
//  Copyright © 2016年 鲁智星. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CallMeViewController : BaseViewController
//输入排队好页面
@property (weak, nonatomic) IBOutlet UISwitch *swiTFI;

@property (weak, nonatomic) IBOutlet UILabel *labTitleInfo;

@property (weak, nonatomic) IBOutlet UILabel *labPleaseOrder;

@property (weak, nonatomic) IBOutlet UILabel *labNumber;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segSelectQueue;

- (IBAction)actionAddNumber:(UIButton *)sender;
- (IBAction)actionSubNumber:(UIButton *)sender;

- (IBAction)actionSubmit:(UIButton *)sender;

//选择时间页面
@property (weak, nonatomic) IBOutlet UIView *viewSelect;

@property (weak, nonatomic) IBOutlet UILabel *labMyNumber;

@property (weak, nonatomic) IBOutlet UILabel *labMyOrderInfo;
@property (weak, nonatomic) IBOutlet UITextField *labMyPhoneNumber;

- (IBAction)actionSelectTime:(UIButton *)sender;

- (IBAction)actionOpenCallMe:(UIButton *)sender;

- (IBAction)actionBack:(UIButton *)sender;

//显示信息页面

@property (weak, nonatomic) IBOutlet UILabel *labMyNumberInfo;

@property (weak, nonatomic) IBOutlet UILabel *labMyOrderInfoOnfInfo;

- (IBAction)actionCloseCallMe:(UIButton *)sender;

- (IBAction)actionBackInfo:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UIButton *actionBack;
@property (weak, nonatomic) IBOutlet UIView *viewMyOrderInfo;

@end

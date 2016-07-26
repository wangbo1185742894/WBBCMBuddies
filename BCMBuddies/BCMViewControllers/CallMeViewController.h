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

//@property (nonatomic ,strong)NSMutableArray *dataArray;

@property (weak, nonatomic) IBOutlet UILabel *labTitleInfo;

@property (weak, nonatomic) IBOutlet UILabel *labPleaseOrder;



- (IBAction)actionAddNumber:(UIButton *)sender;
- (IBAction)actionSubNumber:(UIButton *)sender;

- (IBAction)actionSubmit:(UIButton *)sender;

//选择时间页面


//显示信息页面



@end

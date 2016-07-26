//
//  SubmitPhoneNumberViewController.h
//  BCMBuddies
//
//  Created by 王博 on 16/5/19.
//  Copyright © 2016年 鲁智星. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SubmitPhoneNumberViewController : BaseViewController

@property(nonatomic,strong)NSString *strNumber;

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *btnsTime;
@property(nonatomic,assign)BOOL on;
@property (weak, nonatomic) IBOutlet UISwitch *swiTFI;

@property (weak, nonatomic) IBOutlet UILabel *labMyNumber;

@property (weak, nonatomic) IBOutlet UILabel *labMyOrderInfo;
@property (weak, nonatomic) IBOutlet UITextField *labMyPhoneNumber;


- (IBAction)actionSelectTime:(UIButton *)sender;

- (IBAction)actionOpenCallMe:(UIButton *)sender;

- (IBAction)actionBack:(UIButton *)sender;

@end

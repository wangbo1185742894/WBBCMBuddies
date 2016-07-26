//
//  ResverResultViewController.h
//  BCMBuddies
//
//  Created by 王博 on 16/5/16.
//  Copyright © 2016年 鲁智星. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BCMDefineFile.h"
#import "LDImageView.h"

@interface ResverResultViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UIView *viewNoOrder;
@property (weak, nonatomic) IBOutlet LDImageView *imgIcon;
@property (weak, nonatomic) IBOutlet UILabel *labOrderInfo;
@property (weak, nonatomic) IBOutlet UILabel *labOrderTime;


- (IBAction)actionBack:(UIButton *)sender;
- (IBAction)actionSure:(UIButton *)sender;

@end

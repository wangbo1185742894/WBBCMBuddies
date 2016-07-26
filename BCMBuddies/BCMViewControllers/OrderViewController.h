//
//  OrderViewController.h
//  BCMBuddies
//
//  Created by 王博 on 16/5/10.
//  Copyright © 2016年 鲁智星. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BCMDefineFile.h"

@interface OrderViewController : BaseViewController<NSURLConnectionDataDelegate>

@property(strong,nonatomic) BCMContent *modelContent;
@property (weak, nonatomic) IBOutlet UILabel *labSerName;
@property(nonatomic,strong) NSString *serName;

- (IBAction)actionSure:(UIButton *)sender;
- (IBAction)actionBack:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIView *viewSelectDate;



@end

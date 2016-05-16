//
//  PersonInfoViewController.h
//  BCMBuddies
//
//  Created by 王博 on 16/5/9.
//  Copyright © 2016年 鲁智星. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LDImageView.h"
#import "AppDelegate.h"
#import "BCMDefineFile.h"
@interface PersonInfoViewController : BaseViewController
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintOfBusinessLabHeght;
@property (weak, nonatomic) IBOutlet UILabel *labSerClass;
@property (weak, nonatomic) IBOutlet UILabel *labNumberSer;

@property (weak, nonatomic) IBOutlet UILabel *labWorkYears;
@property (weak, nonatomic) IBOutlet LDImageView *imgIcon;
@property (weak, nonatomic) IBOutlet UILabel *labName;
@property (weak, nonatomic) IBOutlet UILabel *labWorkId;
@property (weak, nonatomic) IBOutlet UILabel *labPosition;
@property (weak, nonatomic) IBOutlet UILabel *labServce;
@property (weak, nonatomic) IBOutlet UILabel *labHonour;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewHeight;

@property(strong,nonatomic) BCMContent *modelContent;

@end

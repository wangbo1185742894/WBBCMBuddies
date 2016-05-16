//
//  PersonDetailInfoViewCell.h
//  BCMBuddies
//
//  Created by 王博 on 16/5/9.
//  Copyright © 2016年 鲁智星. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BCMDefineFile.h"
#import "LDImageView.h"

@interface PersonDetailInfoViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet LDImageView *imgIconTitle;
@property (weak, nonatomic) IBOutlet UILabel *labState;
@property (weak, nonatomic) IBOutlet UILabel *labName;
@property (weak, nonatomic) IBOutlet UILabel *labPosition;
@property (weak, nonatomic) IBOutlet UILabel *labWork;
@property(strong,nonatomic) BCMContent *modelContent;
@property (weak,nonatomic)UIViewController *controller;

-(void)setStateBackColor:(BOOL)isOnline;

-(void)reloadData;

@end

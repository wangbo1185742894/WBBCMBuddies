//
//  OrderListViewCell.h
//  BCMBuddies
//
//  Created by 王博 on 16/5/20.
//  Copyright © 2016年 鲁智星. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "LDImageView.h"
#import "ModOrderList.h"

@interface OrderListViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imagePerson;

@property (weak, nonatomic) IBOutlet LDImageView *imgIcon;
@property (weak, nonatomic) IBOutlet UILabel *labOrderTitle;

@property (weak, nonatomic) IBOutlet UILabel *labOrderInfo;

-(void)reloadData:(ModOrderList *)model;

@end

//
//  BankListViewController.h
//  BCMBuddies
//
//  Created by 王博 on 16/5/16.
//  Copyright © 2016年 鲁智星. All rights reserved.
//

#import "BaseViewController.h"
#import "BCMRootViewController.h"

@interface BankListViewController : BaseViewController


@property (weak, nonatomic) IBOutlet UITableView *tabBankList;
@property (weak, nonatomic) IBOutlet UIImageView *imgIcon;
@property (weak, nonatomic) IBOutlet UILabel *labTitle;
@property (weak, nonatomic) IBOutlet UIView *viewSerClass;
@property (weak, nonatomic) IBOutlet UILabel *labAddress;

@end

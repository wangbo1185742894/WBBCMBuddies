//
//  BCMRootViewController.h
//  BCMBuddies
//
//  Created by 鲁智星 on 16/2/16.
//  Copyright © 2016年 鲁智星. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BCMTabBarView.h"
#import "WBButton.h"
#import "BCMHomeViewController.h"
#import "BCMSeverViewController.h"
#import "BCMMySelfViewController.h"
#import "BaseViewController.h"
@interface BCMRootViewController :BaseViewController

@property (nonatomic,strong) BCMTabBarView *m_tabBarView;
@property (weak, nonatomic) IBOutlet UIButton *btnMoveToqueue;

@property (nonatomic,strong) BCMHomeViewController *m_homeViewController;
@property (nonatomic,strong) BCMSeverViewController *m_severViewController;
@property (nonatomic,strong) BCMMySelfViewController *m_mySelfViewController;

@end

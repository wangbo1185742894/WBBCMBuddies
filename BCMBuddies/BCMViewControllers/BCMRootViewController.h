//
//  BCMRootViewController.h
//  BCMBuddies
//
//  Created by 鲁智星 on 16/2/16.
//  Copyright © 2016年 鲁智星. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BCMTabBarView.h"
#import "BCMHomeViewController.h"
#import "BCMSeverViewController.h"
#import "BCMMySelfViewController.h"

@interface BCMRootViewController : UITabBarController

@property (nonatomic,strong) BCMTabBarView *m_tabBarView;

@property (nonatomic,strong) BCMHomeViewController *m_homeViewController;
@property (nonatomic,strong) BCMSeverViewController *m_severViewController;
@property (nonatomic,strong) BCMMySelfViewController *m_mySelfViewController;

@end

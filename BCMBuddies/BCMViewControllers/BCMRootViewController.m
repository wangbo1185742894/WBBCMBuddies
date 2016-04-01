//
//  BCMRootViewController.m
//  BCMBuddies
//
//  Created by 鲁智星 on 16/2/16.
//  Copyright © 2016年 鲁智星. All rights reserved.
//

#import "BCMRootViewController.h"
#import "BCMDefineFile.h"
#import "BCMNavigationController.h"

@interface BCMRootViewController ()<BCMTabBarViewDelegate,BCMSeverViewControllerDelegate>
{
}
@end

@implementation BCMRootViewController

@synthesize m_tabBarView;
@synthesize m_homeViewController;
@synthesize m_severViewController;
@synthesize m_mySelfViewController;

- (void)setupViewControllers
{
    self.tabBar.hidden = YES;
    self.m_homeViewController = [[BCMHomeViewController alloc] initWithNibName:@"BCMHomeViewController" bundle:nil];
    self.m_severViewController = [[BCMSeverViewController alloc] initWithNibName:@"BCMSeverViewController" bundle:nil];
    self.m_severViewController.m_delegate = self;
    UIViewController *wd_severViewController = [[UIViewController alloc] initWithNibName:@"BCMSeverViewController" bundle:nil];
    self.m_mySelfViewController = [[BCMMySelfViewController alloc] initWithNibName:@"BCMMySelfViewController" bundle:nil];
    
    BCMNavigationController *wd_homeNavigationController = [[BCMNavigationController alloc] initWithRootViewController:self.m_homeViewController];
    [wd_homeNavigationController setNavigationBarHidden:YES animated:NO];
    [wd_homeNavigationController setToolbarHidden:YES animated:NO];

    BCMNavigationController *wd_severNavigationController = [[BCMNavigationController alloc] initWithRootViewController:wd_severViewController];
    [wd_severNavigationController setNavigationBarHidden:YES animated:NO];
    [wd_severNavigationController setToolbarHidden:YES animated:NO];

    BCMNavigationController *wd_mySelfNavigationController = [[BCMNavigationController alloc] initWithRootViewController:self.m_mySelfViewController];
    [wd_mySelfNavigationController setNavigationBarHidden:YES animated:NO];
    [wd_mySelfNavigationController setToolbarHidden:YES animated:NO];

    self.viewControllers = [NSArray arrayWithObjects:wd_homeNavigationController,wd_severNavigationController,wd_mySelfNavigationController,nil];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBar.hidden = YES;
    [self setupViewControllers];
    NSArray *mu_viewArray = [[NSBundle mainBundle] loadNibNamed:@"BCMTabBarView" owner:self options:nil];
    self.m_tabBarView = [mu_viewArray objectAtIndex:0];
    self.m_tabBarView.frame = CGRectMake(0,SCREENHEIGHT-70,SCREENWIDTH,70);
    self.m_tabBarView.m_delegate = self;
    [self.m_tabBarView selectTabAtIndex:0];
    [self.view addSubview:self.m_tabBarView];
    self.selectedIndex=0;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    AppDelegate *wd_appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if([wd_appDelegate isTIFServerInfo])
    {
        [self.m_tabBarView.ui_button2 setImage:[UIImage imageNamed:@"tab_for_tifi_icon.png"] forState:UIControlStateNormal];
        [self.m_tabBarView.ui_button2 setImage:[UIImage imageNamed:@"tab_for_tifi_icon.png"] forState:UIControlStateHighlighted];
        [self.m_tabBarView.ui_button2 setImage:[UIImage imageNamed:@"tab_for_tifi_icon.png"] forState:UIControlStateSelected];
    }
    else
    {
        [self.m_tabBarView.ui_button2 setImage:[UIImage imageNamed:@"no_tifi_sever_icon.png"] forState:UIControlStateNormal];
        [self.m_tabBarView.ui_button2 setImage:[UIImage imageNamed:@"no_tifi_sever_icon.png"] forState:UIControlStateHighlighted];
        [self.m_tabBarView.ui_button2 setImage:[UIImage imageNamed:@"no_tifi_sever_icon.png"] forState:UIControlStateSelected];
    }
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark -
#pragma mark MURootTabBarDelegate

- (void)tabBar:(BCMTabBarView *)tabBar didSelectIndex:(NSInteger)index;
{
    if(index == 1)
    {
        BCMNavigationController *wd_severNavigationController = [[BCMNavigationController alloc] initWithRootViewController:self.m_severViewController];
        [wd_severNavigationController setNavigationBarHidden:YES animated:NO];
        [wd_severNavigationController setToolbarHidden:YES animated:NO];
        [self presentViewController:wd_severNavigationController animated:YES completion:^(void) {
        }];
    }
    else
    {
        self.selectedIndex = index;
    }
    self.m_tabBarView.hidden = NO;
}

- (void)severViewController:(BCMSeverViewController *)tabBar didSelectIndex:(NSInteger)index
{
    [self dismissViewControllerAnimated:YES completion:^(void) {
    }];
    if(index != 1)
    {
        [self.m_tabBarView selectTabAtIndex:index];
    }
    else
    {
        [self.m_tabBarView selectTabAtIndex:self.selectedIndex];
    }
}
@end

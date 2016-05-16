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
#import "GroupViewController.h"
#import "BusinessViewController.h"
#import "BCMPreferentialViewController.h"
#import "CallMeViewController.h"
#import "BCMRecreationViewController.h"
#import "BCMInvestmentViewController.h"
#import "BCMServiceViewController.h"
#import "QueueUpViewController.h"

@interface BCMRootViewController ()<BCMTabBarViewDelegate,BCMSeverViewControllerDelegate>
{
}
@property (weak, nonatomic) IBOutlet UIView *midView;

- (IBAction)actionTopVC:(UIButton *)sender;
- (IBAction)actionButtomVC:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UILabel *labBackName;
@property (weak, nonatomic) IBOutlet UILabel *labCityName;
@property (weak, nonatomic) IBOutlet UIButton *btnMenu;
@property(nonatomic,strong)UIButton *cover;
@end

@implementation BCMRootViewController


@synthesize m_tabBarView;
@synthesize m_homeViewController;
@synthesize m_severViewController;
@synthesize m_mySelfViewController;

- (void)setupViewControllers
{
//    self.tabBar.hidden = YES;
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

//    self.viewControllers = [NSArray arrayWithObjects:wd_homeNavigationController,wd_severNavigationController,wd_mySelfNavigationController,nil];
}

-(void)addRight{


    
    [self.btnMenu addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)click:(UIButton*)btn{
    
    [UIView animateWithDuration:0.5 animations:^{
        self.navigationController.view.frame = CGRectMake(230, 0, self.view.frame.size.width, self.view.bounds.size.height);
    }completion:^(BOOL finished) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button addTarget:self action:@selector(converClick:) forControlEvents:UIControlEventTouchUpInside];
        self.cover = button;
        
        button.frame = CGRectMake(230, 0, self.view.frame.size.width, self.view.bounds.size.height);
        
        [self.navigationController.view.superview addSubview:button];
    }];
}
-(void)converClick:(UIButton*)btn{
    
    [UIView animateWithDuration:0.5 animations:^{
        self.navigationController.view.frame = [UIScreen mainScreen].bounds;
    } completion:^(BOOL finished) {
        [self.cover removeFromSuperview];
    }];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self addRight];
    
//    self.tabBar.hidden = YES;
//    [self setupViewControllers];
//    NSArray *mu_viewArray = [[NSBundle mainBundle] loadNibNamed:@"BCMTabBarView" owner:self options:nil];
//    self.m_tabBarView = [mu_viewArray objectAtIndex:0];
//    self.m_tabBarView.frame = CGRectMake(0,SCREENHEIGHT-70,SCREENWIDTH,70);
//    self.m_tabBarView.m_delegate = self;
//    [self.m_tabBarView selectTabAtIndex:0];
//    [self.view addSubview:self.m_tabBarView];
//    self.selectedIndex=0;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
     [self.navigationController setNavigationBarHidden:YES animated:NO];
//    AppDelegate *wd_appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//    if([wd_appDelegate isTIFServerInfo])
//    {
//        [self.m_tabBarView.ui_button2 setImage:[UIImage imageNamed:@"tab_for_tifi_icon.png"] forState:UIControlStateNormal];
//        [self.m_tabBarView.ui_button2 setImage:[UIImage imageNamed:@"tab_for_tifi_icon.png"] forState:UIControlStateHighlighted];
//        [self.m_tabBarView.ui_button2 setImage:[UIImage imageNamed:@"tab_for_tifi_icon.png"] forState:UIControlStateSelected];
//    }
//    else
//    {
//        [self.m_tabBarView.ui_button2 setImage:[UIImage imageNamed:@"no_tifi_sever_icon.png"] forState:UIControlStateNormal];
//        [self.m_tabBarView.ui_button2 setImage:[UIImage imageNamed:@"no_tifi_sever_icon.png"] forState:UIControlStateHighlighted];
//        [self.m_tabBarView.ui_button2 setImage:[UIImage imageNamed:@"no_tifi_sever_icon.png"] forState:UIControlStateSelected];
//    }
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark -
#pragma mark MURootTabBarDelegate

//- (void)tabBar:(BCMTabBarView *)tabBar didSelectIndex:(NSInteger)index;
//{
//    if(index == 1)
//    {
//        BCMNavigationController *wd_severNavigationController = [[BCMNavigationController alloc] initWithRootViewController:self.m_severViewController];
//        [wd_severNavigationController setNavigationBarHidden:YES animated:NO];
//        [wd_severNavigationController setToolbarHidden:YES animated:NO];
//        [self presentViewController:wd_severNavigationController animated:YES completion:^(void) {
//        }];
//    }
//    else
//    {
////        self.selectedIndex = index;
//    }
//    self.m_tabBarView.hidden = NO;
//}

//- (void)severViewController:(BCMSeverViewController *)tabBar didSelectIndex:(NSInteger)index
//{
//    [self dismissViewControllerAnimated:YES completion:^(void) {
//    }];
//    if(index != 1)
//    {
//        [self.m_tabBarView selectTabAtIndex:index];
//    }
//    else
//    {
//        [self.m_tabBarView selectTabAtIndex:self.selectedIndex];
//    }
//}
- (IBAction)actionBusiness:(UIButton *)sender {
}

- (IBAction)actionGroup:(UIButton *)sender {
}

- (IBAction)actionPhone:(UIButton *)sender {
}
- (IBAction)actionTopVC:(UIButton *)sender {
    switch (sender.tag) {
        case 1001:
            [self moveToBusinessVC];
            break;
        case 1002:
            [self moveToGroupVC];
            break;
            
        case  1003:
            
            [self moveToCallMe];
            break;
        default:
            break;
    }
}

-(void)moveToCallMe{
    CallMeViewController *cellMeVC = [[CallMeViewController alloc]initWithNibName:@"CallMeViewController" bundle:nil];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
    [self.navigationController pushViewController:cellMeVC animated:YES];
}

-(void)moveToBusinessVC{

    
    BCMServiceViewController*businessVC = [[BCMServiceViewController alloc]initWithNibName:@"BCMServiceViewController" bundle:nil];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
    [self.navigationController pushViewController:businessVC animated:YES];

}

-(void)moveToGroupVC{
    
    GroupViewController *groupVC = [[GroupViewController alloc]initWithNibName:@"GroupViewController" bundle:nil];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    [self.navigationController pushViewController:groupVC animated:YES];
    
}

- (IBAction)actionButtomVC:(UIButton *)sender {
     BCMPreferentialViewController *wd_preferentialViewController = [[BCMPreferentialViewController alloc] initWithNibName:@"BCMPreferentialViewController" bundle:nil];
    BCMRecreationViewController *wd_recreationViewController = [[BCMRecreationViewController alloc] initWithNibName:@"BCMRecreationViewController" bundle:nil];
    BCMInvestmentViewController *wd_investmentViewController = [[BCMInvestmentViewController alloc] initWithNibName:@"BCMInvestmentViewController" bundle:nil];
    QueueUpViewController *queueVC = [[QueueUpViewController alloc]initWithNibName:@"QueueUpViewController" bundle:nil];
    switch (sender.tag) {
        case 2003:
            [self.navigationController pushViewController:wd_preferentialViewController animated:YES];
            break;
        case 2004:
            
            [self.navigationController pushViewController:wd_recreationViewController animated:YES];
            break;
        case 2002:
            
            [self.navigationController pushViewController:wd_investmentViewController animated:YES];
            break;
        case 2001:
            
            [self.navigationController setNavigationBarHidden:NO animated:NO];
            [self.navigationController pushViewController:queueVC animated:YES];
            break;
        default:
            break;
    }
}
@end

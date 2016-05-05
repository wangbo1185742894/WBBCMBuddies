//
//  BCMSeverViewController.m
//  BCMBuddies
//
//  Created by 鲁智星 on 16/2/16.
//  Copyright © 2016年 鲁智星. All rights reserved.
//

#import "BCMSeverViewController.h"
#import "BCMRootViewController.h"
#import "BCMDefineFile.h"
#import "BCMScanViewController.h"
#import "BCMPhoneCallViewController.h"

@interface BCMSeverViewController ()<BCMTabBarViewDelegate>

@property (nonatomic,weak) IBOutlet UILabel *ui_messageLabel;
@property (nonatomic,weak) IBOutlet UILabel *ui_label1;
@property (nonatomic,weak) IBOutlet UILabel *ui_label2;
@property (nonatomic,weak) IBOutlet UILabel *ui_label3;
@property (nonatomic,weak) IBOutlet UILabel *ui_label4;
@property (nonatomic,weak) IBOutlet UILabel *ui_label5;
@property (nonatomic,weak) IBOutlet UIButton *ui_button1;
@property (nonatomic,weak) IBOutlet UIButton *ui_button2;
@property (nonatomic,weak) IBOutlet UIButton *ui_button3;
@property (nonatomic,weak) IBOutlet UIButton *ui_button4;
@property (nonatomic,weak) IBOutlet UIButton *ui_button5;
@property (nonatomic,strong) IBOutlet BCMTabBarView *m_tabBarView;

- (IBAction)changeWifiClickAction:(id)sender;
- (IBAction)scanClickAction:(id)sender;
- (IBAction)wifiClickAction:(id)sender;
- (IBAction)callButtonClickAction:(id)sender;

@end

@implementation BCMSeverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.m_tabBarView.m_delegate = self;
    AppDelegate *wd_appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    AppDelegate *wd_appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if([wd_appDelegate isTIFServerInfo])
    {
        [self.m_tabBarView.ui_button2 setImage:[UIImage imageNamed:@"tab_for_tifi_icon.png"] forState:UIControlStateNormal];
        [self.m_tabBarView.ui_button2 setImage:[UIImage imageNamed:@"tab_for_tifi_icon.png"] forState:UIControlStateHighlighted];
        [self.m_tabBarView.ui_button2 setImage:[UIImage imageNamed:@"tab_for_tifi_icon.png"] forState:UIControlStateSelected];
//        [wd_appDelegate initURLPath:@"YES"];
//        [wd_appDelegate showFirstViewController];
    }
    else
    {
        [self.m_tabBarView.ui_button2 setImage:[UIImage imageNamed:@"no_tifi_sever_icon.png"] forState:UIControlStateNormal];
        [self.m_tabBarView.ui_button2 setImage:[UIImage imageNamed:@"no_tifi_sever_icon.png"] forState:UIControlStateHighlighted];
        [self.m_tabBarView.ui_button2 setImage:[UIImage imageNamed:@"no_tifi_sever_icon.png"] forState:UIControlStateSelected];
    }
    
    if([wd_appDelegate isTIFServerInfo])
    {
        self.ui_button1.enabled = YES;
        self.ui_button2.enabled = YES;
        self.ui_button3.enabled = YES;
        self.ui_button4.enabled = YES;
        self.ui_button5.enabled = YES;
        self.ui_button1.alpha = 1.0;
        self.ui_button2.alpha = 1.0;
        self.ui_button3.alpha = 1.0;
        self.ui_button4.alpha = 1.0;
        self.ui_button5.alpha = 1.0;
        self.ui_label1.alpha = 1.0;
        self.ui_label2.alpha = 1.0;
        self.ui_label3.alpha = 1.0;
        self.ui_label4.alpha = 1.0;
        self.ui_label5.alpha = 1.0;
        self.ui_messageLabel.text = @"您已连接场景服务";
    }
    else
    {
        self.ui_button1.enabled = NO;
        self.ui_button2.enabled = NO;
        self.ui_button3.enabled = NO;
        self.ui_button4.enabled = NO;
        self.ui_button5.enabled = NO;
        self.ui_button1.alpha = 0.5;
        self.ui_button2.alpha = 0.5;
        self.ui_button3.alpha = 0.5;
        self.ui_button4.alpha = 0.5;
        self.ui_button5.alpha = 0.5;
        self.ui_label1.alpha = 0.5;
        self.ui_label2.alpha = 0.5;
        self.ui_label3.alpha = 0.5;
        self.ui_label4.alpha = 0.5;
        self.ui_label5.alpha = 0.5;
        self.ui_messageLabel.text = @"您不在场景服务范围内";
    }
    self.ui_label1.text = @"电话叫号";
    self.ui_label2.text = @"移动数据";
    self.ui_label3.text = @"官方wifi";
    self.ui_label4.text = @"扫一扫";
    self.ui_label5.text = @"现场服务";

    BCMRootViewController *mu_rootViewController = (BCMRootViewController *)[[self parentViewController] parentViewController];
    mu_rootViewController.m_tabBarView.frame = CGRectMake(0,SCREENHEIGHT-70,SCREENWIDTH,70);
    mu_rootViewController.m_tabBarView.hidden = NO;
//    if([wd_appDelegate isTIFServerInfo])
//    {
//    }
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    BCMRootViewController *mu_rootViewController = (BCMRootViewController *)[[self parentViewController] parentViewController];
    mu_rootViewController.m_tabBarView.hidden = YES;
}

- (IBAction)changeWifiClickAction:(id)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"prefs:root=WIFI"]];
}
- (IBAction)scanClickAction:(id)sender
{
    BCMScanViewController *wd_scanViewController = [[BCMScanViewController alloc] initWithNibName:@"BCMScanViewController" bundle:nil];
    [self.navigationController presentViewController:wd_scanViewController animated:YES completion:nil];
}
- (IBAction)wifiClickAction:(id)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"prefs:root=WIFI"]];
}

- (IBAction)callButtonClickAction:(id)sender
{
    BCMPhoneCallViewController *wd_phoneCallViewController = [[BCMPhoneCallViewController alloc] initWithNibName:@"BCMPhoneCallViewController" bundle:nil];
    [self.navigationController presentViewController:wd_phoneCallViewController animated:YES completion:nil];
}
- (IBAction)clickWifiSettingAction:(id)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"prefs:root=WIFI"]];
}

#pragma mark -
#pragma mark MURootTabBarDelegate

- (void)tabBar:(BCMTabBarView *)tabBar didSelectIndex:(NSInteger)index;
{
    if ([self.m_delegate respondsToSelector:@selector(severViewController:didSelectIndex:)])
    {
        [self.m_delegate severViewController:self didSelectIndex:index];
    }
}


@end

//
//  BCMInvestmentViewController.m
//  BCMBuddies
//
//  Created by 鲁智星 on 16/2/17.
//  Copyright © 2016年 鲁智星. All rights reserved.
//

#import "BCMInvestmentViewController.h"
#import "BCMGoldViewController.h"
#import "BCMFundViewController.h"
#import "BCMFinancingViewController.h"
#import "BCMDefineFile.h"

@interface BCMInvestmentViewController ()

- (IBAction)backButtonAction:(id)sender;
- (IBAction)button1Action:(id)sender;
- (IBAction)button2Action:(id)sender;
- (IBAction)button3Action:(id)sender;

@end

@implementation BCMInvestmentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)backButtonAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)button1Action:(id)sender
{
    BCMFundViewController *wd_fundViewController = [[BCMFundViewController alloc] initWithNibName:@"BCMFundViewController" bundle:nil];
    [self.navigationController pushViewController:wd_fundViewController animated:YES];
}
- (IBAction)button2Action:(id)sender
{
    BCMGoldViewController *wd_goldViewController = [[BCMGoldViewController alloc] initWithNibName:@"BCMGoldViewController" bundle:nil];
    [self.navigationController pushViewController:wd_goldViewController animated:YES];
}
- (IBAction)button3Action:(id)sender
{
    BCMFinancingViewController *wd_financingViewController = [[BCMFinancingViewController alloc] initWithNibName:@"BCMFinancingViewController" bundle:nil];
    [self.navigationController pushViewController:wd_financingViewController animated:YES];
}
@end

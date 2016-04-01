//
//  BCMPhoneCallViewController.m
//  BCMBuddies
//
//  Created by 鲁智星 on 16/3/21.
//  Copyright © 2016年 鲁智星. All rights reserved.
//

#import "BCMPhoneCallViewController.h"
#import "BCMDrawingNumberViewController.h"

@interface BCMPhoneCallViewController ()

@property (nonatomic,weak) IBOutlet UITextField *ui_phoneNumberTextField;
@property (nonatomic,weak) IBOutlet UITextField *ui_callNumberTextField;
@property (nonatomic,weak) IBOutlet UIButton *ui_phoneCallNumberButton;

- (IBAction)backButtonAction:(id)sender;
- (IBAction)phoneCallButtonAction:(id)sender;

@end

@implementation BCMPhoneCallViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backButtonAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)phoneCallButtonAction:(id)sender
{
    BCMDrawingNumberViewController *wd_drawingNumberViewController = [[BCMDrawingNumberViewController alloc] initWithNibName:@"BCMDrawingNumberViewController" bundle:nil];
    [self.navigationController presentViewController:wd_drawingNumberViewController animated:YES completion:nil];
}
@end

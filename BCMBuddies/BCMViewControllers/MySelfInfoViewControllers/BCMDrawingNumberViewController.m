//
//  BCMDrawingNumberViewController.m
//  BCMBuddies
//
//  Created by 鲁智星 on 16/3/21.
//  Copyright © 2016年 鲁智星. All rights reserved.
//

#import "BCMDrawingNumberViewController.h"
#import "BCMDefineFile.h"

@interface BCMDrawingNumberViewController ()

@property (nonatomic,weak) IBOutlet UILabel *ui_messageLabel;
@property (nonatomic,weak) IBOutlet UILabel *ui_numberLabel;
@property (nonatomic,weak) IBOutlet UIButton *ui_phoneCallNumberButton;
@property (nonatomic,weak) IBOutlet UILabel *ui_infoLabel;

- (IBAction)backButtonAction:(id)sender;
- (IBAction)phoneCallButtonAction:(id)sender;

@end

@implementation BCMDrawingNumberViewController

- (void)initSubViewForStata:(int)index
{
    switch (index) {
        case 1:
        {
            self.ui_messageLabel.text = @"抽号成功！您的业务单号为：";
            self.ui_numberLabel.textColor = RGBA(27,120,216,1.0);
            self.ui_numberLabel.text = @"A1098";
            self.ui_infoLabel.backgroundColor = RGBA(253,104,14,1.0);
            self.ui_infoLabel.text = @"前方排队人数：30人";
            self.ui_phoneCallNumberButton.enabled = YES;
            [self.ui_phoneCallNumberButton setTitle:@"开启电话叫号" forState:UIControlStateNormal];
        }
            break;
        case 2:
        {
            self.ui_messageLabel.text = @"抽号成功！您的业务单号为：";
            self.ui_numberLabel.textColor = RGBA(27,120,216,1.0);
            self.ui_numberLabel.text = @"A1098";
            self.ui_infoLabel.backgroundColor = RGBA(253,104,14,1.0);
            self.ui_infoLabel.text = @"前方排队人数：30人";
            self.ui_phoneCallNumberButton.enabled = NO;
            [self.ui_phoneCallNumberButton setTitle:@"已开启电话叫号" forState:UIControlStateNormal];
        }
            break;
        case 3:
        {
            self.ui_messageLabel.text = @"抽号成功！您的业务单号为：";
            self.ui_numberLabel.textColor = RGBA(124,124,124,1.0);
            self.ui_numberLabel.text = @"A1098";
            self.ui_infoLabel.backgroundColor = RGBA(213,213,213,1.0);
            self.ui_infoLabel.text = @"前方排队人数：0人";
            self.ui_phoneCallNumberButton.enabled = YES;
            [self.ui_phoneCallNumberButton setTitle:@"重新抽号" forState:UIControlStateNormal];
        }
            break;
        default:
            break;
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initSubViewForStata:0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backButtonAction:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)phoneCallButtonAction:(id)sender
{

}


@end

//
//  BCMAboutUsViewController.m
//  BCMBuddies
//
//  Created by 鲁智星 on 16/2/17.
//  Copyright © 2016年 鲁智星. All rights reserved.
//

#import "BCMAboutUsViewController.h"
#import "BCMDefineFile.h"

@interface BCMAboutUsViewController ()

@property (nonatomic,weak) IBOutlet UILabel *ui_textLabel;

- (IBAction)backButtonAction:(id)sender;

@end

@implementation BCMAboutUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.ui_textLabel.text = @"        陕西海创中盈信息技术有限公司，简称“海创中盈”，成立于2012年，是一家致力于应用IT技术、结合互联网优势，推动传统产业快速发展，提升现代生活品质的高科技企业。公司遵循“不断创新，以人为本，经济、社会效益并举”的企业文化和企业管理理念；坚持跟踪全球最新的IT技术，不断提高、完善技术实力。\n       公司自主研制了TFi场景化信息和数字产品现场营销（服务）系统，拥有多项技术专利，TFi系统适用于各种有现场数据传输的应用场景，具有内容定制灵活方便、部署管理统一快速、信息传输方便快速，统计反馈全面准确的特点。";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)backButtonAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end

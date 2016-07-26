//
//  PersonInfoViewController.m
//  BCMBuddies
//
//  Created by 王博 on 16/5/9.
//  Copyright © 2016年 鲁智星. All rights reserved.
//

#import "PersonInfoViewController.h"
#import "OrderViewController.h"

@interface PersonInfoViewController ()

@end

@implementation PersonInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self reloadData];
    self.navigationItem.title = @"一对一服务";
//    self.viewHeight.constant = ;
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)actionQuestion:(UIButton *)sender {
    
    NSString *wd_phoneString = [NSString stringWithFormat:@"tel://%@",self.modelContent.servPhone];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:wd_phoneString]];
}
- (IBAction)actionServce:(UIButton*)sender {
    
    OrderViewController *orderVC = [[OrderViewController alloc ]init];
    orderVC.modelContent = self.modelContent;

    [self.navigationController pushViewController:orderVC animated:YES];
    
}

-(void)reloadData{
    self.imgIcon.defaultImage = [UIImage imageNamed:@"default_image_icon4"];
    AppDelegate *wd_appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSString *wd_picString;
    if([wd_appDelegate isTIFServerInfo])
    {
        NSString *wd_tfiUrlPath = [wd_appDelegate.m_urlPath stringByAppendingFormat:@"%@/%@/%@/",wd_appDelegate.m_appId,self.modelContent.folderId,self.modelContent.id];
        wd_picString = [wd_tfiUrlPath stringByAppendingString:self.modelContent.logo];
    }
    else
    {
        wd_picString = [wd_appDelegate.m_urlPath stringByAppendingString:self.modelContent.logohosturl];
    }
    if(!isStringEmpty(wd_picString))
    {
        NSString *wd_picPath = [BCMToolLib getAPPPicturePath:wd_appDelegate.m_appId depdeptId:wd_appDelegate.m_deptId];
        NSString *wd_lastpath = [wd_picString lastPathComponent];
        NSString *wd_imagePath = [wd_picPath stringByAppendingPathComponent:wd_lastpath];
        [self.imgIcon setUrlAndPath:wd_picString imagePath:wd_imagePath];
    }
    else
    {
        [self.imgIcon setUrlAndPath:nil imagePath:nil];
    }
    NSString *wd_nameString = self.modelContent.servName;
    NSString *wd_servPosition = self.modelContent.servPosition;
    if(isStringEmpty(wd_nameString))
    {
        wd_nameString = @"";
    }
    if(isStringEmpty(wd_servPosition))
    {
        wd_servPosition = @"";
    }
    self.labName.text = [NSString stringWithFormat:@"%@",wd_nameString];
    
    
    self.labServce.text = self.modelContent.servRespbusiness;
    float height = [self.modelContent.servIntroduce boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width-90, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14.5]} context:nil].size.height;
    
    
    self.constraintOfBusinessLabHeght.constant = height;
    self.labHonour.text = self.modelContent.servIntroduce;
    self.labSerClass.text = self.modelContent.servLevel;
    self.labNumberSer.text = self.modelContent.usecount;
    self.labWorkYears.text = self.modelContent.servWorkyears;
    self.labPosition.text = [NSString stringWithFormat:@"职务:%@",self.modelContent.servPosition];
    //    self.ui_nianxianLabel.text = self.m_serviceInfoContent.servWorkyears;
    //    self.ui_yewuInfoLabel.text = self.m_serviceInfoContent.servIntroduce;
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

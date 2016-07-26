//
//  ResverResultViewController.m
//  BCMBuddies
//
//  Created by 王博 on 16/5/16.
//  Copyright © 2016年 鲁智星. All rights reserved.
//

#import "ResverResultViewController.h"

@interface ResverResultViewController ()

@property (nonatomic,strong)GlobalUser *user;

@end

@implementation ResverResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"预约咨询";
    self.viewNoOrder.hidden = YES;
    self.user = [GlobalUser globalUser];
    if (self.user.content ==nil) {
        self.viewNoOrder.hidden = NO;
    }else{
    
        [self reloadDate];
        self.labOrderTime.text = self.user.strOrderTime;
        self.labOrderInfo.text = self.user.strOrderInfo;
    }
    // Do any additional setup after loading the view from its nib.
}

-(void)reloadDate{

    
    self.imgIcon
    .defaultImage = [UIImage imageNamed:@"default_image_icon4"];
    AppDelegate *wd_appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSString *wd_picString;
    if([wd_appDelegate isTIFServerInfo])
    {
        NSString *wd_tfiUrlPath = [wd_appDelegate.m_urlPath stringByAppendingFormat:@"%@/%@/%@/",wd_appDelegate.m_appId,self.user.content.folderId,self.user.content.id];
        wd_picString = [wd_tfiUrlPath stringByAppendingString:self.user.content.logo];
    }
    else
    {
        wd_picString = [wd_appDelegate.m_urlPath stringByAppendingString:self.user.content.logohosturl];
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
    NSString *wd_nameString = self.user.content.servName;
    NSString *wd_servPosition = self.user.content.servPosition;
    if(isStringEmpty(wd_nameString))
    {
        wd_nameString = @"";
    }
    if(isStringEmpty(wd_servPosition))
    {
        wd_servPosition = @"";
    }
    
    
//    self.labSerBusiness.text = self.modelContent.servRespbusiness;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)actionBack:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)actionSure:(UIButton *)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}
@end

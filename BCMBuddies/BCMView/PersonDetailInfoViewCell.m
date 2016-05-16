//
//  PersonDetailInfoViewCell.m
//  BCMBuddies
//
//  Created by 王博 on 16/5/9.
//  Copyright © 2016年 鲁智星. All rights reserved.
//

#import "PersonDetailInfoViewCell.h"
#import "BCMDefineFile.h"
#import "OrderViewController.h"

@implementation PersonDetailInfoViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self = [[[NSBundle mainBundle]loadNibNamed:@"PersonDetailInfoViewCell" owner:nil options:nil] lastObject];
    }
    self.labState.layer.cornerRadius = 10;
    self.labState.layer.masksToBounds = YES;
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)actionQuestion:(UIButton *)sender {
    NSString *wd_phoneString = [NSString stringWithFormat:@"tel://%@",self.modelContent.servPhone];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:wd_phoneString]];
}
- (IBAction)actionServce:(UIButton *)sender {
    OrderViewController *orderVC = [[OrderViewController alloc ]init];
    orderVC.modelContent = self.modelContent;
    [self.controller .navigationController pushViewController:orderVC animated:YES];
    
}


-(void)setStateBackColor:(BOOL)isOnline{

    if (isOnline) {
        self.labState.backgroundColor = RGBA(126,211, 33, 1.0);
    }else{
    
        self.labState.backgroundColor = [UIColor lightGrayColor];
    }

}

-(void)reloadData{
    self.imgIconTitle.defaultImage = [UIImage imageNamed:@"default_image_icon4"];
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
        [self.imgIconTitle setUrlAndPath:wd_picString imagePath:wd_imagePath];
    }
    else
    {
        [self.imgIconTitle setUrlAndPath:nil imagePath:nil];
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
    self.labPosition.text = [NSString stringWithFormat:@"(%@)",wd_servPosition];
    
    self.labWork.text = self.modelContent.servRespbusiness;
//    self.ui_nianxianLabel.text = self.m_serviceInfoContent.servWorkyears;
//    self.ui_yewuInfoLabel.text = self.m_serviceInfoContent.servIntroduce;

}

@end

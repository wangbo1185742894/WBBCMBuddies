//
//  OrderViewController.m
//  BCMBuddies
//
//  Created by 王博 on 16/5/10.
//  Copyright © 2016年 鲁智星. All rights reserved.
//

#import "OrderViewController.h"
#import "BCMToolLib.h"
#import "AppDelegate.h"
#import "BCMDefineFile.h"
#import "LDImageView.h"
#import "UIImage+ImageWithColor.h"



@interface OrderViewController ()
@property(nonatomic,strong)NSDate *selectDate;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *btnSelectDay;

@property(nonatomic,strong)NSString *selectTime;
@property (nonatomic,strong) AppDelegate*delegate;
@property(nonatomic,strong)BCMToolLib *tool;
@property(nonatomic,strong)NSString *dateStr;

@property (weak, nonatomic) IBOutlet LDImageView *imgIcon;
@property (weak, nonatomic) IBOutlet UILabel *labSerBusiness;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *btnSelectTime;

@end

@implementation OrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.btnSelectDate setTitle:@"点击选择预约时间" forState:0];
    self.viewSuccess.hidden = YES;
    
    self.labSerName.text = self.modelContent.servName;
    self.delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    self.selectDate = [NSDate date];
    NSDateFormatter *formater = [[NSDateFormatter alloc]init];
    [formater setDateFormat:@"yyyy-MM-dd"];
    NSString *dateStr = [formater stringFromDate:self.selectDate];
    
    self.dateStr =dateStr;
    [self reloadData];
    
    for (UIButton *button in self.btnSelectDay) {
        [self setBackColor:button];
        if ([button.currentTitle isEqualToString:@"今天"]) {
            button.selected = YES;
        }
        [button addTarget:self action:@selector(actionSelectDay:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    for (UIButton *button in self.btnSelectTime) {
        [self setBackColor:button];
        [button addTarget:self action:@selector(actionSelectSerTime:) forControlEvents:UIControlEventTouchUpInside];
    }
    
}

-(void)actionSelectDay:(UIButton *)btn{
    for (UIButton *btn in self.btnSelectDay) {
        btn.selected = NO;
    }
    btn.selected = YES;
   



}

-(void)actionSelectSerTime:(UIButton *)btn{
    for (UIButton *btn in self.btnSelectTime) {
        btn.selected = NO;
    }
    btn.selected = YES;
    [self.btnSelectDate setTitle:[NSString stringWithFormat:@"预约时间：%@  %@",self.dateStr,btn.currentTitle] forState:0];
    
    self.selectTime = btn.currentTitle;
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



- (IBAction)actionSure:(UIButton *)sender {
    if ([self.btnSelectDate .currentTitle isEqualToString:@"点击选择预约时间"]) {
        [self.delegate alterView:self.view andTitle:@"请您先选择预约时间" isGround:YES];
        [self.delegate hideWithLong:1.7];
    }else{
    self.viewSuccess.hidden = NO;
        
        self.labSerSuccessName.text = self.labSerName.text;
        self.labSuccessInfo.text = [NSString stringWithFormat:@"请于%@   %@前往%@办理业务",self.dateStr,self.selectTime,@"高新科技支行"];
    }
}

- (IBAction)actionBack:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


- (IBAction)actionDateSubmit:(UIButton *)sender {
    self.selectDate = self.picDate.date;
    
    NSDateFormatter *formater = [[NSDateFormatter alloc]init];
    [formater setDateFormat:@"yyyy-MM-dd"];
    NSString *dateStr = [formater stringFromDate:self.selectDate];
    
    self.dateStr =dateStr;
    [self.btnSelectDate setTitle:[NSString stringWithFormat:@"预约时间：%@",self.dateStr] forState:0];
    
}
- (IBAction)actionSuccessSure:(UIButton *)sender {
     [self .navigationController popViewControllerAnimated:YES];
}
-(void)setBackColor:(UIButton *)button{
    [button setBackgroundImage:[UIImage imageWithColor:RGBA(27, 120, 216, 1.0)] forState:UIControlStateSelected];
    [button setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forState:UIControlStateHighlighted];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    button .layer.borderColor = [UIColor lightGrayColor].CGColor;
    button.layer.borderWidth = 1;
    
}


-(void)reloadData{
    self.imgIcon
    .defaultImage = [UIImage imageNamed:@"default_image_icon4"];
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
  
    
    self.labSerBusiness.text = self.modelContent.servRespbusiness;
    //    self.ui_nianxianLabel.text = self.m_serviceInfoContent.servWorkyears;
    //    self.ui_yewuInfoLabel.text = self.m_serviceInfoContent.servIntroduce;
    
}
@end

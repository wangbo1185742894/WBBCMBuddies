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
#import "ResverResultViewController.h"

#import "LoadData.h"
#import "ModOrderList.h"
#import "ModSerDate.h"


@interface OrderViewController ()
@property(nonatomic,strong)NSDate *selectDate;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *btnSelectDay;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *selectViewHeight;
@property(nonatomic,strong)NSString *selectTime;
@property (nonatomic,strong) AppDelegate*delegate;
@property(nonatomic,strong)BCMToolLib *tool;
@property(nonatomic,strong)NSString *dateStr;
@property(nonatomic,strong)GlobalUser *user;
@property (weak, nonatomic) IBOutlet UIView *viewSelectTime;

@property (weak, nonatomic) IBOutlet LDImageView *imgIcon;
@property (weak, nonatomic) IBOutlet UILabel *labSerBusiness;
@property (strong, nonatomic) NSMutableArray *btnSelectTime;
@property(nonatomic,assign) NSInteger selectDay;
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,strong)LoadData *loadData;

@property(nonatomic,strong)NSMutableData *mdata;
@end

@implementation OrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"预约咨询";
    self.dataArray = [[NSMutableArray alloc]init];
    self.btnSelectTime = [[NSMutableArray alloc]init];
    self.user = [GlobalUser globalUser];
    self.labSerName.text = self.modelContent==nil?self.serName:self.modelContent.servName;
    self.delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    self.selectDay = 0;
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
    
    [self.delegate initURLPath:[self.delegate isTIFServerInfo]?@"YES":@"NO"];
    NSString *strUrl;
    if ([self.delegate.m_isTFI isEqualToString:@"NO"]) {
         strUrl = [NSString stringWithFormat:@"%@/QueuingReminder/serv_serverResList?userId=%@",self.delegate.m_urlPath,self.userID];
    }else{
    
        strUrl = [NSString stringWithFormat:@"%@%@/QueuingReminder/serv_serverResList?userId=%@",self.delegate.m_urlPath,self.delegate.m_appId,self.userID];

    }
    
   
    NSDictionary *para = @{@"serverName":self.modelContent==nil?self.serName:self.modelContent.servName};
    
    self.loadData = [LoadData singleLoadData];
    
    
    
    [self.loadData requsetWithString:strUrl isPost:NO andPara:para andComplete:^(id data, BOOL isSuccess) {
       
        NSDictionary *tempDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        NSArray *array= tempDic[@"data"];
        
        NSString *gb2312Name = [self.modelContent==nil?self.serName:self.modelContent.servName stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
    
        if ([self.delegate isTIFServerInfo]) {
            
            NSString *str =[NSString stringWithFormat:@"http://192.168.1.2:12202/QueuingReminder/serv_serverResList?userId=%@&serverName=%@",self.userID,gb2312Name];
            NSData *data1 = [[NSData alloc]initWithContentsOfURL:[NSURL URLWithString:str]];
            
            NSString *strtest = [[NSString alloc]initWithData:data1 encoding:NSUTF8StringEncoding];
            while ([strtest isEqualToString:@"false"]) {
                NSData *data1 = [[NSData alloc]initWithContentsOfURL:[NSURL URLWithString:str]];
                
                NSString *strtest = [[NSString alloc]initWithData:data1 encoding:NSUTF8StringEncoding];
            }
            
           array = [NSJSONSerialization JSONObjectWithData:data1 options:NSJSONReadingMutableLeaves error:nil];
        }

       
        NSDateFormatter *forMatter = [[NSDateFormatter alloc]init];
        [forMatter setDateFormat:@"HH:mm"];
        NSDate *curDate = [NSDate date];
        NSString *dateStr = [forMatter stringFromDate:curDate];
       
        NSDateFormatter *forMatterd = [[NSDateFormatter alloc]init];
        [forMatterd setDateFormat:@"yyyy-MM-dd"];
        NSDate *curDay = [NSDate date];
        NSString *dateStrd = [forMatterd stringFromDate:curDay];
        
        NSInteger hour = [[[dateStr componentsSeparatedByString:@":"] firstObject] integerValue];
        NSInteger minte = [[[dateStr componentsSeparatedByString:@":"] lastObject] integerValue];
        NSInteger dayc = [[[dateStrd componentsSeparatedByString:@"-"] lastObject] integerValue];
        
        for (NSDictionary *dic in array) {
            ModSerDate *date = [[ModSerDate alloc]initWithDic:dic];
            
            NSString *time = date.resTime;
            NSInteger hourm = [[[time componentsSeparatedByString:@":"] firstObject] integerValue];
            NSInteger mintem = [[[time componentsSeparatedByString:@":"] lastObject] integerValue];
            NSInteger day = [[[date.resDate componentsSeparatedByString:@"-"] lastObject] integerValue];
            if (day == dayc) {
                if (hourm>hour) {
                    [self.dataArray addObject:date];
                }else if(hourm==hour){
                    
                    if (mintem>minte) {
                        [self.dataArray addObject:date];
                    }
                }
            }else{
            
                [self.dataArray addObject:date];
            
            }
            
            
        }

        
        [self refreshTimeInfo];
        
    }];
    
}

-(void)refreshTimeInfo{

    CGFloat curX = 20;
    CGFloat curY = 100;
    CGFloat marginx = 10;
    CGFloat marginy = 15;
    CGFloat height = 35;
    CGFloat width = (MainWidth - 60)/3;
    
    UIButton *lastBtn;
    int n=0;
    int m = 0;
    for (UIButton *btn in self.btnSelectTime) {
        [btn removeFromSuperview];
    }
    for (int i = 0; i<self.dataArray.count;i++) {
        UIButton *btn ;
        ModSerDate *serDate = self.dataArray[i];
        
        
        NSDateFormatter *forMatterd = [[NSDateFormatter alloc]init];
        [forMatterd setDateFormat:@"yyyy-MM-dd"];
        NSDate *curDay = [NSDate date];
        NSString *dateStrd = [forMatterd stringFromDate:curDay];
        NSInteger dayc = [[[dateStrd componentsSeparatedByString:@"-"] lastObject] integerValue];
        
        NSInteger day = [[[serDate.resDate componentsSeparatedByString:@"-"] lastObject] integerValue];
        
        if (self.selectDay == 0) {
            if (dayc == day) {
                btn = [UIButton buttonWithType:UIButtonTypeCustom];
                btn.frame = CGRectMake(curX + (n%3)*(marginx+width), curY + (n/3)*(height + marginy), width, height);
                
                [self setBackColor:btn];
                [self.viewSelectTime addSubview: btn];
                n++;
            }
        }else if(self.selectDay == 1){
        
            if (dayc != day) {
                btn = [UIButton buttonWithType:UIButtonTypeCustom];
                btn.frame = CGRectMake(curX + (m%3)*(marginx+width), curY + (m/3)*(height + marginy), width, height);
                
                [self setBackColor:btn];
                [self.viewSelectTime addSubview: btn];
                m++;
            }
        }
         if (btn !=nil) {
        
        [btn setTitle:serDate.resTime forState:UIControlStateNormal];
        NSString *status = [NSString stringWithFormat:@"%@",serDate.status];
        btn.enabled = [status isEqualToString:@"0"];
        btn.backgroundColor = [UIColor whiteColor];
        if (btn.enabled==NO) {
            btn.titleLabel.numberOfLines = 0;
           [btn setTitle:[NSString stringWithFormat:@"%@\n已预约",serDate.resTime] forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:13];
        }
        
        
        [btn addTarget:self action:@selector(actionSelectSerTime:) forControlEvents:UIControlEventTouchUpInside];
        lastBtn = btn;
       
              [self.btnSelectTime addObject:btn];
        }
      
    }

    
    self.selectViewHeight.constant = lastBtn.mj_y + lastBtn.mj_h +20>85?lastBtn.mj_y + lastBtn.mj_h +20:85;
    

}

-(void)actionSelectDay:(UIButton *)btn{
    for (UIButton *btn in self.btnSelectDay) {
        btn.selected = NO;
    }
    
    self.selectDay = btn.tag - 2100;
    ModSerDate *dateMod = self.dataArray[self.selectDay];
    self.dateStr = dateMod.resDate;
    btn.selected = YES;
    [self refreshTimeInfo];
}

-(void)actionSelectSerTime:(UIButton *)btn{
    BOOL isSelect = btn.selected;
    for (UIButton *btn in self.btnSelectTime) {
        btn.selected = NO;
    }
    btn.selected = !isSelect;
    
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
//    self.viewSuccess.hidden = NO;
//        
//        self.labSerSuccessName.text = self.labSerName.text;
//        self.labSuccessInfo.text = [NSString stringWithFormat:@"请于%@   %@前往%@办理业务",self.dateStr,self.selectTime,@"高新科技支行"];
    
    if (self.selectTime == nil ||[self.selectTime isEqualToString:@""]) {
        [self.delegate alterView:self.view andTitle:@"请选择预约时间" isGround:YES];
        [self.delegate hideWithLong:1.7];
        return;
    }
    
    NSDictionary *dic = @{@"userId":self.userID,@"serverName":self.modelContent.name,@"resDate":self.dateStr,@"resTime":self.selectTime,@"customerTel":self.modelContent.servPhone};
    
     NSString  *resStr = [NSString stringWithFormat:@"%@/QueuingReminder/serv_subReseration?userId=%@",self.delegate.m_urlPath,self.userID];
    if ([self.delegate isTIFServerInfo]) {
        resStr = [NSString stringWithFormat:@"%@%@/QueuingReminder/serv_subReseration?userId=%@",self.delegate.m_urlPath,self.delegate.m_appId,self.userID];
    }
   
//    serverUrl+="?userId=100&serverName="+serverName+"&resDate="+resDate+"&resTime="+resTime+"&customerTel="+customerTel
    [self.loadData requsetWithString:resStr isPost:YES andPara:dic andComplete:^(id data, BOOL isSuccess) {
       
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        
        ResverResultViewController *reseverVC = [[ResverResultViewController alloc]init];
        
        if (self.selectTime == nil || [self.selectTime isEqualToString:@""]) {
            [self.delegate alterView:self.view andTitle:@"请您先选择预约时间" isGround:YES];
            [self.delegate hideWithLong:1.7];
        }
        self.user.content = self.modelContent;
        self.user.strOrderTime = [NSString stringWithFormat:@"请于%@   %@前往%@办理业务",self.dateStr,self.selectTime,self.user.curBank.name];
        self.user.strOrderInfo = [NSString stringWithFormat:@"您已成功预约  %@",self.modelContent.servName];
        [self.navigationController pushViewController:reseverVC animated:YES];
        ModOrderList *order = [[ModOrderList alloc]initWithTitle:[NSString stringWithFormat:@"您已成功预约  %@",self.modelContent.servName] andInfo:[NSString stringWithFormat:@"请于%@   %@前往%@办理业务",self.dateStr,self.selectTime,self.user.curBank.name]];
        
        if (self.user.orderDateArray == nil) {
            self.user.orderDateArray = [[NSMutableArray alloc]init];
        }
        [self.user.orderDateArray addObject:order];
        
    }];
  
    
}

- (IBAction)actionBack:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


- (IBAction)actionDateSubmit:(UIButton *)sender {
//    self.selectDate = self.picDate.date;
    
    NSDateFormatter *formater = [[NSDateFormatter alloc]init];
    [formater setDateFormat:@"yyyy-MM-dd"];
    NSString *dateStr = [formater stringFromDate:self.selectDate];
    
    self.dateStr =dateStr;
    
}
-(void)setBackColor:(UIButton *)button{
    [button setTitleColor:RGBA(72, 72, 72, 1.0) forState:UIControlStateNormal];
    [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
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
    if (self.modelContent != nil) {
        
    
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
    
}


-(void)request: (NSString*)httpUrl withHttpArg: (NSString*)HttpArg  {
    
    NSString *urlStr = [[NSString alloc]initWithFormat: @"%@?%@", httpUrl,HttpArg];
    NSURL *url = [NSURL URLWithString: urlStr];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    
    [request setHTTPMethod: @"GET"];
    
    
    [[NSURLConnection connectionWithRequest:request delegate:self] start];

}



@end

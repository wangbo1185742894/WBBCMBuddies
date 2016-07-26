//
//  SubmitPhoneNumberViewController.m
//  BCMBuddies
//
//  Created by 王博 on 16/5/19.
//  Copyright © 2016年 鲁智星. All rights reserved.
//

#import "SubmitPhoneNumberViewController.h"
#import "UIImage+ImageWithColor.h"
#import "ResultInfoViewController.h"
#import "LoadData.h"
#import "ModRootVCQueue.h"
#import "GlobalUser.h"

@interface SubmitPhoneNumberViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIButton *time1;
@property (weak, nonatomic) IBOutlet UIButton *time2;
@property (weak, nonatomic) IBOutlet UIButton *time3;
@property (weak, nonatomic) IBOutlet UILabel *labOpenCallMe;

@property (weak,nonatomic)AppDelegate *delegate;
@property(nonatomic,strong)LoadData *loadData;

@end

@implementation SubmitPhoneNumberViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    self.loadData = [LoadData singleLoadData];
  
    self.title = @"到号提醒";
    [self.swiTFI setOn:self.on];
    self.labMyPhoneNumber.delegate = self;
 
    
    self.labMyNumber.text = [NSString stringWithFormat:@"我的抽号：%@", self.user.personNumber];
    

    NSString *type = [self.user.personNumber substringToIndex:1];
    
    NSString *number = [self.user.personNumber substringWithRange:NSMakeRange(1, self.user.personNumber.length-1)];
    self.user.isOpenPhone = NO;
 
    
    NSDictionary *myDic;
    for (ModRootVCQueue *queue in self.user.dataArray) {
        if ([queue.codeType isEqualToString:type]) {
            
            if (queue.codeList.count!=0) {
                myDic = queue.codeList[self.user.selectIndex];
                self.labMyOrderInfo.text = [NSString stringWithFormat:@"预计%@分钟到我,前方%lu人等待",myDic[@"waitTime"],self.user.selectIndex];
                [self setBtnWaitTime:[myDic[@"waitTime"] integerValue]];
                break;
            }
            
        }
    }
    
    for (UIButton *button in _btnsTime) {
        
        [self setBackColor:button];
        if ([button.currentTitle isEqualToString:self.user.strRemmber]) {
            button.selected = YES;
        }
        
    }
    NSString *waitTime = myDic[@"waitTime"];
    if ([self.user.strRemmber integerValue]>[waitTime integerValue]) {
        self.user.callMeinfo = [NSString stringWithFormat:@"%@,\n马上到你，请留意柜台叫号",self.labMyOrderInfo.text];
    }else{
        self.user.callMeinfo = [NSString stringWithFormat:@"%@,\n未开启电话叫号",self.labMyOrderInfo.text];
    
    }
    
    
    
    // Do any additional setup after loading the view from its nib.
}

-(void)setBtnWaitTime:(NSInteger)waitTime{

    if (waitTime >20) {
        
        [self.time3 setTitle:@"20分钟" forState:0];
        [self.time2 setTitle:@"15分钟" forState:0];
        [self.time1 setTitle:@"10分钟" forState:0];
        
        
    }else if (waitTime>15){
        [self.time3 setTitle:@"15分钟" forState:0];
        [self.time2 setTitle:@"10分钟" forState:0];
        [self.time1 setTitle:@"5分钟" forState:0];
    }else if (waitTime>10){
    
        [self.time3 setTitle:@"9分钟" forState:0];
        [self.time2 setTitle:@"6分钟" forState:0];
        [self.time1 setTitle:@"3分钟" forState:0];
    
    }
    
    self.user.strRemmber = self.time1.currentTitle;

}

-(void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    self.labOpenCallMe.hidden = [self.delegate isTIFServerInfo];

}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{

    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (range.length == 1) {
        return YES;
    }
    
    if (range.location == 11) {
        return NO;
    }
    
    NSString * regex;
    regex = @"^[0-9]";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:string];
    if (!isMatch) {
        return NO;
    }
    return YES;
}


- (IBAction)ActionSelectWIfi:(UISwitch *)sender {
    if (sender.isOn) {
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"prefs:root=WIFI"]];
    }
}


-(void)setBackColor:(UIButton *)button{
    [button setBackgroundImage:[UIImage imageWithColor:RGBA(27, 120, 216, 1.0)] forState:UIControlStateSelected];
    [button setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forState:UIControlStateHighlighted];
    
}

- (IBAction)actionSelectTime:(UIButton *)sender {
    
    for (UIButton  *button in self.btnsTime) {
        [button setSelected:NO] ;
    }
    self.user.strRemmber = sender.currentTitle;
    [sender setSelected:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)actionBack:(UIButton *)sender{

    [self.navigationController popViewControllerAnimated:YES];

}

-(void)actionOpenCallMe:(UIButton *)sender{

    
    
    NSString *requserUrl = [NSString stringWithFormat:@"%@/QueuingReminder/serv_customerCodeInfo",self.delegate.m_urlPath];
    
//    if ([self.delegate isTIFServerInfo]) {
//        [self.delegate initURLPath:@"YES"];
        requserUrl = [NSString stringWithFormat:@"%@/QueuingReminder/serv_customerCodeInfo?customerTel=%@",self.delegate.m_urlPath,self.labMyPhoneNumber.text];
//    }else{
//    
//        [self.delegate alterView:self.view andTitle:@"请您先连接TFI，再开启到号提醒" isGround:YES];
//        [self.delegate hideWithLong:1.7];
//        return;
//    
//    }
    NSString *type = [self.user.personNumber substringToIndex:1];
    
    NSString *number = [self.user.personNumber substringWithRange:NSMakeRange(2, self.user.personNumber.length-2)];
    
   number = [@"0" stringByAppendingString:number];
    
    if (self.labMyPhoneNumber.text.length ==0) {
        [self.delegate alterView:self.view andTitle:@"请输入手机号" isGround:YES];
        [self.delegate hideWithLong:1.7];
        return;
    }
    
    NSString * regex;
    regex = @"^((13[0-9])|(147)|(15[^4,\\D])|(17[^4,\\D])|(18[0-9]))\\d{8}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:self.labMyPhoneNumber.text];
    
    if (!isMatch) {
        [self.delegate alterView:self.view andTitle:@"请输入合法的手机号" isGround:YES];
        [self.delegate hideWithLong:1.7];
        return;
    }
    
    NSInteger minte= [self.user.strRemmber integerValue];
    NSDictionary *para = @{@"codeType":type,@"codeNumber":number,@"preServiceTime":@"",@"customerTel":self.labMyPhoneNumber.text,@"preInformTime":@(minte),@"userId":self.userID};
    
    [self.loadData requsetWithString:requserUrl isPost:YES andPara:para andComplete:^(id data, BOOL isSuccess) {
        NSDictionary *dic1;
        
        if ([self.delegate isTIFServerInfo]) {
        
            if (isSuccess) {
                NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
//                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
//                if (dic1 == nil) {
//                    [self.delegate alterView:self.view andTitle:@"开启失败" isGround:YES];
//                    [self.delegate hideWithLong:1.7];
//                    return ;
//                }
                
                 self.user.callMeinfo = [NSString stringWithFormat:@"%@,\n提前%@叫我",self.labMyOrderInfo.text,self.user.strRemmber];
                self.user.personNumber = self.strNumber;
                
                [self.navigationController popToRootViewControllerAnimated:YES];
               self.user.isOpenPhone = YES;
            }else{
            
                [self.delegate alterView:self.view andTitle:@"开启失败" isGround:YES];
                [self.delegate hideWithLong:1.7];
            
                return;
            }
            
        }
        else{
            self.user.callMeinfo = [NSString stringWithFormat:@"%@,\n提前%@叫我",self.labMyOrderInfo.text,self.user.strRemmber];
            if (self.strNumber != nil && ![self.strNumber isEqualToString:@""]) {
                self.user.personNumber = self.strNumber;
            }
            
            [self.navigationController popToRootViewControllerAnimated:YES];
            self.user.isOpenPhone = YES;
        }
        

        
        
//        resultVC.strNumber = self.strNumber
//        ;
//        resultVC.strMember = self.rememberStr;
//        self.user.personNumber = self.strNumber;
        
        
    }];
    
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

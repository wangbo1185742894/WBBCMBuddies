//
//  ListenViewController.m
//  BCMBuddies
//
//  Created by 王博 on 16/7/4.
//  Copyright © 2016年 鲁智星. All rights reserved.
//

#import "ListenViewController.h"

@interface ListenViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *labNumber;
@property (weak, nonatomic) IBOutlet UILabel *labWaitInfo;
@property (weak, nonatomic) IBOutlet UILabel *labInfo;
@property(strong,nonatomic) AppDelegate *delegate;
@property (weak, nonatomic) IBOutlet UITextField *txtPhoneNumber;
@end

@implementation ListenViewController
- (IBAction)actionOpen:(UIButton *)sender {
    if (self.txtPhoneNumber.text.length ==0) {
        [self.delegate alterView:self.view andTitle:@"请输入手机号" isGround:YES];
        [self.delegate hideWithLong:1.7];
        return;
    }
    
    NSString * regex;
    regex = @"^((13[0-9])|(147)|(15[^4,\\D])|(17[^4,\\D])|(18[0-9]))\\d{8}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:self.txtPhoneNumber.text];
    
    if (!isMatch) {
        [self.delegate alterView:self.view andTitle:@"请输入合法的手机号" isGround:YES];
        [self.delegate hideWithLong:1.7];
        return;
    }

    
    
            NSString * requserUrl = [NSString stringWithFormat:@"%@/QueuingReminder/serv_setSceneListenNum",self.delegate.m_urlPath];
    
            NSString *codeType = [self.user.personNumber substringToIndex:1];
            NSString *number = [ NSString stringWithFormat:@"0%@",[self.user.personNumber substringFromIndex:2]];
            NSDictionary *para = @{@"codeType":[codeType substringToIndex:1],@"callNum":number,@"phoneNo":self.txtPhoneNumber.text,@"userId":self.userID};
    
            [self.loadData requsetWithString:requserUrl isPost:YES andPara:para andComplete:^(id data, BOOL isSuccess) {
    
    
                NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    
    //           开启
                [self.delegate alterView:self.view andTitle:@"开启成功" isGround:YES];
                [self.delegate hideWithLong:1.7];
                
                self.user.callMeinfo = [NSString stringWithFormat:@"%@,\n%@",self.user.callMeinfo,@"已开启现场听号"];
    
                self.user.isOpenPhone = YES;
                [self.navigationController popToRootViewControllerAnimated:YES];
               return;
            }];
    
}
- (IBAction)actionBack:(UIButton *)sender {
    
    self.user.callMeinfo = [NSString stringWithFormat:@"%@,\n%@",self.user.callMeinfo,@"未开启现场听号"];
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
     self.delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    self.title = @"现场听号";
    self.labNumber.text = self.user.personNumber;

    self.labWaitInfo.text = self.user.callMeinfo;
    self.txtPhoneNumber .delegate = self;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 44, 44);
    [button setImage:[UIImage imageNamed:@"back_icon.png"] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    
    self.wd_delegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    self.loadData = [LoadData singleLoadData];
    [button addTarget:self action:@selector(actionBack:) forControlEvents:UIControlEventTouchUpInside];

    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField{

    [textField resignFirstResponder];
    return YES;

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

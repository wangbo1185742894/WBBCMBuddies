//
//  ResultInfoViewController.m
//  BCMBuddies
//
//  Created by 王博 on 16/5/19.
//  Copyright © 2016年 鲁智星. All rights reserved.
//

#import "ResultInfoViewController.h"


#import "ModRootVCQueue.h"
@interface ResultInfoViewController ()



@end

@implementation ResultInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"到号提醒";
    

    
    
    
    [self.swiTFI setOn:self.on];
    
    NSArray *strArray = [self.user.callMeinfo componentsSeparatedByString:@","];
    NSString *lastInfo = [strArray lastObject];
    
    if ([lastInfo isEqualToString:@"\n未开启电话叫号"]) {
        self.labMyOrderInfoOnfInfo.text = [NSString stringWithFormat:@"%@,%@,\n%@",strArray[1],strArray[0],@"马上到您办理，请留意电话叫号"];
    }else{
        self.labMyOrderInfoOnfInfo.text = self.user.callMeinfo;
        
        self.user.callMeinfo = self.labMyOrderInfoOnfInfo.text;
        
    }
    
    self.labMyNumberInfo.text = [NSString stringWithFormat:@"%@", self.user.personNumber];
    NSString *type = [self.user.personNumber substringToIndex:2];
    
//    for (ModRootVCQueue *queue in self.gUser.dataArray) {
//        if ([queue.codeType isEqualToString:type]) {
//            self.labMyOrderInfoOnfInfo.text = [NSString stringWithFormat:@"前方%lu人等待，预计%@分钟到你\n%@分钟以后通知你",(unsigned long)queue.codeList.count,queue.preServiceTime,self.gUser.waitDic[@"waitTime"]==nil?self.strMember:self.gUser.waitDic[@"waitTime"]];
//            break;
//        }
//    }
//    
 
    // Do any additional setup after loading the view from its nib.
}


- (IBAction)ActionSelectWIfi:(UISwitch *)sender {
    if (sender.isOn) {
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"prefs:root=WIFI"]];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)actionCloseCallMe:(UIButton *)sender{

     [self.navigationController popViewControllerAnimated:YES];
  
    self.user.callMeinfo = @"";
}

- (IBAction)actionBackInfo:(UIButton *)sender{
  [self.navigationController popToRootViewControllerAnimated:YES];
   

}

-(void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    [self.swiTFI setOn:[self.wd_delegate isTIFServerInfo]];

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
